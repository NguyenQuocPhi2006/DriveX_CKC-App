import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
// import 'firebase.dart';
import 'config_send_BLE_FB.dart';
import 'set_thao_tac_tay.dart';
import 'TX_RX.dart';
import 'more_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  WidgetPosition option1 = WidgetPosition(
    // chỉnh thao tác tay
    x: 60,
    y: 50,
    w: 300,
    h: 60,
    colorBack: Colors.blue,
    colorFront: Colors.white,
    coLorsplash: Colors.yellow,
    data: "",
    data_falling: "",
    status: "",
  );
  WidgetPosition option2 = WidgetPosition(
    // bluetooth/firebase
    x: 6,
    y: 50,
    w: 300,
    h: 60,
    colorBack: Colors.blue,
    colorFront: Colors.white,
    coLorsplash: Colors.yellow,
    data: "",
    data_falling: "",
    status: "",
  );
  WidgetPosition option3 = WidgetPosition(
    // more settings
    x: 60,
    y: 20,
    w: 300,
    h: 60,
    colorBack: Colors.blue,
    colorFront: Colors.white,
    coLorsplash: Colors.yellow,
    data: "",
    data_falling: "",
    status: "",
  );
  WidgetPosition option4 = WidgetPosition(
    // TX-RX
    x: 6,
    y: 20,
    w: 300,
    h: 60,
    colorBack: Colors.blue,
    colorFront: Colors.white,
    coLorsplash: Colors.yellow,
    data: "",
    data_falling: "",
    status: "",
  );

  @override
  Widget build(BuildContext context) {
    Widget _buildCustomMenuButton({
      required String title,
      required IconData icon,
      bool isSelected = false,
      required VoidCallback onTap,
    }) {
      return Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: selectedFont,
                        color: isSelected
                            ? Colors.blue.shade900
                            : Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final screenSize = ScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cài đặt',
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

          // --- OPTION 1 ---
          Positioned(
            bottom: screenSize.getY(option1.y),
            right: screenSize.getX(option1.x),
            child: SizedBox(
              width: option1.w,
              height: option1.h,
              child: _buildCustomMenuButton(
                title: 'Set Thao Tác Tay',
                icon: Icons.settings_accessibility,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Set_Thao_Tac_Tay(),
                    ),
                  );
                },
              ),
            ),
          ),

          // --- OPTION 2 ---
          Positioned(
            bottom: screenSize.getY(option2.y),
            right: screenSize.getX(option2.x),
            child: SizedBox(
              width: option2.w,
              height: option2.h,
              child: _buildCustomMenuButton(
                title: 'Bluetooth/Firebase',
                icon: Icons.swap_horiz,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChoiceScreen(),
                    ),
                  );
                },
              ),
            ),
          ),

          // --- OPTION 3 ---
          Positioned(
            bottom: screenSize.getY(option3.y),
            right: screenSize.getX(option3.x),
            child: SizedBox(
              width: option3.w,
              height: option3.h,
              child: _buildCustomMenuButton(
                title: 'More Settings',
                icon: Icons.tune,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MoreSettingsPage(),
                    ),
                  );
                },
              ),
            ),
          ),

          // --- OPTION 4 ---
          Positioned(
            bottom: screenSize.getY(option4.y),
            right: screenSize.getX(option4.x),
            child: SizedBox(
              width: option4.w,
              height: option4.h,
              child: _buildCustomMenuButton(
                title: 'TX-RX',
                icon: Icons.compare_arrows,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TX_RX(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}