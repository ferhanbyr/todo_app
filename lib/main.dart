import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/services/database_service.dart';
import 'package:provider/provider.dart';


void main() async {
  // Flutter'ı hazırla
  WidgetsFlutterBinding.ensureInitialized();

  // Veritabanını başlat
  await DatabaseService.initialize();

  // Widgetları Çiz
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}