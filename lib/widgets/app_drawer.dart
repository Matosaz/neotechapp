import 'package:flutter/material.dart';
import 'package:neotechapp/routes/RouteManager.dart';
import 'package:get/get.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 255, 255, 255), // Cor de fundo geral do drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF81B89A).withOpacity(0.3), // Fundo do header
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.black, size: 30),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Usuário",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black),
              title: const Text("Início", style: TextStyle(fontFamily: 'Poppins')),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text("Configurações", style: TextStyle(fontFamily: 'Poppins')),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text("Sair", style: TextStyle(fontFamily: 'Poppins', color: Colors.red)),
              onTap: () {
              
                 Get.offAllNamed(RouteManager.login);
            
              },
            ),
          ],
        ),
      ),
    );
  }
}
