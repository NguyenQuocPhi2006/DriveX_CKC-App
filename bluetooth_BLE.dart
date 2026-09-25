import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'more_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Các giá trị mặc định ban đầu
const String kDefaultServiceUuid = '4fafc201-1fb5-459e-8fcc-c5c9c331914b';
const String kDefaultCharUuid = 'beb5483e-36e1-4688-b7f5-ea07361b26a8';

// Biến toàn cục chứa giá trị hiện tại để dùng cho hàm gửi dữ liệu Sen_BLE_String
String globalServiceUuid = kDefaultServiceUuid;
String globalCharUuid = kDefaultCharUuid;

// Hàm tải dữ liệu đã lưu lên (gọi khi ứng dụng khởi động)
Future<void> loadSavedUuids() async {
  final prefs = await SharedPreferences.getInstance();
  globalServiceUuid =
      prefs.getString('saved_service_uuid') ?? kDefaultServiceUuid;
  globalCharUuid = prefs.getString('saved_char_uuid') ?? kDefaultCharUuid;
}

// Hàm lưu dữ liệu mới khi người dùng bấm lưu
Future<void> saveUuids(String serviceUuid, String charUuid) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('saved_service_uuid', serviceUuid);
  await prefs.setString('saved_char_uuid', charUuid);

  // Cập nhật luôn vào biến toàn cục để dùng ngay lập tức không cần khởi động lại app
  globalServiceUuid = serviceUuid;
  globalCharUuid = charUuid;
}

class Bluetooth_BLE extends StatefulWidget {
  const Bluetooth_BLE({super.key});

  @override
  State<Bluetooth_BLE> createState() => _Bluetooth_BLEState();
}

class _Bluetooth_BLEState extends State<Bluetooth_BLE> {
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  bool _showUnnamed = false; // bật để hiện cả thiết bị không có tên (debug)
  BluetoothDevice? _connectedDevice;
  StreamSubscription<List<ScanResult>>? _scanResultsSubscription;
  StreamSubscription<bool>? _isScanningSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;

  // Sử dụng font chữ Inter
  final String selectedFont = 'Inter';

