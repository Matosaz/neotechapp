import 'package:get/get.dart';
import '../pages/home.dart';
import '../pages/login.dart';

class RouteManager {
  static String home = '/home';
  static String login = '/login';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: login, page: () => const LoginPage()),
  ];
}
