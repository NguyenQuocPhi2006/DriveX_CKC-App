import 'home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'more_settings.dart';

class Set_Thao_Tac_Tay extends StatefulWidget {
  Set_Thao_Tac_Tay({super.key});

  @override
  State<Set_Thao_Tac_Tay> createState() => _Set_Thao_Tac_TayState();
}

class _Set_Thao_Tac_TayState extends State<Set_Thao_Tac_Tay> {
  Offset move = Offset(55, 30);
  late WidgetPosition Di_chuyen_len = WidgetPosition(
    x: move.dx + 5,
    y: move.dy + 20,
    w: 40,
    h: 40,
    colorBack: Colors.red,
    colorFront: Colors.white,
    coLorsplash: Colors.yellow,
    data: "",
    data_falling: "",
    status: "",
  );
  late WidgetPosition Di_chuyen_xuong = WidgetPosition(
    x: move.dx + 5,
    y: move.dy,
    w: 40,
    h: 40,
    colorBack: Colors.red,
    colorFront: Colors.white,
    coLorsplash: Colors.yellow,
    data: "",
    data_falling: "",
    status: "",
  );
  late WidgetPosition Di_chuyen_trai = WidgetPosition(
    x: move.dx + 10,
    y: move.dy + 10,
    w: 40,
    h: 40,
    colorBack: Colors.red,
    colorFront: Colors.white,
    coLorsplash: Colors.yellow,
    data: "",
    data_falling: "",
    status: "",
  );
  late WidgetPosition Di_chuyen_phai = WidgetPosition(
    x: move.dx,
    y: move.dy + 10,
    w: 40,
    h: 40,
    colorBack: Colors.red,
    colorFront: Colors.white,
    coLorsplash: Colors.yellow,
    data: "",
    data_falling: "",
    status: "",
  );
  late WidgetPosition Phong_to = WidgetPosition(
    x: move.dx + 15,
    y: move.dy + 10,
    w: 30,
    h: 30,
    colorBack: Colors.red,
    colorFront: Colors.white,
    coLorsplash: Colors.yellow,
    data: "",
    data_falling: "",
    status: "",
  );
  late WidgetPosition Thu_nho = WidgetPosition(
    x: move.dx - 5,
    y: move.dy + 10,
    w: 30,
    h: 30,
    colorBack: Colors.red,
    colorFront: Colors.white,
    coLorsplash: Colors.yellow,
    data: "",
    data_falling: "",
    status: "",
  );
  late WidgetPosition OK = WidgetPosition(
    x: move.dx + 6,
    y: move.dy + 11,
    w: 30,
    h: 30,
    colorBack: Colors.green,
    colorFront: Colors.white,
    coLorsplash: Colors.yellow,
    data: "",
    data_falling: "",
    status: "",
  );

  String? _selected;
  // static const Color mauMacDinh = Colors.blue;
  static const Color mauDuocChon = Colors.pink;

  WidgetPosition? get selectedObject {
    if (_selected == 'Tien') return Tien;
    if (_selected == 'Lui') return Lui;
    if (_selected == 'Trai') return Trai;
    if (_selected == 'Phai') return Phai;
    if (_selected == 'LM35') return LM35;
    if (_selected == 'Switch_1') return Switch_1;
    if (_selected == 'Switch_2') return Switch_2;
    if (_selected == 'Switch_3') return Switch_3;
    if (_selected == 'Switch_4') return Switch_4;
    if (_selected == 'Switch_5') return Switch_5;
    if (_selected == 'Switch_6') return Switch_6;
    if (_selected == 'Button_1') return Button_1;
    if (_selected == 'Button_2') return Button_2;
    if (_selected == 'Button_3') return Button_3;
    if (_selected == 'Button_4') return Button_4;
    //logo
    if (_selected == 'LOGO') return LOGO;
    return null;
  }

  void chonViTri(String tenNut) {
    setState(() {
      _selected = tenNut;
    });
  }

  void diChuyenLen() {
    final obj = selectedObject;
    if (obj == null) return;
    setState(() {
      obj.y += 1;
    });
  }

