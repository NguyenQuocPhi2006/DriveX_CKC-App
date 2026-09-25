import 'package:flutter/material.dart';
import 'bluetooth_classic.dart';
import 'bluetooth_BLE.dart';
import 'package:shared_preferences/shared_preferences.dart';

class select_send_Classic_BLE extends StatefulWidget {
  const select_send_Classic_BLE({super.key});

  @override
  State<select_send_Classic_BLE> createState() => _select_send_Classic_BLEState();
}

bool? isClassicMode = true; // Biến toàn cục quản lý chế độ: true = Classic, false = BLE

// tạo class _select_send_Classic_BLEState rỗng
class _select_send_Classic_BLEState extends State<select_send_Classic_BLE> {

  @override
  void initState() {
    super.initState();
    _loadSavedMode(); // 2. Đọc lại lựa chọn cũ khi màn hình vừa mở lên
  }

  // Hàm đọc dữ liệu đã lưu trong bộ nhớ máy
  Future<void> _loadSavedMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Nếu chưa lưu lần nào thì mặc định là true (Bluetooth)
      isClassicMode = prefs.getBool('isClassicMode') ?? true;
    });
  }

  // Hàm lưu trạng thái vào bộ nhớ máy
  Future<void> _saveMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isClassicMode', value); // sửa: trước đây lưu nhầm key 'isBluetoothMode'
  }

  // Biến lưu trạng thái đang chọn: true là Classic, false là BLE
  String selectedFont = 'Inter'; // Đã chuyển sang font chữ Inter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        title: Text(
          'Chọn chế độ Bluetooth',
          style: TextStyle(fontFamily: selectedFont),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Vui lòng chọn phương thức kết nối Bluetooth',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: selectedFont,
                  ),
                ),
                const SizedBox(height: 20),

                // --- NÚT CLASSIC BLUETOOTH ---
                _buildChoiceButton(
                  title: 'Bluetooth Classic',
                  subtitle: 'Các module hỗ trợ: ESP32-WROOM-32, ESP32-WROVER-32(device module)',
                  icon: Icons.bluetooth_connected,
                  isSelected: isClassicMode == true,
                  onTap: () async {
                    await _saveMode(true);
                    setState(() {
                      isClassicMode = true;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Bluetooth_Classic()),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // --- NÚT BLE (BLUETOOTH LOW ENERGY) ---
                _buildChoiceButton(
                  title: 'BLE (Low Energy)',
                  subtitle: 'Các module hỗ trợ: ESP32-WROOM-32, ESP32-WROVER-32, ESP32-C3, ESP32-S3, ESP32-C6, ESP32-H2',
                  icon: Icons.bluetooth_searching,
                  isSelected: isClassicMode == false,
                  onTap: () async {
                    await _saveMode(false);
                    setState(() {
                      isClassicMode = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Bluetooth_BLE()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hàm phụ trợ tạo giao diện cho từng nút bấm
  Widget _buildChoiceButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          width: isSelected ? 2.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: selectedFont,
                          color: isSelected ? Colors.blue.shade900 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontFamily: selectedFont,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: Colors.blue, size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- CÁC MÀN HÌNH RỖNG ĐỂ ĐIỀU HƯỚNG ---

class ClassicScreen extends StatelessWidget {
  const ClassicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Màn hình Bluetooth Classic')),
      body: const Center(
        child: Text('Nội dung Bluetooth Classic ở đây'),
      ),
    );
  }
}

class BleScreen extends StatelessWidget {
  const BleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Màn hình BLE')),
      body: const Center(
        child: Text('Nội dung BLE ở đây'),
      ),
    );
  }
}