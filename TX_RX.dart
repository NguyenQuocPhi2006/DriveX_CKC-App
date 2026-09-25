import 'package:flutter/material.dart';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'more_settings.dart';

// tạo class kế thừa gọi class StatefulWidget
class TX_RX extends StatefulWidget {
  const TX_RX({super.key});

  @override
  State<TX_RX> createState() => _TX_RXState();
}

class _TX_RXState extends State<TX_RX> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        title: Text(
          'Cấu Hình Lệnh Điều Khiển',
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
                  'Chọn chế độ TX hoặc RX',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: selectedFont,
                  ),
                ),
                const SizedBox(height: 30),

                // --- LỰA CHỌN TX_SETTINGS ---
                _buildChoiceButton(
                  title: 'Transmitting (Gửi dữ liệu)',
                  subtitle: 'Cấu hình lệnh gửi cho 14 nút điều khiển',
                  icon: Icons.upload_rounded,
                  onTap: () {
                    // Chuyển sang màn hình giao diện cấu hình lệnh
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TXConfigPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // --- LỰA CHỌN RX_STATE ---
                _buildChoiceButton(
                  title: 'Receiving (Nhận dữ liệu)',
                  subtitle: 'Phần này mình sẽ phát triển nó sau version sau',
                  icon: Icons.download_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RXDevelopingPage(),
                      ),
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

  // Hàm phụ trợ tạo giao diện thẻ bấm cố định màu sắc thông thường
  Widget _buildChoiceButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
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
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.grey.shade700,
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
                          color: Colors.black87,
                          fontFamily: selectedFont,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// MÀN HÌNH TX_STATE (Giao diện 2 ô TextBox: Cạnh lên & Cạnh xuống hoặc ON/OFF)
// ==========================================
class TXConfigPage extends StatefulWidget {
  const TXConfigPage({super.key});

  @override
  State<TXConfigPage> createState() => _TXConfigPageState();
}

class _TXConfigPageState extends State<TXConfigPage> {
  final List<WidgetPosition> widgetPositions = [
    Tien,
    Lui,
    Trai,
    Phai,
    Switch_1,
    Switch_2,
    Switch_3,
    Switch_4,
    Switch_5,
    Switch_6,
    Button_1,
    Button_2,
    Button_3,
    Button_4,
  ];

  // Danh sách tên hiển thị cứng ở bên trái
  final List<String> fixedLabels = [
    'Tiến',
    'Lùi',
    'Trái',
    'Phải',
    'Switch 1',
    'Switch 2',
    'Switch 3',
    'Switch 4',
    'Switch 5',
    'Switch 6',
    'Button 1',
    'Button 2',
    'Button 3',
    'Button 4',
  ];

  // Danh sách controller cho ô thứ nhất (Cạnh lên / Khi ON)
  late final List<TextEditingController> _upControllers;
  
  // Danh sách controller cho ô thứ hai (Cạnh xuống / Khi OFF)
  late final List<TextEditingController> _downControllers;

  @override
  void initState() {
    super.initState();
    // Khởi tạo controller thứ nhất mang dữ liệu sẵn có của item.data
    _upControllers = widgetPositions.map((item) {
      return TextEditingController(text: item.data);
    }).toList();

    // Khởi tạo controller thứ hai mang dữ liệu sẵn có của item.data_falling
    _downControllers = widgetPositions.map((item) {
      return TextEditingController(text: item.data_falling);
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _upControllers) {
      controller.dispose();
    }
    for (var controller in _downControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Hàm lưu dữ liệu từ các ô nhập vào struct và SharedPreferences
  Future<void> _saveData() async {
    Tien.data = _upControllers[0].text;
    Lui.data = _upControllers[1].text;
    Trai.data = _upControllers[2].text;
    Phai.data = _upControllers[3].text;
    Switch_1.data = _upControllers[4].text;
    Switch_2.data = _upControllers[5].text;
    Switch_3.data = _upControllers[6].text;
    Switch_4.data = _upControllers[7].text;
    Switch_5.data = _upControllers[8].text;
    Switch_6.data = _upControllers[9].text;
    Button_1.data = _upControllers[10].text;
    Button_2.data = _upControllers[11].text;
    Button_3.data = _upControllers[12].text;
    Button_4.data = _upControllers[13].text;

    Tien.data_falling = _downControllers[0].text;
    Lui.data_falling = _downControllers[1].text;
    Trai.data_falling = _downControllers[2].text;
    Phai.data_falling = _downControllers[3].text;
    Switch_1.data_falling = _downControllers[4].text;
    Switch_2.data_falling = _downControllers[5].text;
    Switch_3.data_falling = _downControllers[6].text;
    Switch_4.data_falling = _downControllers[7].text;
    Switch_5.data_falling = _downControllers[8].text;
    Switch_6.data_falling = _downControllers[9].text;
    Button_1.data_falling = _downControllers[10].text;
    Button_2.data_falling = _downControllers[11].text;
    Button_3.data_falling = _downControllers[12].text;
    Button_4.data_falling = _downControllers[13].text;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tien_data', Tien.data);
    await prefs.setString('lui_data', Lui.data);
    await prefs.setString('trai_data', Trai.data);
    await prefs.setString('phai_data', Phai.data);
    await prefs.setString('switch_1_data', Switch_1.data);
    await prefs.setString('switch_2_data', Switch_2.data);
    await prefs.setString('switch_3_data', Switch_3.data);
    await prefs.setString('switch_4_data', Switch_4.data);
    await prefs.setString('switch_5_data', Switch_5.data);
    await prefs.setString('switch_6_data', Switch_6.data);
    await prefs.setString('button_1_data', Button_1.data);
    await prefs.setString('button_2_data', Button_2.data);
    await prefs.setString('button_3_data', Button_3.data);
    await prefs.setString('button_4_data', Button_4.data);

    await prefs.setString('tien_data_falling', Tien.data_falling);
    await prefs.setString('lui_data_falling', Lui.data_falling);
    await prefs.setString('trai_data_falling', Trai.data_falling);
    await prefs.setString('phai_data_falling', Phai.data_falling);
    await prefs.setString('switch_1_data_falling', Switch_1.data_falling);
    await prefs.setString('switch_2_data_falling', Switch_2.data_falling);
    await prefs.setString('switch_3_data_falling', Switch_3.data_falling);
    await prefs.setString('switch_4_data_falling', Switch_4.data_falling);
    await prefs.setString('switch_5_data_falling', Switch_5.data_falling);
    await prefs.setString('switch_6_data_falling', Switch_6.data_falling);
    await prefs.setString('button_1_data_falling', Button_1.data_falling);
    await prefs.setString('button_2_data_falling', Button_2.data_falling);
    await prefs.setString('button_3_data_falling', Button_3.data_falling);
    await prefs.setString('button_4_data_falling', Button_4.data_falling);

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cấu Hình Lệnh Gửi (TX)',
          style: TextStyle(fontFamily: selectedFont),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveData,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0, bottom: 16.0),
        itemCount: widgetPositions.length,
        itemBuilder: (context, index) {
          // Kiểm tra xem phần tử hiện tại có phải là Switch hay không (từ index 4 đến 9 là Switch 1 đến Switch 6)
          bool isSwitch = index >= 4 && index <= 9;

          // Đặt tên nhãn InputDecoration tương ứng
          String labelFirst = isSwitch ? 'Khi ON' : 'Khi ấn vào nút(cạnh lên)';
          String labelSecond = isSwitch ? 'Khi OFF' : 'Khi thả ra nút(cạnh xuống)';

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                // 1. Tên nhãn bên trái cố định
                SizedBox(
                  width: 90,
                  child: Text(
                    fixedLabels[index],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: selectedFont,
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 2. Ô TextBox thứ nhất
                Expanded(
                  child: TextField(
                    controller: _upControllers[index],
                    style: TextStyle(fontFamily: selectedFont),
                    decoration: InputDecoration(
                      labelText: labelFirst,
                      labelStyle: TextStyle(fontFamily: selectedFont),
                      border: const OutlineInputBorder(),
                      isDense: true,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _upControllers[index].clear();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 3. Ô TextBox thứ hai
                Expanded(
                  child: TextField(
                    controller: _downControllers[index],
                    style: TextStyle(fontFamily: selectedFont),
                    decoration: InputDecoration(
                      labelText: labelSecond,
                      labelStyle: TextStyle(fontFamily: selectedFont),
                      border: const OutlineInputBorder(),
                      isDense: true,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _downControllers[index].clear();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// MÀN HÌNH RXSTATE (Trang tạm thời cho RX)
// ==========================================
class RXDevelopingPage extends StatelessWidget {
  const RXDevelopingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RX State (Đang phát triển)',
          style: TextStyle(fontFamily: selectedFont),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Chức năng RX State đang được phát triển.\nVui lòng quay lại sau.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: selectedFont,
          ),
        ),
      ),
    );
  }
}