import 'package:get/get.dart';
import '../pages/home.dart';
import '../pages/login.dart';
import '../pages/perfil.dart';
import '../pages/editperfil.dart';


class RouteManager {
  static String home = '/home';
  static String login = '/login';
  static String perfil = '/perfil';
  static String editperfil = '/editperfil';


  static List<GetPage> routes = [
    GetPage(
      name: '/home',
      page: () {
        final args = Get.arguments as int? ?? 0;
        return HomePage(initialIndex: args);
      },
    ),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: perfil, page: () => const ProfileScreen()),
    GetPage(name: editperfil, page: () => EditProfileScreen()),

  ];
}
