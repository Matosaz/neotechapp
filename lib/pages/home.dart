import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neotechapp/widgets/custom_appbar.dart';
import 'package:neotechapp/widgets/app_drawer.dart';
import 'package:neotechapp/widgets/bottom_navbar.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:provider/provider.dart'; // Importar provider
import '../userProvider/UserProvider.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;

  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

Widget _buildCategoryItem(String title, IconData icon, bool selected) {
  return Padding(
    padding: const EdgeInsets.only(right: 15.0),
    child: Column(
      children: [
        Container(
          width: 70,
          height: 70, // Altura aumentada para formato de elipse vertical
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF81B89A) : Colors.white,
            borderRadius: BorderRadius.circular(20), // Formato de elipse
            border: Border.all(
              color:
                  selected
                      ? const Color(0xFF81B89A)
                      : const Color.fromARGB(10, 85, 85, 85),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color:
                selected
                    ? Colors.white
                    : const Color.fromARGB(255, 104, 104, 104),
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color:
                selected
                    ? Colors.green.shade900
                    : Color.fromARGB(255, 161, 161, 161),
          ),
        ),
      ],
    ),
  );
}

Widget _buildJobCard(String title, String subtitle, Color cardColor) {
  return Container(
    width: 215,
    margin: const EdgeInsets.only(right: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bookmark_border, size: 18),
          ),
        ),
        const Spacer(), // Adiciona espaço flexível
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12), // Espaço adicional na base
      ],
    ),
  );
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    if (args is int) {
      _selectedIndex = args;
    } else {
      _selectedIndex = widget.initialIndex;
    }

    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 0;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildTabBar() {
    return Material(
      color: Colors.transparent,
      child: TabBar(
        controller: _tabController,
        isScrollable: false,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF81B89A),
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        onTap: (index) {
          if (index == 1) {
            Future.delayed(const Duration(milliseconds: 230), () {
              Get.toNamed('/acompanhamento');
              _tabController.animateTo(0);
            });
          } else if (index == 2) {
            Future.delayed(const Duration(milliseconds: 210), () {
              Get.toNamed('/historicoServico');
              _tabController.animateTo(0);
            });
          }
        },
        tabs: const [
          Tab(text: "Inicial"),
          Tab(text: "Acompanhar"),
          Tab(text: "Status"),
        ],
      ),
    );
  }

  void _onTabChange(int index) {
    if (index == _selectedIndex) return;
    if (index == 3) {
      Get.toNamed('/perfil');
    } else if (index == 2) {
      Get.toNamed('/historico');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;
        final nome = user?.nome ?? 'Usuário';

        return Scaffold(
          drawer: const CustomDrawer(),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.green.shade50.withOpacity(0.7),
                      Colors.white.withOpacity(0.9),
                    ],
                    stops: const [0.2, 0.6],
                  ),
                ),
              ),
              const CustomAppBar(),

              if (_selectedIndex == 0)
                Positioned(
                  top: kToolbarHeight + MediaQuery.of(context).padding.top + 50,
                  left: 0,
                  right: 0,
                  child: buildTabBar(),
                ),

              Padding(
                padding: EdgeInsets.only(
                  top:
                      _selectedIndex == 0
                          ? kToolbarHeight +
                              MediaQuery.of(context).padding.top +
                              130
                          : kToolbarHeight +
                              MediaQuery.of(context).padding.top +
                              20,
                ),
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    // Home
                    SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Mensagem de boas-vindas
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Row(
                              children: [
                                AnimatedEmoji(
                                  AnimatedEmojis.wave,
                                  size: 48,
                                  repeat: true,
                                ),

                                const SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Olá, seja bem-vindo",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      nome,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade900,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          Container(
                            width: double.infinity, // Força largura total
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(60),
                                // Outros cantos permanecem retos
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(
                              20, // Left - alterado de 20 para 30
                              20, // Top
                              5, // Right
                              90, // Bottom
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ), // Já herdará o padding do container pai
                                  child: Text(
                                    "Categorias",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 80, 80, 80),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 17),
                                SizedBox(
                                  height: 110,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      _buildCategoryItem(
                                        "TI",
                                        Icons.computer,
                                        true,
                                      ),
                                      _buildCategoryItem(
                                        "Ciência",
                                        Icons.science,
                                        false,
                                      ),
                                      _buildCategoryItem(
                                        "Cultura",
                                        Icons.camera_alt,
                                        false,
                                      ),
                                      _buildCategoryItem(
                                        "Beleza",
                                        Icons.brush,
                                        false,
                                      ),
                                      _buildCategoryItem(
                                        "Saúde",
                                        Icons.medical_services,
                                        false,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ), // Já herdará o padding do container pai
                                  child: Text(
                                    "Buscas populares",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 80, 80, 80),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 180,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      _buildJobCard(
                                        "UI/UX Designer",
                                        "4 oportunidades",
                                        const Color(0xFFF5F0EB),
                                      ),
                                      _buildJobCard(
                                        "Desenvolvedor iOS",
                                        "13 oportunidades",
                                        const Color(0xFFE3F2FD),
                                      ),
                                      _buildJobCard(
                                        "Desenvolvedor Web",
                                        "7 oportunidades",
                                        const Color(0xFFE8F5E9),
                                      ),
                                      _buildJobCard(
                                        "Analista de Dados",
                                        "5 oportunidades",
                                        const Color(0xFFF3E5F5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Center(child: Text("Buscar")),
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
      },
    );
  }
}
