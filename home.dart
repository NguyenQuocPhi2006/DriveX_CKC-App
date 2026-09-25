import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';
import 'more_settings.dart';
import 'bluetooth_classic.dart';
import 'config_send_BLE_FB.dart';
import 'config_send_classic_BLE.dart';
import 'bluetooth_BLE.dart';

// import 'package:firebase_database/firebase_database.dart';
import 'firebase.dart';

String path_one = "test";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class WidgetPosition {
  WidgetPosition({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.colorBack,
    required this.colorFront,
    required this.coLorsplash,
    required this.data,
    required this.data_falling,
    required this.status,
  });

  double x;
  double y;
  double w;
  double h;
  Color colorBack;
  Color colorFront;
  Color coLorsplash;
  // biến String để gửi kí tự lên firebase
  String data;
  String data_falling;
  String status;
}

WidgetPosition Tien = WidgetPosition(
  x: 76,
  y: 43,
  w: 90,
  h: 90,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: BTN_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Lui = WidgetPosition(
  x: 76,
  y: 9,
  w: 90,
  h: 90,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: BTN_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Trai = WidgetPosition(
  x: 25,
  y: 26,
  w: 90,
  h: 90,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: BTN_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Phai = WidgetPosition(
  x: 7,
  y: 26,
  w: 90,
  h: 90,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: BTN_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition LM35 = WidgetPosition(
  x: 73,
  y: 72,
  w: 0,
  h: 0,
  colorBack: Colors.white,
  colorFront: Colors.black,
  coLorsplash: Colors.black,
  data: "LM35",
  data_falling: "",
  status: "",
);
WidgetPosition Settings = WidgetPosition(
  x: 1,
  y: 76,
  w: 30,
  h: 30,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: BTN_splash,
  data: "",
  data_falling: "",
  status: "",
);
WidgetPosition Switch_1 = WidgetPosition(
  x: 58,
  y: 70,
  w: 40,
  h: 40,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: SW_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Switch_2 = WidgetPosition(
  x: 48,
  y: 70,
  w: 40,
  h: 40,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: SW_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Switch_3 = WidgetPosition(
  x: 38,
  y: 70,
  w: 40,
  h: 40,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: SW_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Switch_4 = WidgetPosition(
  x: 28,
  y: 70,
  w: 40,
  h: 40,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: SW_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Switch_5 = WidgetPosition(
  x: 18,
  y: 70,
  w: 40,
  h: 40,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: SW_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Switch_6 = WidgetPosition(
  x: 8,
  y: 70,
  w: 40,
  h: 40,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: SW_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Button_1 = WidgetPosition(
  x: 2,
  y: 3,
  w: 40,
  h: 40,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: BTN_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Button_2 = WidgetPosition(
  x: 12,
  y: 3,
  w: 40,
  h: 40,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: BTN_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Button_3 = WidgetPosition(
  x: 22,
  y: 3,
  w: 40,
  h: 40,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: BTN_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
WidgetPosition Button_4 = WidgetPosition(
  x: 32,
  y: 3,
  w: 40,
  h: 40,
  colorBack: BTN_SW_back,
  colorFront: BTN_SW_front,
  coLorsplash: BTN_splash,
  data: "T",
  data_falling: "F",
  status: "F",
);
// muốn khai báo LOGO kiểu WidgetPosition
WidgetPosition LOGO = WidgetPosition(
  x: 89,
  y: 2,
  w: 100,
  h: 100,
  colorBack: Colors.blue,
  colorFront: Colors.white,
  coLorsplash: Colors.yellow,
  data: "T",
  data_falling: "F",
  status: "F",
);

class ScreenSize {
  final Size size;

  ScreenSize(BuildContext context) : size = MediaQuery.sizeOf(context);

  double getX(double x) {
    return size.width * x / 100;
  }

  double getY(double y) {
    return size.height * y / 100;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSW1_ON = false;
  bool isSW2_ON = false;
  bool isSW3_ON = false;
  bool isSW4_ON = false;
  bool isSW5_ON = false;
  bool isSW6_ON = false;

  String path_All = "All";

  int nhiet_do = 0;

  void TransmitData_All(String path) {
    String combinedData = [
      Tien.status,
      Lui.status,
      Trai.status,
      Phai.status,
      Switch_1.status,
      Switch_2.status,
      Switch_3.status,
      Switch_4.status,
      Switch_5.status,
      Switch_6.status,
      Button_1.status,
      Button_2.status,
      Button_3.status,
      Button_4.status,
    ].join(":"); // Tự động nối tất cả lại bằng dấu hai chấm
    sendToConfiguredDatabase(
      path + "/" + path_All,
      combinedData,
    ); // Gọi hàm gửi dữ liệu tổng hợp
  }

  Future<void> TransmitData(String path, String data) async {
    // Biến toàn cục isBluetoothMode quản lý chế độ: true = Bluetooth, false = Firebase
    if (!isBluetoothMode) {
      await sendToConfiguredDatabase(path, data);
      TransmitData_All(path_one);
    } else {
      //gửi qua bluetooth
      if(isClassicMode == true) {
        await Sen_Bluetooth_String(data);
      } else {
        await Sen_Bluetooth_BLE_String(data);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPositions();
  }

  // Hàm cập nhật màu sắc mới cho tất cả các nút điều khiển
  void _updateAllButtonColors() {
    List<WidgetPosition> buttonsOnly = [
      Tien,
      Lui,
      Trai,
      Phai,
      Button_1,
      Button_2,
      Button_3,
      Button_4,
      Settings,
    ];
    List<WidgetPosition> switchesOnly = [
      Switch_1,
      Switch_2,
      Switch_3,
      Switch_4,
      Switch_5,
      Switch_6,
    ];

    for (var btn in buttonsOnly) {
      btn.colorBack = BTN_SW_back;
      btn.colorFront = BTN_SW_front;
      btn.coLorsplash = BTN_splash;
    }

    for (var sw in switchesOnly) {
      sw.colorBack = BTN_SW_back;
      sw.colorFront = BTN_SW_front;
      sw.coLorsplash = SW_splash; // giữ đúng màu splash riêng cho switch
    }
  }

  Future<void> _loadPositions() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      enable_logo = prefs.getBool('enable_logo') ?? enable_logo;
      enable_temperature =
          prefs.getBool('enable_temperature') ?? enable_temperature;
      // Các dòng đọc vị trí nút khác của bạn giữ nguyên...
    });

    // 2. Đọc tên nhóm
    Ten_Nhom = prefs.getString('ten_nhom') ?? Ten_Nhom;

    // 3. Đọc màu sắc của nút và áp dụng ngay lập tức
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

    _updateAllButtonColors();

    Tien.x = prefs.getDouble('tien_x') ?? Tien.x;
    Tien.y = prefs.getDouble('tien_y') ?? Tien.y;
    Tien.w = prefs.getDouble('tien_w') ?? Tien.w;
    Tien.h = prefs.getDouble('tien_h') ?? Tien.h;
    Tien.data = prefs.getString('tien_data') ?? Tien.data;
    Tien.data_falling =
        prefs.getString('tien_data_falling') ?? Tien.data_falling;

    Lui.x = prefs.getDouble('lui_x') ?? Lui.x;
    Lui.y = prefs.getDouble('lui_y') ?? Lui.y;
    Lui.w = prefs.getDouble('lui_w') ?? Lui.w;
    Lui.h = prefs.getDouble('lui_h') ?? Lui.h;
    Lui.data = prefs.getString('lui_data') ?? Lui.data;
    Lui.data_falling = prefs.getString('lui_data_falling') ?? Lui.data_falling;

    Trai.x = prefs.getDouble('trai_x') ?? Trai.x;
    Trai.y = prefs.getDouble('trai_y') ?? Trai.y;
    Trai.w = prefs.getDouble('trai_w') ?? Trai.w;
    Trai.h = prefs.getDouble('trai_h') ?? Trai.h;
    Trai.data = prefs.getString('trai_data') ?? Trai.data;
    Trai.data_falling =
        prefs.getString('trai_data_falling') ?? Trai.data_falling;

    Phai.x = prefs.getDouble('phai_x') ?? Phai.x;
    Phai.y = prefs.getDouble('phai_y') ?? Phai.y;
    Phai.w = prefs.getDouble('phai_w') ?? Phai.w;
    Phai.h = prefs.getDouble('phai_h') ?? Phai.h;
    Phai.data = prefs.getString('phai_data') ?? Phai.data;
    Phai.data_falling =
        prefs.getString('phai_data_falling') ?? Phai.data_falling;

    LM35.x = prefs.getDouble('lm35_x') ?? LM35.x;
    LM35.y = prefs.getDouble('lm35_y') ?? LM35.y;
    LM35.w = prefs.getDouble('lm35_w') ?? LM35.w;
    LM35.h = prefs.getDouble('lm35_h') ?? LM35.h;

    Button_1.x = prefs.getDouble('button_1_x') ?? Button_1.x;
    Button_1.y = prefs.getDouble('button_1_y') ?? Button_1.y;
    Button_1.w = prefs.getDouble('button_1_w') ?? Button_1.w;
    Button_1.h = prefs.getDouble('button_1_h') ?? Button_1.h;
    Button_1.data = prefs.getString('button_1_data') ?? Button_1.data;
    Button_1.data_falling =
        prefs.getString('button_1_data_falling') ?? Button_1.data_falling;

    Button_2.x = prefs.getDouble('button_2_x') ?? Button_2.x;
    Button_2.y = prefs.getDouble('button_2_y') ?? Button_2.y;
    Button_2.w = prefs.getDouble('button_2_w') ?? Button_2.w;
    Button_2.h = prefs.getDouble('button_2_h') ?? Button_2.h;
    Button_2.data = prefs.getString('button_2_data') ?? Button_2.data;
    Button_2.data_falling =
        prefs.getString('button_2_data_falling') ?? Button_2.data_falling;

    Button_3.x = prefs.getDouble('button_3_x') ?? Button_3.x;
    Button_3.y = prefs.getDouble('button_3_y') ?? Button_3.y;
    Button_3.w = prefs.getDouble('button_3_w') ?? Button_3.w;
    Button_3.h = prefs.getDouble('button_3_h') ?? Button_3.h;
    Button_3.data = prefs.getString('button_3_data') ?? Button_3.data;
    Button_3.data_falling =
        prefs.getString('button_3_data_falling') ?? Button_3.data_falling;

    Button_4.x = prefs.getDouble('button_4_x') ?? Button_4.x;
    Button_4.y = prefs.getDouble('button_4_y') ?? Button_4.y;
    Button_4.w = prefs.getDouble('button_4_w') ?? Button_4.w;
    Button_4.h = prefs.getDouble('button_4_h') ?? Button_4.h;
    Button_4.data = prefs.getString('button_4_data') ?? Button_4.data;
    Button_4.data_falling =
        prefs.getString('button_4_data_falling') ?? Button_4.data_falling;

    Switch_1.x = prefs.getDouble('switch_1_x') ?? Switch_1.x;
    Switch_1.y = prefs.getDouble('switch_1_y') ?? Switch_1.y;
    Switch_1.w = prefs.getDouble('switch_1_w') ?? Switch_1.w;
    Switch_1.h = prefs.getDouble('switch_1_h') ?? Switch_1.h;
    Switch_1.data = prefs.getString('switch_1_data') ?? Switch_1.data;
    Switch_1.data_falling =
        prefs.getString('switch_1_data_falling') ?? Switch_1.data_falling;

    Switch_2.x = prefs.getDouble('switch_2_x') ?? Switch_2.x;
    Switch_2.y = prefs.getDouble('switch_2_y') ?? Switch_2.y;
    Switch_2.w = prefs.getDouble('switch_2_w') ?? Switch_2.w;
    Switch_2.h = prefs.getDouble('switch_2_h') ?? Switch_2.h;
    Switch_2.data = prefs.getString('switch_2_data') ?? Switch_2.data;
    Switch_2.data_falling =
        prefs.getString('switch_2_data_falling') ?? Switch_2.data_falling;

    Switch_3.x = prefs.getDouble('switch_3_x') ?? Switch_3.x;
    Switch_3.y = prefs.getDouble('switch_3_y') ?? Switch_3.y;
    Switch_3.w = prefs.getDouble('switch_3_w') ?? Switch_3.w;
    Switch_3.h = prefs.getDouble('switch_3_h') ?? Switch_3.h;
    Switch_3.data = prefs.getString('switch_3_data') ?? Switch_3.data;
    Switch_3.data_falling =
        prefs.getString('switch_3_data_falling') ?? Switch_3.data_falling;

    Switch_4.x = prefs.getDouble('switch_4_x') ?? Switch_4.x;
    Switch_4.y = prefs.getDouble('switch_4_y') ?? Switch_4.y;
    Switch_4.w = prefs.getDouble('switch_4_w') ?? Switch_4.w;
    Switch_4.h = prefs.getDouble('switch_4_h') ?? Switch_4.h;
    Switch_4.data = prefs.getString('switch_4_data') ?? Switch_4.data;
    Switch_4.data_falling =
        prefs.getString('switch_4_data_falling') ?? Switch_4.data_falling;

    Switch_5.x = prefs.getDouble('switch_5_x') ?? Switch_5.x;
    Switch_5.y = prefs.getDouble('switch_5_y') ?? Switch_5.y;
    Switch_5.w = prefs.getDouble('switch_5_w') ?? Switch_5.w;
    Switch_5.h = prefs.getDouble('switch_5_h') ?? Switch_5.h;
    Switch_5.data = prefs.getString('switch_5_data') ?? Switch_5.data;
    Switch_5.data_falling =
        prefs.getString('switch_5_data_falling') ?? Switch_5.data_falling;

    Switch_6.x = prefs.getDouble('switch_6_x') ?? Switch_6.x;
    Switch_6.y = prefs.getDouble('switch_6_y') ?? Switch_6.y;
    Switch_6.w = prefs.getDouble('switch_6_w') ?? Switch_6.w;
    Switch_6.h = prefs.getDouble('switch_6_h') ?? Switch_6.h;
    Switch_6.data = prefs.getString('switch_6_data') ?? Switch_6.data;
    Switch_6.data_falling =
        prefs.getString('switch_6_data_falling') ?? Switch_6.data_falling;

    LOGO.x = prefs.getDouble('logo_x') ?? LOGO.x;
    LOGO.y = prefs.getDouble('logo_y') ?? LOGO.y;
    LOGO.w = prefs.getDouble('logo_w') ?? LOGO.w;
    LOGO.h = prefs.getDouble('logo_h') ?? LOGO.h;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 25,
        backgroundColor: AppBar_my,
        title: Text(Ten_Nhom),
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
              colorBack: Tien.colorBack,
              colorFront: Tien.colorFront,
              colorSplash: Tien.coLorsplash,
              onPointerDown: (event) {
                Tien.status = Tien.data;
                TransmitData(path_one + "/Tien", Tien.data);
              },
              onPointerUp: (event) {
                Tien.status = Tien.data_falling;
                TransmitData(path_one + "/Tien", Tien.data_falling);
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
              colorBack: Lui.colorBack,
              colorFront: Lui.colorFront,
              colorSplash: Lui.coLorsplash,
              onPointerDown: (event) {
                Lui.status = Lui.data;
                TransmitData(path_one + "/Lui", Lui.data);
              },
              onPointerUp: (event) {
                Lui.status = Lui.data_falling;
                TransmitData(path_one + "/Lui", Lui.data_falling);
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
              colorBack: Trai.colorBack,
              colorFront: Trai.colorFront,
              colorSplash: Trai.coLorsplash,
              onPointerDown: (event) {
                Trai.status = Trai.data;
                TransmitData(path_one + "/Trai", Trai.data);
              },
              onPointerUp: (event) {
                Trai.status = Trai.data_falling;
                TransmitData(path_one + "/Trai", Trai.data_falling);
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
              colorBack: Phai.colorBack,
              colorFront: Phai.colorFront,
              colorSplash: Phai.coLorsplash,
              onPointerDown: (event) {
                Phai.status = Phai.data;
                TransmitData(path_one + "/Phai", Phai.data);
              },
              onPointerUp: (event) {
                Phai.status = Phai.data_falling;
                TransmitData(path_one + "/Phai", Phai.data_falling);
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Settings.y),
            right: screen.getX(Settings.x),
            child: _directionButton(
              icon: Icons.settings,
              tooltip: '',
              width: Settings.w,
              height: Settings.h,
              colorBack: Settings.colorBack,
              colorFront: Settings.colorFront,
              colorSplash: Settings.coLorsplash,
              onPointerDown: (event) {},
              onPointerUp: (event) async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
                await _loadPositions();
              },
            ),
          ),
          if (enable_temperature)
            Positioned(
              bottom: screen.getY(LM35.y),
              right: screen.getX(LM35.x),
              child: GestureDetector(
                onTap: () {
                  // tạm thời để trống
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: LM35.colorBack,
                    border: Border.all(color: LM35.colorFront),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Nhiệt Độ LM35: ' + nhiet_do.toString() + '°C',
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
          //Switch_1
          Positioned(
            bottom: screen.getY(Switch_1.y),
            right: screen.getX(Switch_1.x),
            child: _directionSwitch(
              icon: Icons.toggle_on,
              tooltip: 'SW1',
              width: Switch_1.w,
              height: Switch_1.h,
              colorBack: Switch_1.colorBack,
              colorFront: Switch_1.colorFront,
              colorSplash: Switch_1.coLorsplash,
              onPressed: () {
                isSW1_ON = !isSW1_ON;
                Switch_1.status = isSW1_ON
                    ? Switch_1.data
                    : Switch_1.data_falling;
                TransmitData(
                  path_one + "/SW1",
                  isSW1_ON ? Switch_1.data : Switch_1.data_falling,
                );
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Switch_2.y),
            right: screen.getX(Switch_2.x),
            child: _directionSwitch(
              icon: Icons.toggle_on,
              tooltip: 'SW2',
              width: Switch_2.w,
              height: Switch_2.h,
              colorBack: Switch_2.colorBack,
              colorFront: Switch_2.colorFront,
              colorSplash: Switch_2.coLorsplash,
              onPressed: () {
                isSW2_ON = !isSW2_ON;
                Switch_2.status = isSW2_ON
                    ? Switch_2.data
                    : Switch_2.data_falling;
                TransmitData(
                  path_one + "/SW2",
                  isSW2_ON ? Switch_2.data : Switch_2.data_falling,
                );
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Switch_3.y),
            right: screen.getX(Switch_3.x),
            child: _directionSwitch(
              icon: Icons.toggle_on,
              tooltip: 'SW3',
              width: Switch_3.w,
              height: Switch_3.h,
              colorBack: Switch_3.colorBack,
              colorFront: Switch_3.colorFront,
              colorSplash: Switch_3.coLorsplash,
              onPressed: () {
                isSW3_ON = !isSW3_ON;
                Switch_3.status = isSW3_ON
                    ? Switch_3.data
                    : Switch_3.data_falling;
                TransmitData(
                  path_one + "/SW3",
                  isSW3_ON ? Switch_3.data : Switch_3.data_falling,
                );
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Switch_4.y),
            right: screen.getX(Switch_4.x),
            child: _directionSwitch(
              icon: Icons.toggle_on,
              tooltip: 'SW4',
              width: Switch_4.w,
              height: Switch_4.h,
              colorBack: Switch_4.colorBack,
              colorFront: Switch_4.colorFront,
              colorSplash: Switch_4.coLorsplash,
              onPressed: () {
                isSW4_ON = !isSW4_ON;
                Switch_4.status = isSW4_ON
                    ? Switch_4.data
                    : Switch_4.data_falling;
                TransmitData(
                  path_one + "/SW4",
                  isSW4_ON ? Switch_4.data : Switch_4.data_falling,
                );
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Switch_5.y),
            right: screen.getX(Switch_5.x),
            child: _directionSwitch(
              icon: Icons.toggle_on,
              tooltip: 'SW5',
              width: Switch_5.w,
              height: Switch_5.h,
              colorBack: Switch_5.colorBack,
              colorFront: Switch_5.colorFront,
              colorSplash: Switch_5.coLorsplash,
              onPressed: () {
                isSW5_ON = !isSW5_ON;
                Switch_5.status = isSW5_ON
                    ? Switch_5.data
                    : Switch_5.data_falling;
                TransmitData(
                  path_one + "/SW5",
                  isSW5_ON ? Switch_5.data : Switch_5.data_falling,
                );
              },
            ),
          ),
          Positioned(
            bottom: screen.getY(Switch_6.y),
            right: screen.getX(Switch_6.x),
            child: _directionSwitch(
              icon: Icons.toggle_on,
              tooltip: 'SW6',
              width: Switch_6.w,
              height: Switch_6.h,
              colorBack: Switch_6.colorBack,
              colorFront: Switch_6.colorFront,
              colorSplash: Switch_6.coLorsplash,
              onPressed: () {
                isSW6_ON = !isSW6_ON;
                Switch_6.status = isSW6_ON
                    ? Switch_6.data
                    : Switch_6.data_falling;
                TransmitData(
                  path_one + "/SW6",
                  isSW6_ON ? Switch_6.data : Switch_6.data_falling,
                );
              },
            ),
          ),
          //Button_1
          Positioned(
            bottom: screen.getY(Button_1.y),
            right: screen.getX(Button_1.x),
            child: _directionButton(
              icon: Icons.radio_button_checked,
              tooltip: 'BT1',
              width: Button_1.w,
              height: Button_1.h,
              colorBack: Button_1.colorBack,
              colorFront: Button_1.colorFront,
              colorSplash: Button_1.coLorsplash,
              onPointerDown: (event) {
                Button_1.status = Button_1.data;
                TransmitData(path_one + "/BT1", Button_1.data);
              },
              onPointerUp: (event) {
                Button_1.status = Button_1.data_falling;
                TransmitData(path_one + "/BT1", Button_1.data_falling);
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
              colorBack: Button_2.colorBack,
              colorFront: Button_2.colorFront,
              colorSplash: Button_2.coLorsplash,
              onPointerDown: (event) {
                Button_2.status = Button_2.data;
                TransmitData(path_one + "/BT2", Button_2.data);
              },
              onPointerUp: (event) {
                Button_2.status = Button_2.data_falling;
                TransmitData(path_one + "/BT2", Button_2.data_falling);
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
              colorBack: Button_3.colorBack,
              colorFront: Button_3.colorFront,
              colorSplash: Button_3.coLorsplash,
              onPointerDown: (event) {
                Button_3.status = Button_3.data;
                TransmitData(path_one + "/BT3", Button_3.data);
              },
              onPointerUp: (event) {
                Button_3.status = Button_3.data_falling;
                TransmitData(path_one + "/BT3", Button_3.data_falling);
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
              colorBack: Button_4.colorBack,
              colorFront: Button_4.colorFront,
              colorSplash: Button_4.coLorsplash,
              onPointerDown: (event) {
                Button_4.status = Button_4.data;
                TransmitData(path_one + "/BT4", Button_4.data);
              },
              onPointerUp: (event) {
                Button_4.status = Button_4.data_falling;
                TransmitData(path_one + "/BT4", Button_4.data_falling);
              },
            ),
          ),
          enable_logo
              ? Positioned(
                  bottom: screen.getY(LOGO.y),
                  right: screen.getX(LOGO.x),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: LOGO.w,
                    height: LOGO.h,
                  ),
                )
              : const SizedBox.shrink(),
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
    required PointerDownEventListener? onPointerDown,
    required PointerUpEventListener? onPointerUp,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: Listener(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16), // Hình vuông bo 4 góc
            splashColor: colorSplash,
            highlightColor: colorSplash,
            child: Ink(
              decoration: BoxDecoration(
                color: colorBack,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: IconTheme(
                  data: IconThemeData(color: colorFront),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: colorFront),
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _directionSwitch({
    required IconData icon,
    required String tooltip,
    required double width,
    required double height,
    required Color colorBack,
    required Color colorFront,
    required Color colorSplash,
    required VoidCallback? onPressed,
  }) {
    bool isOn = false; // Biến trạng thái bật/tắt riêng cho switch

    return StatefulBuilder(
      builder: (context, setStateSwitch) {
        return SizedBox(
          width: width,
          height: height,
          child: Material(
            color: Colors.transparent,
            child: Listener(
              onPointerDown: (event) {
                // Đảo trạng thái Bật/Tắt ngay lập tức 0 độ trễ khi chạm
                onPressed?.call();
                setStateSwitch(() {
                  isOn = !isOn;
                });
                print(
                  "Cạnh lên: Đã chạm Switch (Trạng thái hiện tại: ${isOn ? 'BẬT' : 'TẮT'})",
                );
              },
              child: Ink(
                decoration: BoxDecoration(
                  // Nếu đang bật (isOn = true) thì đổi sang colorSplash, ngược lại giữ colorBack
                  color: isOn ? colorSplash : colorBack,
                  borderRadius: BorderRadius.circular(
                    16,
                  ), // Hình vuông bo 4 góc
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(
                      // Khi bật có thể đổi màu icon thành đen hoặc giữ colorFront tùy bạn
                      color: isOn ? Colors.black : colorFront,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, color: isOn ? Colors.black : colorFront),
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
