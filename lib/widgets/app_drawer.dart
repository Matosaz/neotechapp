import 'package:flutter/material.dart';
import 'package:neotechapp/routes/RouteManager.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 250, 250),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("https://i.postimg.cc/0jqKB6mS/Profile-Image.png"),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "João",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "usuario@gmail.com",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildDrawerItem(icon: Icons.person, text: "Perfil", onTap: () {Get.toNamed("/perfil");}),
            _buildDrawerItem(icon: Icons.live_tv, text: "Futuro", onTap: () {}),
            _buildDrawerItem(icon: Icons.play_circle_outline, text: "Futuro", onTap: () {}),
            _buildDrawerItem(icon: Icons.subscriptions, text: "Futuro", onTap: () {}),
            _buildDrawerItem(icon: Icons.credit_card, text: "Futuro", onTap: () {}),
         
            const SizedBox(height: 20),
            const Divider(indent: 10, endIndent: 10),
            _buildDrawerItem(
              icon: Icons.logout,
              text: "Sair da conta",
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () => Get.offAllNamed(RouteManager.login),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
    Color iconColor =  const Color(0xFF81B89A),
    Color textColor = Colors.black87,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 22),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
          fontWeight: FontWeight.w500,
                  color: Color(0xFF757575),
        ),
      ),
      onTap: onTap,
    );
  }
}
