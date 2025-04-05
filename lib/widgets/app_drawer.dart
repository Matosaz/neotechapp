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
                color: const Color(0xFF81B89A).withOpacity(0.3),
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
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 87, 87, 87),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            "usuario@gmail.com",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF757575),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.email, size: 16, color: Color(0xFF757575)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _buildDrawerItem(
              icon: Icons.home,
              text: "Início",
              onTap: () {},
            ),
            Divider(
  color: Colors.grey[300], // Cor sutil
  thickness: 0.5,            // Espessura da linha
  height: 10,              // Espaço vertical
  indent: 30,              // Espaço à esquerda
  endIndent: 30,           // Espaço à direita
),

            _buildDrawerItem(
              icon: Icons.settings,
              text: "Configurações",
              onTap: () {},
            ),
      Divider(
  color: Colors.grey[300], // Cor sutil
  thickness: 0.5,            // Espessura da linha
  height: 10,              // Espaço vertical
  indent: 30,              // Espaço à esquerda
  endIndent: 30,           // Espaço à direita
),

      
            _buildDrawerItem(
              icon: Icons.exit_to_app,
              text: "Sair",
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () => Get.offAllNamed(RouteManager.login),
            ),
      Divider(
  color: Colors.grey[300], // Cor sutil
  thickness: 0.5,            // Espessura da linha
  height: 10,              // Espaço vertical
  indent: 30,              // Espaço à esquerda
  endIndent: 30,           // Espaço à direita
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
    Color iconColor = const Color.fromARGB(255, 87, 87, 87),
    Color textColor = const Color(0xFF757575),
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 6),
        leading: Icon(icon, color: iconColor),
        title: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
