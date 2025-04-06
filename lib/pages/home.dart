import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neotechapp/widgets/custom_appbar.dart';
import 'package:neotechapp/widgets/app_drawer.dart';
import 'package:neotechapp/widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;
  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }Widget buildTabBar() {
  return Positioned(
top: const CustomAppBar().preferredSize.height + MediaQuery.of(context).size.height * -.22,
    left: 0,
    right: 0,
    child: DefaultTabController(
      length: 3,
      child: Material(
        color: Colors.transparent,
        child: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xFF81B89A),
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
          onTap: (index) {
            Future.delayed(const Duration(milliseconds: 100), () {
              switch (index) {
                case 0: Get.toNamed('/pagina1'); break;
                case 1: Get.toNamed('/pagina2'); break;
                case 2: Get.toNamed('/pagina3'); break;
              }
            });
          },
          tabs: const [
            Tab(text: "Serviço"),
            Tab(text: "Mapa"),
            Tab(text: "Status"),
          ],
        ),
      ),
    ),
  );
}



  void _onTabChange(int index) {
    if (index == _selectedIndex) return;
    if (index == 3) {
      Get.toNamed('/perfil');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }@override
Widget build(BuildContext context) {
  return Scaffold(
    drawer: const CustomDrawer(),
    body: Stack(
      children: [
        // AppBar personalizada
        const CustomAppBar(),

        // Exibe a TabBar apenas se estiver na tela inicial (índice 0)
        if (_selectedIndex == 0)
          Positioned(
            top: 140, // ajuste conforme a altura da curva
            left: 0,
            right: 0,
            child: buildTabBar(),
          ),

        // Conteúdo da página
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              Container(), // Home
              const Center(child: Text("Buscar")),
              const Center(child: Text("Mensagens")),
            ],
          ),
        ),
      ],
    ),
    bottomNavigationBar: BottomNavBar(
      selectedIndex: _selectedIndex,
      onTabChange: _onTabChange,
    ),
  );
}
}