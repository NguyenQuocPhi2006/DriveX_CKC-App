import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_spp_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'more_settings.dart';

// Kết nối đang mở (toàn cục) - dùng cho Sen_Bluetooth_String ở mọi file
BluetoothConnection? globalConnection;
BluetoothDevice? globalConnectedDevice;

class Bluetooth_Classic extends StatefulWidget {
  const Bluetooth_Classic({super.key});

  @override
  State<Bluetooth_Classic> createState() => _Bluetooth_ClassicState();
}

class _Bluetooth_ClassicState extends State<Bluetooth_Classic> {
  final Map<String, BluetoothDevice> _devices = {}; // key = địa chỉ MAC
  final Map<String, int> _rssi = {};
  bool _isScanning = false;
  BluetoothDevice? _connectedDevice;
  StreamSubscription<BluetoothDiscoveryResult>? _discoverySubscription;

  // Sử dụng font chữ Inter
  final String selectedFont = 'Inter';

  @override
  void initState() {
    super.initState();

    // Quay lại trang khi đang có kết nối sẵn thì hiện đúng trạng thái
    if (globalConnection?.isConnected == true) {
      _connectedDevice = globalConnectedDevice;
    }

    _initBluetooth();
  }

  Future<void> _requestPermissions() async {
    final statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();
    debugPrint('Quyền Bluetooth Classic: $statuses');
  }

