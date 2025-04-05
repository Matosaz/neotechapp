import 'package:flutter/material.dart';
import 'package:neotechapp/widgets/custom_appbar.dart';
import 'package:neotechapp/widgets/app_drawer.dart';
import 'package:neotechapp/widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late TabController _tabController;

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
    const Center(child: Text("Perfil", style: TextStyle(fontFamily: 'Poppins'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
