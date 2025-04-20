import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            color: Colors.grey[800],
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: const Color(0xFF81B89A).withOpacity(1.0),
            tabs: const [
              GButton(icon: Icons.home, text: 'Início'),
              GButton(icon: Icons.search, text: 'Buscar'),
              GButton(icon: Icons.recycling_rounded, text: 'Histórico'),
              GButton(icon: Icons.person, text: 'Perfil'),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}
