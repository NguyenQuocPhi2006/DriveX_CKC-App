import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase.dart';
import 'home.dart';
import 'more_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  try {
    await initializeFirebase();
  } catch (error) {
    debugPrint('Firebase chưa được khởi tạo: $error');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: selectedFont, // Thêm dòng này để áp dụng font Inter toàn cục
        colorScheme: ColorScheme.fromSeed(seedColor: AppBar_my),
      ),
      home: MyHomePage(title: Ten_Nhom),
    );
  }
}