  @override
  void dispose() {
    // Không đóng kết nối ở đây để các file khác vẫn gửi dữ liệu được
    _discoverySubscription?.cancel();
    if (_isScanning) {
      FlutterBluetoothSerial.instance.cancelDiscovery();
    }
    super.dispose();
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(fontFamily: selectedFont))),
    );
  }

  // Bật Bluetooth (nếu đang tắt) và nạp danh sách thiết bị đã ghép cặp
  Future<void> _initBluetooth() async {
    try {
      final enabled = await FlutterBluetoothSerial.instance.isEnabled ?? false;
      if (!enabled) {
        await FlutterBluetoothSerial.instance.requestEnable();
      }
      await _loadBondedDevices();
    } catch (e) {
      debugPrint("Lỗi khởi tạo Bluetooth: $e");
    }
  }

  // Các thiết bị đã ghép cặp (ESP32 đã pair trong cài đặt điện thoại sẽ hiện ở đây)
  Future<void> _loadBondedDevices() async {
    final bonded = await FlutterBluetoothSerial.instance.getBondedDevices();
    if (!mounted) return;
    setState(() {
      for (final d in bonded) {
        _devices[d.address] = d;
      }
    });
  }

  // Lấy tên thiết bị
  String _getDeviceName(BluetoothDevice d) {
    final name = d.name;
    if (name != null && name.isNotEmpty) return name;
    return 'Thiết bị ẩn danh';
  }

  // ESP32 lên đầu, rồi tới thiết bị đã ghép cặp, rồi theo sóng mạnh
  List<BluetoothDevice> _sortedDevices() {
    int score(BluetoothDevice d) {
      if (d.isBonded) return 1;
      return 2;
    }

    final list = _devices.values.toList();
    list.sort((a, b) {
      final s = score(a).compareTo(score(b));
      if (s != 0) return s;
      return (_rssi[b.address] ?? -999).compareTo(_rssi[a.address] ?? -999);
    });
    return list;
  }

  // Hàm bắt đầu quét thiết bị
  Future<void> _startScan() async {
    try {
      await _requestPermissions();
      await _discoverySubscription?.cancel();
      setState(() {
        _isScanning = true;
      });
      await _loadBondedDevices();

      _discoverySubscription =
          FlutterBluetoothSerial.instance.startDiscovery().listen(
        (result) {
          if (!mounted) return;
          setState(() {
            _devices[result.device.address] = result.device;
            _rssi[result.device.address] = result.rssi;
          });
        },
        onDone: () {
          if (!mounted) return;
          setState(() {
            _isScanning = false;
          });
        },
        onError: (e) {
          debugPrint("Lỗi quét Bluetooth: $e");
          if (!mounted) return;
          setState(() {
            _isScanning = false;
          });
        },
      );
    } catch (e) {
      debugPrint("Lỗi quét Bluetooth: $e");
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    }
  }

  // Hàm dừng quét
  Future<void> _stopScan() async {
    await _discoverySubscription?.cancel();
    try {
      await FlutterBluetoothSerial.instance.cancelDiscovery();
    } catch (e) {
      debugPrint("Lỗi dừng quét: $e");
    }
    if (!mounted) return;
    setState(() {
      _isScanning = false;
    });
  }

  // Hàm kết nối với thiết bị được chọn (ví dụ ESP32)
  Future<void> _connectToDevice(BluetoothDevice device, String name) async {
    // Dừng quét trước khi kết nối
    await _stopScan();
    if (!mounted) return;

    try {
      _snack('Đang kết nối tới ${name.isNotEmpty ? name : "Thiết bị"}...');

      // Bluetooth Classic cần ghép cặp trước
      if (!device.isBonded) {
        final bonded = await FlutterBluetoothSerial.instance
            .bondDeviceAtAddress(device.address);
        if (bonded != true) {
          _snack('Ghép cặp thất bại.');
          return;
        }
      }

      final connection = await BluetoothConnection.toAddress(device.address);

      if (!mounted) {
        globalConnection = connection;
        globalConnectedDevice = device;
        return;
      }

      globalConnection = connection;
      globalConnectedDevice = device;
      setState(() {
        _connectedDevice = device;
      });

      // Stream input kết thúc (onDone) khi kết nối bị ngắt
      connection.input?.listen((Uint8List data) {
        debugPrint('Nhận từ ESP32: ${utf8.decode(data, allowMalformed: true)}');
      }).onDone(() {
        globalConnection = null;
        globalConnectedDevice = null;
        if (!mounted) return;
        setState(() {
          _connectedDevice = null;
        });
        _snack('Đã ngắt kết nối với thiết bị.');
      });

      _snack('Kết nối thành công!');
    } catch (e) {
      debugPrint("Lỗi kết nối: $e");
      _snack('Kết nối thất bại: $e');
    }
  }

  // Hàm ngắt kết nối
  Future<void> _disconnectDevice() async {
    try {
      await globalConnection?.close();
    } catch (e) {
      debugPrint("Lỗi ngắt kết nối: $e");
    }
    globalConnection = null;
    globalConnectedDevice = null;
    if (!mounted) return;
    setState(() {
      _connectedDevice = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final devices = _sortedDevices();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bluetooth Classic',
          style: TextStyle(fontFamily: selectedFont),
        ),
        actions: [
          // Nút Quét / Dừng quét
          IconButton(
            icon: Icon(_isScanning ? Icons.stop : Icons.search),
            onPressed: _isScanning ? _stopScan : _startScan,
          ),
        ],
      ),
      body: Column(
        children: [
          // Trạng thái kết nối hiện tại
          if (_connectedDevice != null)
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.green.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Đã kết nối: ${_getDeviceName(_connectedDevice!)}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: selectedFont, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _disconnectDevice,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Ngắt kết nối', style: TextStyle(color: Colors.white, fontFamily: selectedFont)),
                  ),
                ],
              ),
            ),

          // Danh sách các thiết bị tìm thấy
          Expanded(
            child: devices.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        _isScanning
                            ? 'Đang tìm kiếm thiết bị ESP32...'
                            : 'Nhấn nút kính lúp để quét thiết bị Bluetooth',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontFamily: selectedFont, color: Colors.grey),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      final deviceName = _getDeviceName(device);
                      final rssi = _rssi[device.address];

                      return ListTile(
                        title: Text(deviceName, style: TextStyle(fontFamily: selectedFont, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          '${device.address}'
                          '${rssi != null ? "  •  $rssi dBm" : ""}'
                          '${device.isBonded ? "  •  Đã ghép cặp" : ""}',
                          style: TextStyle(fontFamily: selectedFont),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () => _connectToDevice(device, deviceName),
                          child: Text('Kết nối', style: TextStyle(fontFamily: selectedFont)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ===== Gửi String qua Bluetooth tới ESP32 (dùng được ở mọi file) =====
Future<bool> Sen_Bluetooth_String(String data) async {
  final connection = globalConnection;

  if (connection == null || !connection.isConnected) {
    debugPrint('Sen_Bluetooth_String: chưa kết nối thiết bị nào.');
    return false;
  }

  try {
    connection.output.add(Uint8List.fromList(utf8.encode('$data\n')));
    await connection.output.allSent;
    debugPrint('Sen_Bluetooth_String: đã gửi "$data"');
    return true;
  } catch (e) {
    debugPrint('Sen_Bluetooth_String lỗi: $e');
    return false;
  }
}