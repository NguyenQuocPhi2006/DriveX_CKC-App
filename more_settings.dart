import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart'; // Chứa biến đường dẫn path

// Các biến cấu hình toàn cục
bool enable_temperature = false; // Biến bật/tắt hiển thị nhiệt độ
bool enable_logo = true;
String Ten_Nhom = "Hãy Nhập Tên Nhóm Trong Cài Đặt"; // Biến lưu tên nhóm

Color BTN_SW_back = Colors.grey.shade300;
Color BTN_SW_front = Colors.black87;
Color BTN_splash = Colors.grey.shade400;
Color SW_splash = Colors.blue; // màu hiệu ứng khi nhấn switch
Color AppBar_my = Colors.grey.shade300;

// Biến quản lý font chữ toàn cục cho trang này (mặc định 'Inter')
String selectedFont = 'Inter';

class MoreSettingsPage extends StatefulWidget {
  const MoreSettingsPage({super.key});

  @override
  State<MoreSettingsPage> createState() => _MoreSettingsPageState();
}

class _MoreSettingsPageState extends State<MoreSettingsPage> {
  late TextEditingController _nameController;
  late TextEditingController _pathController; // Controller cho đường dẫn path

  // Danh sách các font hỗ trợ tiếng Việt tốt
  final List<String> fontList = ['Inter', 'Roboto', 'Arial', 'Montserrat', 'Courier New'];

