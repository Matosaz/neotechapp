import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'routes/RouteManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // <- AQUI!
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Poppins', fontSize: 20),
          bodyMedium: TextStyle(fontFamily: 'Poppins', fontSize: 18),
          bodySmall: TextStyle(fontFamily: 'Poppins', fontSize: 16),
        ),
      ),
      initialRoute: RouteManager.home, // define a rota inicial
      getPages: RouteManager.routes,    // importa suas rotas GetX
    );
  }
}
