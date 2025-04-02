import 'package:flutter/material.dart';
import 'package:neotechapp/pages/login.dart'; // Importando a página de login

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: const Center(
        child: Text(
          "Bem-vindo ao Flutter!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins', // Fonte personalizada
          ),
        ),
      ),
    );
  }
}

// ------------------- APP BAR -------------------
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "NeoTech",
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Poppins', // Fonte personalizada
        ),
      ),
      elevation: 10,
      shadowColor: Colors.black26,
      backgroundColor: const Color.fromARGB(255, 171, 218, 156),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

// ------------------- DRAWER -------------------
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 171, 218, 156),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black, size: 30),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Usuário",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins', // Fonte personalizada
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
            title: const Text("Sair", style: TextStyle(fontFamily: 'Poppins')),
            onTap: () {
              // Redirecionar para a tela de login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const login()),
              );
            },
          )
        ],
      ),
    );
  }
}

// ------------------- SEARCH -------------------
class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text("Resultado para \"$query\"", style: const TextStyle(fontFamily: 'Poppins')));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Digite algo para pesquisar...", style: const TextStyle(fontFamily: 'Poppins')));
  }
}
