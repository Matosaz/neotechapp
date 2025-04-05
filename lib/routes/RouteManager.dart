import 'package:get/get.dart';
import '../pages/home.dart';
import '../pages/login.dart';
import '../pages/perfil.dart';

class RouteManager {
  static String home = '/home';
  static String login = '/login';
  static String perfil = '/perfil';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: perfil, page: () => const ProfileScreen()),

  ];
}
