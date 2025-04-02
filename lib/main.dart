import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante inicialização correta
  await _loadData(); // Aguarda o carregamento antes de remover a splash
  FlutterNativeSplash.remove(); // Remove a splash após carregar os dados
  runApp(const MyApp());
}

Future<void> _loadData() async {
  await Future.delayed(const Duration(seconds: 3)); // Simula carregamento
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 228, 240, 221),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Poppins', fontSize: 20),
          bodyMedium: TextStyle(fontFamily: 'Poppins', fontSize: 18),
          bodySmall: TextStyle(fontFamily: 'Poppins', fontSize: 16),
        ),
      ),
      home: const HomePage(),
    );
  }
}
