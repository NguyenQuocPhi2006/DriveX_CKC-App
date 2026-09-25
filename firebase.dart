import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'more_settings.dart';

Future<void> initializeFirebase() async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}

Future<void> sendToConfiguredDatabase(String path, String data) async {
  final prefs = await SharedPreferences.getInstance();
  final databaseUrl = prefs.getString('custom_database_url')?.trim();
  final database = databaseUrl == null || databaseUrl.isEmpty
      ? FirebaseDatabase.instance
      : FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: databaseUrl,
        );

  // Truyền đường dẫn động vào thay vì cố định chữ 'test'
  await database.ref(path).set(data);
}

class Option2Page extends StatefulWidget {
  const Option2Page({super.key});

  @override
  State<Option2Page> createState() => _Option2PageState();
}

class _Option2PageState extends State<Option2Page> {
  final apiKeyController = TextEditingController();
  final dbUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedData(); // Tự động load dữ liệu cũ lên form (nếu có đã từng lưu)
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      apiKeyController.text = prefs.getString('custom_api_key') ?? '';
      dbUrlController.text = prefs.getString('custom_database_url') ?? '';
    });
  }

  Future<void> _saveConfig() async {
    final prefs = await SharedPreferences.getInstance();

    // Lưu vào SharedPreferences với đúng tên khóa mà hàm initializeFirebase đang đọc
    await prefs.setString('custom_api_key', apiKeyController.text.trim());
    await prefs.setString('custom_database_url', dbUrlController.text.trim());

    if (!mounted) return;

    // Hiển thị thông báo nhỏ cho người dùng biết đã lưu thành công
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã lưu thành công! Hãy khởi động lại app.',
          style: TextStyle(fontFamily: selectedFont),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Firebase RTDB',
          style: TextStyle(fontFamily: selectedFont),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Sửa thông tin Firebase',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: selectedFont,
              ),
            ),
            const SizedBox(height: 16),

            // Ô nhập API Key
            TextField(
              controller: apiKeyController,
              style: TextStyle(fontFamily: selectedFont),
              decoration: InputDecoration(
                labelText: 'API Key',
                labelStyle: TextStyle(fontFamily: selectedFont),
                border: const OutlineInputBorder(),
                // Thêm nút X ở đây
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    apiKeyController.clear(); // Xóa sạch nội dung ô API Key
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Ô nhập Database URL
            TextField(
              controller: dbUrlController,
              style: TextStyle(fontFamily: selectedFont),
              decoration: InputDecoration(
                labelText: 'Database URL',
                labelStyle: TextStyle(fontFamily: selectedFont),
                border: const OutlineInputBorder(),
                // Thêm nút X ở đây
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    dbUrlController.clear(); // Xóa sạch nội dung ô Database URL
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Nút Lưu gọi hàm _saveConfig
            ElevatedButton(
              onPressed: _saveConfig,
              child: Text(
                'Lưu và khởi động lại app',
                style: TextStyle(fontFamily: selectedFont),
              ),
            ),
          ],
        ),
      ),
    );
  }
}