  // Danh sách màu mẫu cho người dùng chọn nhanh (đã thêm Colors.grey.shade300 và Colors.grey.shade400)
  final List<Color> colorPalette = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.white,
    Colors.black,
    Colors.deepPurple,
    Colors.teal,
    Colors.grey.shade300,
    Colors.grey.shade400,
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: Ten_Nhom);
    _pathController = TextEditingController(text: path_one); // Khởi tạo với giá trị path từ home.dart
    _loadSettings(); // Đọc dữ liệu đã lưu khi mở trang
  }

  // Hàm đọc dữ liệu từ SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      enable_temperature = prefs.getBool('enable_temperature') ?? enable_temperature;
      enable_logo = prefs.getBool('enable_logo') ?? enable_logo;
      Ten_Nhom = prefs.getString('ten_nhom') ?? Ten_Nhom;
      selectedFont = prefs.getString('selected_font') ?? selectedFont;
      
      // Đọc đường dẫn path đã lưu
      path_one = prefs.getString('app_path') ?? path_one;

      // Đọc màu sắc (lưu dưới dạng mã int)
      if (prefs.getInt('btn_sw_back') != null) {
        BTN_SW_back = Color(prefs.getInt('btn_sw_back')!);
      }
      if (prefs.getInt('btn_sw_front') != null) {
        BTN_SW_front = Color(prefs.getInt('btn_sw_front')!);
      }
      if (prefs.getInt('btn_sw_splash') != null) {
        BTN_splash = Color(prefs.getInt('btn_sw_splash')!);
      }
      if (prefs.getInt('sw_splash') != null) {
        SW_splash = Color(prefs.getInt('sw_splash')!);
      }
      if (prefs.getInt('appbar_my') != null) {
        AppBar_my = Color(prefs.getInt('appbar_my')!);
      }

      _nameController.text = Ten_Nhom;
      _pathController.text = path_one; // Cập nhật lại controller path
    });
  }

  // Hàm lưu dữ liệu vào SharedPreferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enable_temperature', enable_temperature);
    await prefs.setBool('enable_logo', enable_logo);
    await prefs.setString('ten_nhom', Ten_Nhom);
    await prefs.setString('selected_font', selectedFont);
    await prefs.setString('app_path', path_one); // Lưu đường dẫn path

    await prefs.setInt('btn_sw_back', BTN_SW_back.value);
    await prefs.setInt('btn_sw_front', BTN_SW_front.value);
    await prefs.setInt('btn_sw_splash', BTN_splash.value);
    await prefs.setInt('sw_splash', SW_splash.value);
    await prefs.setInt('appbar_my', AppBar_my.value);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pathController.dispose(); // Giải phóng controller path
    super.dispose();
  }

  // Hàm mở bảng chọn màu nhanh
  void _showColorPickerDialog(String title, Color currentColor, ValueChanged<Color> onColorChanged) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chọn màu cho $title', style: TextStyle(fontFamily: selectedFont)),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: colorPalette.map((color) {
                return GestureDetector(
                  onTap: () {
                    onColorChanged(color);
                    _saveSettings(); // Lưu ngay khi đổi màu
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade400, width: 1.5),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Đóng', style: TextStyle(fontFamily: selectedFont)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Đặt nền body màu trắng
      appBar: AppBar(
        title: Text('Cài đặt nâng cao', style: TextStyle(fontFamily: selectedFont)),
        centerTitle: true,
        backgroundColor: Colors.white, // Đặt nền AppBar màu trắng
        elevation: 0, 
        iconTheme: const IconThemeData(color: Colors.black87), // Nút back màu đen
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- 1. CÀI ĐẶT FONT CHỮ ---
          Text('Phông chữ hệ thống', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: selectedFont)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedFont,
                isExpanded: true,
                items: fontList.map((String font) {
                  return DropdownMenuItem<String>(
                    value: font,
                    child: Text(font, style: TextStyle(fontFamily: font, fontSize: 16)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedFont = newValue;
                    });
                    _saveSettings(); // Lưu ngay khi đổi font
                  }
                },
              ),
            ),
          ),
          const Divider(height: 30),

          // --- 2. BẬT / TẮT HIỂN THỊ NHIỆT ĐỘ & LOGO ---
          SwitchListTile(
            title: Text('Hiển thị Nhiệt độ', style: TextStyle(fontFamily: selectedFont)),
            subtitle: Text('Bật/tắt nút điều khiển hoặc thông tin nhiệt độ', style: TextStyle(fontFamily: selectedFont, fontSize: 12)),
            value: enable_temperature,
            onChanged: (bool value) {
              setState(() {
                enable_temperature = value;
              });
              _saveSettings(); // Lưu ngay khi gạt switch
            },
          ),
          SwitchListTile(
            title: Text('Hiển thị Logo', style: TextStyle(fontFamily: selectedFont)),
            subtitle: Text('Bật/tắt hiển thị logo trên màn hình', style: TextStyle(fontFamily: selectedFont, fontSize: 12)),
            value: enable_logo,
            onChanged: (bool value) {
              setState(() {
                enable_logo = value;
              });
              _saveSettings(); // Lưu ngay khi gạt switch
            },
          ),
          const Divider(height: 30),

          // --- 3. ĐỔI TÊN NHÓM ---
          Text('Tên nhóm ứng dụng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: selectedFont)),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            style: TextStyle(fontFamily: selectedFont),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Tên nhóm',
              labelStyle: TextStyle(fontFamily: selectedFont),
            ),
            onChanged: (value) {
              Ten_Nhom = value;
              _saveSettings(); // Lưu ngay khi gõ đổi tên nhóm
            },
          ),
          const Divider(height: 30),

          // --- 3.1. ĐỔI ĐƯỜNG DẪN PATH ---
          Text('Đường dẫn lưu(đối với kết nối qua Firebase)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: selectedFont)),
          const SizedBox(height: 8),
          TextField(
            controller: _pathController,
            style: TextStyle(fontFamily: selectedFont),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Đường dẫn path',
              labelStyle: TextStyle(fontFamily: selectedFont),
            ),
            onChanged: (value) {
              path_one = value; // Cập nhật biến path toàn cục
              _saveSettings(); // Lưu ngay khi gõ đổi path
            },
          ),
          const Divider(height: 30),

          // --- 4. BẢNG CHỌN MÀU (COLOR PICKER) ---
          Text('Tùy chỉnh màu sắc giao diện', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: selectedFont)),
          const SizedBox(height: 12),
          
          _buildColorPickerRow('Màu nền Switch (BTN_SW_back)', BTN_SW_back, (color) {
            setState(() => BTN_SW_back = color);
            _saveSettings();
          }),
          _buildColorPickerRow('Màu chữ Switch (BTN_SW_front)', BTN_SW_front, (color) {
            setState(() => BTN_SW_front = color);
            _saveSettings();
          }),
          _buildColorPickerRow('Màu hiệu ứng nút nhấn (BTN_splash)', BTN_splash, (color) {
            setState(() => BTN_splash = color);
            _saveSettings();
          }),
          _buildColorPickerRow('Màu hiệu ứng Switch (SW_splash)', SW_splash, (color) {
            setState(() => SW_splash = color);
            _saveSettings();
          }),
          _buildColorPickerRow('Màu thanh AppBar (AppBar_my)', AppBar_my, (color) {
            setState(() => AppBar_my = color);
            _saveSettings();
          }),
        ],
      ),
    );
  }

  // Widget hỗ trợ hiển thị dòng chọn màu
  Widget _buildColorPickerRow(String label, Color currentColor, ValueChanged<Color> onSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label, style: TextStyle(fontFamily: selectedFont, fontSize: 14)),
          ),
          GestureDetector(
            onTap: () => _showColorPickerDialog(label, currentColor, onSelected),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: currentColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}