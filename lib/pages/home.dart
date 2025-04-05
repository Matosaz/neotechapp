import 'package:flutter/material.dart';
import 'package:neotechapp/widgets/custom_appbar.dart';
import 'package:neotechapp/widgets/app_drawer.dart';
import 'package:neotechapp/widgets/bottom_navbar.dart';
import 'package:get/get.dart';
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
  }
  final List<Widget> _pages = [
    const Center(
      child: Text(
        "Bem-vindo ao Flutter!",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
    ),
    const Center(child: Text("Buscar", style: TextStyle(fontFamily: 'Poppins'))),
    const Center(child: Text("Mensagens", style: TextStyle(fontFamily: 'Poppins'))),
  ];

  void _onTabChange(int index) {
    if (index == _selectedIndex) return; // Evita recriar a mesma tela

    if (index == 3) {
      Get.toNamed('/perfil');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
}