  @override
  void initState() {
    super.initState();

    // Tải UUID đã lưu trước đó từ bộ nhớ máy
    loadSavedUuids();

    // Quay lại trang khi đang có kết nối sẵn thì hiện đúng trạng thái
    final connected = FlutterBluePlus.connectedDevices;
    if (connected.isNotEmpty) {
      final device = connected.first;
      _connectedDevice = device;
      _listenConnection(device);
    }

    // Lắng nghe kết quả quét thiết bị Bluetooth
    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      if (!mounted) return;
      setState(() {
        _scanResults = _filterAndSort(results);
      });
    });

    // Lắng nghe trạng thái quét đang chạy hay dừng
    _isScanningSubscription = FlutterBluePlus.isScanning.listen((isScanning) {
      if (!mounted) return;
      setState(() {
        _isScanning = isScanning;
      });
    });
  }

  @override
  void dispose() {
    // Không ngắt kết nối ở đây để các file khác vẫn gửi dữ liệu được
    _scanResultsSubscription?.cancel();
    _isScanningSubscription?.cancel();
    _connectionStateSubscription?.cancel();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontFamily: selectedFont)),
      ),
    );
  }

  // Lấy tên thiết bị: ưu tiên advName, sau đó tới platformName, cuối cùng nhận diện theo MAC
  String _getDeviceName(ScanResult r) {
    if (r.advertisementData.advName.isNotEmpty) {
      return r.advertisementData.advName;
    }
    if (r.device.platformName.isNotEmpty) {
      return r.device.platformName;
    }
    return '';
  }

  // Lọc thiết bị không tên (nếu đang tắt), ESP32 lên đầu, rồi theo sóng mạnh
  // Lọc thiết bị không tên (nếu đang tắt), sắp xếp theo sóng mạnh dần
  List<ScanResult> _filterAndSort(List<ScanResult> results) {
    final list = results
        .where((r) => _showUnnamed || _getDeviceName(r).isNotEmpty)
        .toList();

    list.sort((a, b) {
      // Sắp xếp thuần túy theo RSSI (sóng mạnh hơn lên đầu)
      return b.rssi.compareTo(a.rssi);
    });

    return list;
  }

  // Xin quyền Bluetooth/Vị trí lúc chạy (Android 12+)
  Future<void> _requestPermissions() async {
    final statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();
    debugPrint('Quyền Bluetooth: $statuses');
  }

  // Lắng nghe trạng thái ngắt kết nối của thiết bị
  void _listenConnection(BluetoothDevice device) {
    _connectionStateSubscription?.cancel();
    _connectionStateSubscription = device.connectionState.listen((state) {
      if (state == BluetoothConnectionState.disconnected) {
        if (!mounted) return;
        setState(() {
          _connectedDevice = null;
        });
        _snack('Đã ngắt kết nối với thiết bị.');
      }
    });
  }

  // Hàm bắt đầu quét thiết bị
  Future<void> _startScan() async {
    try {
      await _requestPermissions();
      if (!mounted) return;
      setState(() {
        _scanResults = [];
      });
      // Quét trong vòng 6 giây
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 6));
    } catch (e) {
      debugPrint("Lỗi quét Bluetooth: $e");
      _snack('Lỗi quét Bluetooth: $e');
    }
  }

  // Hàm ngắt kết nối
  Future<void> _disconnectDevice() async {
    try {
      // Hủy listener trước để không hiện thông báo ngắt kết nối hai lần
      await _connectionStateSubscription?.cancel();
      await _connectedDevice?.disconnect();
    } catch (e) {
      debugPrint("Lỗi ngắt kết nối: $e");
    }
    if (!mounted) return;
    setState(() {
      _connectedDevice = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bluetooth BLE',
          style: TextStyle(fontFamily: selectedFont),
        ),
        actions: [
          // Bật/tắt hiển thị thiết bị không tên
          IconButton(
            tooltip: _showUnnamed
                ? 'Ẩn thiết bị không tên'
                : 'Hiện thiết bị không tên',
            icon: Icon(_showUnnamed ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _showUnnamed = !_showUnnamed;
              });
              if (!_isScanning) _startScan();
            },
          ),
          // Nút Quét / Dừng quét
          IconButton(
            icon: Icon(_isScanning ? Icons.stop : Icons.search),
            onPressed: _isScanning
                ? () => FlutterBluePlus.stopScan()
                : _startScan,
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
                      'Đã kết nối: ${_connectedDevice!.platformName.isNotEmpty ? _connectedDevice!.platformName : _connectedDevice!.remoteId}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: selectedFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _disconnectDevice,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      'Ngắt kết nối',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: selectedFont,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Danh sách các thiết bị tìm thấy
          Expanded(
            child: _scanResults.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        _isScanning
                            ? 'Đang tìm kiếm thiết bị ESP32...'
                            : 'Nhấn nút kính lúp để quét thiết bị Bluetooth (BLE)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: selectedFont,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _scanResults.length,
                    itemBuilder: (context, index) {
                      final data = _scanResults[index];
                      String deviceName = _getDeviceName(data);
                      if (deviceName.isEmpty) {
                        deviceName = "Thiết bị ẩn danh";
                      }

                      return ListTile(
                        onTap: () {
                          // Chuyển sang màn hình nhập UUID và truyền theo thông tin thiết bị
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BleControlScreen(
                                device: data.device,
                                deviceName: deviceName,
                              ),
                            ),
                          );
                        },
                        title: Text(
                          deviceName,
                          style: TextStyle(
                            fontFamily: selectedFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${data.device.remoteId}  •  ${data.rssi} dBm',
                          style: TextStyle(fontFamily: selectedFont),
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

// ===== Gửi String qua BLE tới ESP32 (dùng được ở mọi file) =====
BluetoothCharacteristic? _cachedCharacteristic;
String? _cachedDeviceId;

/// Ví dụ: await Sen_BLE_String("T");
/// Trả về true nếu gửi thành công, false nếu thất bại.
Future<bool> Sen_BLE_String(String data) async {
  // Lấy thiết bị đang kết nối trực tiếp từ flutter_blue_plus
  final connected = FlutterBluePlus.connectedDevices;

  if (connected.isEmpty) {
    _cachedCharacteristic = null;
    _cachedDeviceId = null;
    debugPrint('Sen_BLE_String: chưa kết nối thiết bị nào.');
    return false;
  }

  final device = connected.first;

  // Đổi thiết bị thì xóa cache
  if (_cachedDeviceId != device.remoteId.str) {
    _cachedCharacteristic = null;
    _cachedDeviceId = device.remoteId.str;
  }

  // Thử tối đa 2 lần: lần 2 sẽ tìm lại characteristic (phòng khi vừa kết nối lại)
  for (int attempt = 0; attempt < 2; attempt++) {
    try {
      if (_cachedCharacteristic == null) {
        final services = await device.discoverServices();
        for (final s in services) {
          if (s.uuid == Guid(globalServiceUuid)) {
            for (final c in s.characteristics) {
              if (c.uuid == Guid(globalCharUuid)) {
                _cachedCharacteristic = c;
              }
            }
          }
        }
      }

      if (_cachedCharacteristic == null) {
        debugPrint('Sen_BLE_String: không tìm thấy characteristic.');
        return false;
      }

      await _cachedCharacteristic!.write(
        utf8.encode(data),
        allowLongWrite: true,
      );
      debugPrint('Sen_BLE_String: đã gửi "$data"');
      return true;
    } catch (e) {
      debugPrint('Sen_BLE_String lỗi (lần ${attempt + 1}): $e');
      _cachedCharacteristic = null; // lần sau tìm lại
    }
  }
  return false;
}

class BleControlScreen extends StatefulWidget {
  final BluetoothDevice device;
  final String deviceName;

  const BleControlScreen({
    super.key,
    required this.device,
    required this.deviceName,
  });

  @override
  State<BleControlScreen> createState() => _BleControlScreenState();
}

class _BleControlScreenState extends State<BleControlScreen> {
  // Khai báo controller và điền sẵn giá trị từ biến toàn cục (đã lưu trong SharedPreferences)
  late final TextEditingController _serviceUuidController =
      TextEditingController(text: globalServiceUuid);

  late final TextEditingController _charUuidController = TextEditingController(
    text: globalCharUuid,
  );

  final String selectedFont = 'Inter';

  @override
  void dispose() {
    _serviceUuidController.dispose();
    _charUuidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kết nối: ${widget.deviceName}',
          style: TextStyle(fontFamily: selectedFont),
        ),
      ),
      // Bọc bằng SingleChildScrollView để chống lỗi tràn màn hình khi hiện bàn phím ảo
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hiển thị ID phần cứng của thiết bị cho dễ kiểm tra
            Text(
              'ID: ${widget.device.remoteId}',
              style: TextStyle(fontFamily: selectedFont, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Textbox 1: Nhập Mã dịch vụ (Service UUID)
            TextField(
              controller: _serviceUuidController,
              style: TextStyle(fontFamily: selectedFont),
              decoration: InputDecoration(
                labelText: 'Mã dịch vụ (Service UUID)',
                labelStyle: TextStyle(fontFamily: selectedFont),
                hintText: 'Ví dụ: 12345678-1234-5678-1234-56789abcdef0',
                hintStyle: TextStyle(fontFamily: selectedFont),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Textbox 2: Nhập Mã đặc tính (Characteristic UUID)
            TextField(
              controller: _charUuidController,
              style: TextStyle(fontFamily: selectedFont),
              decoration: InputDecoration(
                labelText: 'Mã đặc tính (Characteristic UUID)',
                labelStyle: TextStyle(fontFamily: selectedFont),
                hintText: 'Ví dụ: abcd...',
                hintStyle: TextStyle(fontFamily: selectedFont),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nút bấm lưu & kết nối
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final serviceUuid = _serviceUuidController.text.trim();
                final charUuid = _charUuidController.text.trim();

                if (serviceUuid.isEmpty || charUuid.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Vui lòng nhập đủ Service và Characteristic UUID!',
                        style: TextStyle(fontFamily: selectedFont),
                      ),
                    ),
                  );
                  return;
                }

                // 1. Lưu UUID vào SharedPreferences và cập nhật biến toàn cục
                await saveUuids(serviceUuid, charUuid);

                if (!mounted) return;

                try {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Đang kết nối tới thiết bị...',
                        style: TextStyle(fontFamily: selectedFont),
                      ),
                    ),
                  );

                  // 2. Thực hiện kết nối phần cứng BLE với thiết bị được truyền sang
                  await widget.device.connect();

                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Đã lưu UUID và kết nối thành công!',
                        style: TextStyle(fontFamily: selectedFont),
                      ),
                    ),
                  );

                  // 3. Quay lại màn hình trước
                  Navigator.pop(context);
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Kết nối thất bại: $e',
                        style: TextStyle(fontFamily: selectedFont),
                      ),
                    ),
                  );
                }
              },
              child: Text(
                'Lưu & Kết nối',
                style: TextStyle(fontSize: 16, fontFamily: selectedFont),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> Sen_Bluetooth_BLE_String(String data) async {
  final connected = FlutterBluePlus.connectedDevices;

  if (connected.isEmpty) {
    _cachedCharacteristic = null;
    _cachedDeviceId = null;
    debugPrint(
      'Sen_Bluetooth_BLE_String: Chưa kết nối thiết bị Bluetooth nào.',
    );
    return false;
  }

  final device = connected.first;

  if (_cachedDeviceId != device.remoteId.str) {
    _cachedCharacteristic = null;
    _cachedDeviceId = device.remoteId.str;
  }

  for (int attempt = 0; attempt < 2; attempt++) {
    try {
      if (_cachedCharacteristic == null) {
        final services = await device.discoverServices();
        for (final s in services) {
          if (s.uuid == Guid(globalServiceUuid)) {
            for (final c in s.characteristics) {
              if (c.uuid == Guid(globalCharUuid)) {
                _cachedCharacteristic = c;
              }
            }
          }
        }
      }

      if (_cachedCharacteristic == null) {
        debugPrint(
          'Sen_Bluetooth_BLE_String: Không tìm thấy Service hoặc Characteristic UUID tương ứng.',
        );
        return false;
      }

      await _cachedCharacteristic!.write(
        utf8.encode(data),
        allowLongWrite: true,
      );

      debugPrint('Sen_Bluetooth_BLE_String: Đã gửi thành công "$data"');
      return true;
    } catch (e) {
      debugPrint('Sen_Bluetooth_BLE_String lỗi (lần ${attempt + 1}): $e');
      _cachedCharacteristic = null;
    }
  }

  return false;
}
