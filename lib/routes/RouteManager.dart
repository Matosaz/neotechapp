import 'package:get/get.dart';
import '../pages/home.dart';
import '../pages/login.dart';
import '../pages/perfil.dart';
import '../pages/editperfil.dart';
import '../pages/acompanhamentocoleta.dart';
import '../pages/historicoreciclado.dart';
import '../pages/historicoservico.dart';

class RouteManager {
  static String home = '/home';
  static String login = '/login';
  static String perfil = '/perfil';
  static String editperfil = '/editperfil';
  static String acompanhamento = '/acompanhamento';
  static String historico = '/historico';
  static String historicoServico = '/historicoServico';

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
    GetPage(name: acompanhamento, page: () => const TrackingScreen()),
    GetPage(name: historico, page: () => const RecyclingProgressScreen()),
    GetPage(name: historicoServico, page: () => const ElegantCollectionHistory()),

  ];
}