  void diChuyenXuong() {
    final obj = selectedObject;
    if (obj == null) return;
    setState(() {
      obj.y -= 1;
    });
  }

  void diChuyenTrai() {
    final obj = selectedObject;
    if (obj == null) return;
    setState(() {
      obj.x += 1;
    });
  }

  void diChuyenPhai() {
    final obj = selectedObject;
    if (obj == null) return;
    setState(() {
      obj.x -= 1;
    });
  }

  void phongTo() {
    final obj = selectedObject;
    if (obj == null) return;
    setState(() {
      obj.w += 1;
      obj.h += 1;
    });
  }

  void thuNho() {
    final obj = selectedObject;
    if (obj == null) return;
    setState(() {
      obj.w -= 1;
      obj.h -= 1;
    });
  }

  void xu_ly_khi_nhan_nut(String tenNut) {
    setState(() {
      _selected = tenNut;
    });
  }

  Future<void> luuViTri() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tien_x', Tien.x);
    await prefs.setDouble('tien_y', Tien.y);
    await prefs.setDouble('tien_w', Tien.w);
    await prefs.setDouble('tien_h', Tien.h);
    await prefs.setDouble('lui_x', Lui.x);
    await prefs.setDouble('lui_y', Lui.y);
    await prefs.setDouble('lui_w', Lui.w);
    await prefs.setDouble('lui_h', Lui.h);
    await prefs.setDouble('trai_x', Trai.x);
    await prefs.setDouble('trai_y', Trai.y);
    await prefs.setDouble('trai_w', Trai.w);
    await prefs.setDouble('trai_h', Trai.h);
    await prefs.setDouble('phai_x', Phai.x);
    await prefs.setDouble('phai_y', Phai.y);
    await prefs.setDouble('phai_w', Phai.w);
    await prefs.setDouble('phai_h', Phai.h);
    await prefs.setDouble('lm35_x', LM35.x);
    await prefs.setDouble('lm35_y', LM35.y);
    await prefs.setDouble('lm35_w', LM35.w);
    await prefs.setDouble('lm35_h', LM35.h);
    await prefs.setDouble('switch_1_x', Switch_1.x);
    await prefs.setDouble('switch_1_y', Switch_1.y);
    await prefs.setDouble('switch_1_w', Switch_1.w);
    await prefs.setDouble('switch_1_h', Switch_1.h);
    await prefs.setDouble('switch_2_x', Switch_2.x);
    await prefs.setDouble('switch_2_y', Switch_2.y);
    await prefs.setDouble('switch_2_w', Switch_2.w);
    await prefs.setDouble('switch_2_h', Switch_2.h);
    await prefs.setDouble('switch_3_x', Switch_3.x);
    await prefs.setDouble('switch_3_y', Switch_3.y);
    await prefs.setDouble('switch_3_w', Switch_3.w);
    await prefs.setDouble('switch_3_h', Switch_3.h);
    await prefs.setDouble('switch_4_x', Switch_4.x);
    await prefs.setDouble('switch_4_y', Switch_4.y);
    await prefs.setDouble('switch_4_w', Switch_4.w);
    await prefs.setDouble('switch_4_h', Switch_4.h);
    await prefs.setDouble('switch_5_x', Switch_5.x);
    await prefs.setDouble('switch_5_y', Switch_5.y);
    await prefs.setDouble('switch_5_w', Switch_5.w);
    await prefs.setDouble('switch_5_h', Switch_5.h);
    await prefs.setDouble('switch_6_x', Switch_6.x);
    await prefs.setDouble('switch_6_y', Switch_6.y);
    await prefs.setDouble('switch_6_w', Switch_6.w);
    await prefs.setDouble('switch_6_h', Switch_6.h);
    await prefs.setDouble('button_1_x', Button_1.x);
    await prefs.setDouble('button_1_y', Button_1.y);
    await prefs.setDouble('button_1_w', Button_1.w);
    await prefs.setDouble('button_1_h', Button_1.h);
    await prefs.setDouble('button_2_x', Button_2.x);
    await prefs.setDouble('button_2_y', Button_2.y);
    await prefs.setDouble('button_2_w', Button_2.w);
    await prefs.setDouble('button_2_h', Button_2.h);
    await prefs.setDouble('button_3_x', Button_3.x);
    await prefs.setDouble('button_3_y', Button_3.y);
    await prefs.setDouble('button_3_w', Button_3.w);
    await prefs.setDouble('button_3_h', Button_3.h);
    await prefs.setDouble('button_4_x', Button_4.x);
    await prefs.setDouble('button_4_y', Button_4.y);
    await prefs.setDouble('button_4_w', Button_4.w);
    await prefs.setDouble('button_4_h', Button_4.h);
    await prefs.setDouble('logo_x', LOGO.x);
    await prefs.setDouble('logo_y', LOGO.y);
    await prefs.setDouble('logo_w', LOGO.w);
    await prefs.setDouble('logo_h', LOGO.h);
  }

  Color _mauCuaNut(String tenNut) {
    return _selected == tenNut ? mauDuocChon : BTN_SW_back;
  }

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 25,
        title: Text(
          'Chỉnh Lại Thao Tác',
          style: TextStyle(fontFamily: selectedFont),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: const SizedBox(),
            ),
          ),
          Positioned(
            bottom: screen.getY(Tien.y),
            right: screen.getX(Tien.x),
            child: _directionButton(
              icon: Icons.arrow_upward,
              tooltip: '',
              width: Tien.w,
              height: Tien.h,
              colorBack: _mauCuaNut('Tien'),
              colorFront: Tien.colorFront,
              colorSplash: Tien.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Tien');
                chonViTri('Tien');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Lui.y),
            right: screen.getX(Lui.x),
            child: _directionButton(
              icon: Icons.arrow_downward,
              tooltip: '',
              width: Lui.w,
              height: Lui.h,
              colorBack: _mauCuaNut('Lui'),
              colorFront: Lui.colorFront,
              colorSplash: Lui.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Lui');
                chonViTri('Lui');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Trai.y),
            right: screen.getX(Trai.x),
            child: _directionButton(
              icon: Icons.arrow_back,
              tooltip: '',
              width: Trai.w,
              height: Trai.h,
              colorBack: _mauCuaNut('Trai'),
              colorFront: Trai.colorFront,
              colorSplash: Trai.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Trai');
                chonViTri('Trai');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Phai.y),
            right: screen.getX(Phai.x),
            child: _directionButton(
              icon: Icons.arrow_forward,
              tooltip: '',
              width: Phai.w,
              height: Phai.h,
              colorBack: _mauCuaNut('Phai'),
              colorFront: Phai.colorFront,
              colorSplash: Phai.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Phai');
                chonViTri('Phai');
              },
            ),
          ),
          //Switch_1
          Positioned(
            bottom: screen.getY(Switch_1.y),
            right: screen.getX(Switch_1.x),
            child: _directionButton(
              icon: Icons.toggle_on,
              tooltip: 'SW1',
              width: Switch_1.w,
              height: Switch_1.h,
              colorBack: _mauCuaNut('Switch_1'),
              colorFront: Switch_1.colorFront,
              colorSplash: Switch_1.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Switch_1');
                chonViTri('Switch_1');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Switch_2.y),
            right: screen.getX(Switch_2.x),
            child: _directionButton(
              icon: Icons.toggle_on,
              tooltip: 'SW2',
              width: Switch_2.w,
              height: Switch_2.h,
              colorBack: _mauCuaNut('Switch_2'),
              colorFront: Switch_2.colorFront,
              colorSplash: Switch_2.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Switch_2');
                chonViTri('Switch_2');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Switch_3.y),
            right: screen.getX(Switch_3.x),
            child: _directionButton(
              icon: Icons.toggle_on,
              tooltip: 'SW3',
              width: Switch_3.w,
              height: Switch_3.h,
              colorBack: _mauCuaNut('Switch_3'),
              colorFront: Switch_3.colorFront,
              colorSplash: Switch_3.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Switch_3');
                chonViTri('Switch_3');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Switch_4.y),
            right: screen.getX(Switch_4.x),
            child: _directionButton(
              icon: Icons.toggle_on,
              tooltip: 'SW4',
              width: Switch_4.w,
              height: Switch_4.h,
              colorBack: _mauCuaNut('Switch_4'),
              colorFront: Switch_4.colorFront,
              colorSplash: Switch_4.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Switch_4');
                chonViTri('Switch_4');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Switch_5.y),
            right: screen.getX(Switch_5.x),
            child: _directionButton(
              icon: Icons.toggle_on,
              tooltip: 'SW5',
              width: Switch_5.w,
              height: Switch_5.h,
              colorBack: _mauCuaNut('Switch_5'),
              colorFront: Switch_5.colorFront,
              colorSplash: Switch_5.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Switch_5');
                chonViTri('Switch_5');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Switch_6.y),
            right: screen.getX(Switch_6.x),
            child: _directionButton(
              icon: Icons.toggle_on,
              tooltip: 'SW6',
              width: Switch_6.w,
              height: Switch_6.h,
              colorBack: _mauCuaNut('Switch_6'),
              colorFront: Switch_6.colorFront,
              colorSplash: Switch_6.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Switch_6');
                chonViTri('Switch_6');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Button_1.y),
            right: screen.getX(Button_1.x),
            child: _directionButton(
              icon: Icons.radio_button_checked,
              tooltip: 'BT1',
              width: Button_1.w,
              height: Button_1.h,
              colorBack: _mauCuaNut('Button_1'),
              colorFront: Button_1.colorFront,
              colorSplash: Button_1.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Button_1');
                chonViTri('Button_1');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Button_2.y),
            right: screen.getX(Button_2.x),
            child: _directionButton(
              icon: Icons.radio_button_checked,
              tooltip: 'BT2',
              width: Button_2.w,
              height: Button_2.h,
              colorBack: _mauCuaNut('Button_2'),
              colorFront: Button_2.colorFront,
              colorSplash: Button_2.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Button_2');
                chonViTri('Button_2');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Button_3.y),
            right: screen.getX(Button_3.x),
            child: _directionButton(
              icon: Icons.radio_button_checked,
              tooltip: 'BT3',
              width: Button_3.w,
              height: Button_3.h,
              colorBack: _mauCuaNut('Button_3'),
              colorFront: Button_3.colorFront,
              colorSplash: Button_3.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Button_3');
                chonViTri('Button_3');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Button_4.y),
            right: screen.getX(Button_4.x),
            child: _directionButton(
              icon: Icons.radio_button_checked,
              tooltip: 'BT4',
              width: Button_4.w,
              height: Button_4.h,
              colorBack: _mauCuaNut('Button_4'),
              colorFront: Button_4.colorFront,
              colorSplash: Button_4.coLorsplash,
              onPressed: () {
                xu_ly_khi_nhan_nut('Button_4');
                chonViTri('Button_4');
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(LM35.y),
            right: screen.getX(LM35.x),
            child: GestureDetector(
              onTap: () {
                xu_ly_khi_nhan_nut('LM35');
                chonViTri('LM35');
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _selected == 'LM35' ? Colors.pink : LM35.colorBack,
                  border: Border.all(
                    color: _selected == 'LM35' ? Colors.pink : LM35.colorFront,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Nhiệt Độ LM35: 28°C',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: LM35.coLorsplash,
                    fontFamily: selectedFont,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screen.getY(LOGO.y),
            right: screen.getX(LOGO.x),
            child: GestureDetector(
              onTap: () {
                xu_ly_khi_nhan_nut('LOGO');
                chonViTri('LOGO');
              },
              child: Image.asset(
                'assets/images/logo.png',
                width: LOGO.w,
                height: LOGO.h,
              ),
            ),
          ),
          // ==========================================
          // Đưa các nút di chuyển, phóng to, thu nhỏ và ok xuống dưới cùng của Stack
          // để chúng luôn nằm ở layer cao nhất và đè lên mọi nút khác
          // ==========================================
          Positioned(
            bottom: screen.getY(Di_chuyen_len.y),
            right: screen.getX(Di_chuyen_len.x),
            child: _directionButton(
              icon: Icons.keyboard_arrow_up,
              tooltip: '',
              width: Di_chuyen_len.w,
              height: Di_chuyen_len.h,
              colorBack: Di_chuyen_len.colorBack,
              colorFront: Di_chuyen_len.colorFront,
              colorSplash: Di_chuyen_len.coLorsplash,
              onPressed: diChuyenLen,
            ),
          ),
          Positioned(
            bottom: screen.getY(Di_chuyen_xuong.y),
            right: screen.getX(Di_chuyen_xuong.x),
            child: _directionButton(
              icon: Icons.keyboard_arrow_down,
              tooltip: '',
              width: Di_chuyen_xuong.w,
              height: Di_chuyen_xuong.h,
              colorBack: Di_chuyen_xuong.colorBack,
              colorFront: Di_chuyen_xuong.colorFront,
              colorSplash: Di_chuyen_xuong.coLorsplash,
              onPressed: diChuyenXuong,
            ),
          ),
          Positioned(
            bottom: screen.getY(Di_chuyen_trai.y),
            right: screen.getX(Di_chuyen_trai.x),
            child: _directionButton(
              icon: Icons.keyboard_arrow_left,
              tooltip: '',
              width: Di_chuyen_trai.w,
              height: Di_chuyen_trai.h,
              colorBack: Di_chuyen_trai.colorBack,
              colorFront: Di_chuyen_trai.colorFront,
              colorSplash: Di_chuyen_trai.coLorsplash,
              onPressed: diChuyenTrai,
            ),
          ),
          Positioned(
            bottom: screen.getY(Di_chuyen_phai.y),
            right: screen.getX(Di_chuyen_phai.x),
            child: _directionButton(
              icon: Icons.keyboard_arrow_right,
              tooltip: '',
              width: Di_chuyen_phai.w,
              height: Di_chuyen_phai.h,
              colorBack: Di_chuyen_phai.colorBack,
              colorFront: Di_chuyen_phai.colorFront,
              colorSplash: Di_chuyen_phai.coLorsplash,
              onPressed: diChuyenPhai,
            ),
          ),
          Positioned(
            bottom: screen.getY(Phong_to.y),
            right: screen.getX(Phong_to.x),
            child: _directionButton(
              icon: Icons.zoom_in,
              tooltip: '',
              width: Phong_to.w,
              height: Phong_to.h,
              colorBack: Phong_to.colorBack,
              colorFront: Phong_to.colorFront,
              colorSplash: Phong_to.coLorsplash,
              onPressed: phongTo,
            ),
          ),
          Positioned(
            bottom: screen.getY(Thu_nho.y),
            right: screen.getX(Thu_nho.x),
            child: _directionButton(
              icon: Icons.zoom_out,
              tooltip: '',
              width: Thu_nho.w,
              height: Thu_nho.h,
              colorBack: Thu_nho.colorBack,
              colorFront: Thu_nho.colorFront,
              colorSplash: Thu_nho.coLorsplash,
              onPressed: thuNho,
            ),
          ),
          Positioned(
            bottom: screen.getY(OK.y),
            right: screen.getX(OK.x),
            child: _directionButton(
              icon: Icons.check,
              tooltip: '',
              width: OK.w,
              height: OK.h,
              colorBack: OK.colorBack,
              colorFront: OK.colorFront,
              colorSplash: OK.coLorsplash,
              onPressed: () async {
                await luuViTri();
                if (mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _directionButton({
    required IconData icon,
    required String tooltip,
    required double width,
    required double height,
    required Color colorBack,
    required Color colorFront,
    required Color colorSplash,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: FloatingActionButton(
        onPressed: onPressed,
        // tooltip: tooltip,
        backgroundColor: colorBack,
        foregroundColor: colorFront,
        splashColor: colorSplash,
        elevation: 10,
        highlightElevation: 20,
        enableFeedback: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),

            if (tooltip.isNotEmpty)
              Text(
                tooltip,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Option3Page extends StatelessWidget {
  const Option3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth')),
      body: const Center(child: Text('Đây là trang Option 3')),
    );
  }
}

class Option4Page extends StatelessWidget {
  const Option4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TX-RX')),
      body: const Center(child: Text('Đây là trang Option 4')),
    );
  }
}