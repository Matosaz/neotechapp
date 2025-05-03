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

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late TabController _tabController;
@override
void initState() {
  super.initState();

  // Captura o argumento passado com segurança
  final args = Get.arguments;
  if (args is int) {
    _selectedIndex = args;
  } else {
    _selectedIndex = widget.initialIndex;
  }

  _tabController = TabController(length: 3, vsync: this);

  // Sempre forçar a aba "Serviço" como selecionada
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
      isScrollable: false, // <- solução mais direta
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: const Color(0xFF81B89A),
      indicatorSize: TabBarIndicatorSize.label,
labelPadding: const EdgeInsets.symmetric(horizontal: 10.0), // Aumenta o espaçamento lateral de cada item

      labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
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
        Tab(text: "Serviço"),
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
    } 
     else if (index == 2) {
      Get.toNamed('/historico');
    }

    
    else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
  
  @override
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
top: kToolbarHeight + MediaQuery.of(context).padding.top + 50,
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