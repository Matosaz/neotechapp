import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:neotechapp/widgets/bottom_navbar.dart';
import 'package:get/get.dart';

class RecyclingProgressScreen extends StatefulWidget {
  const RecyclingProgressScreen({super.key});

  @override
  State<RecyclingProgressScreen> createState() =>
      _RecyclingProgressScreenState();
}

class _RecyclingProgressScreenState extends State<RecyclingProgressScreen> {
  late List<Map<String, dynamic>> categories;
  final Set<int> selectedCategories = {};

  final Map<DateTime, List<Map<String, dynamic>>> categoryDataByDate = {};
  int selectedDayIndex = 1;
  DateTime selectedDate = DateTime.now();
  final int initialDay = 5; // Dia inicialmente definido como 5

  @override
  void initState() {
    super.initState();

    selectedDayIndex = initialDay - 1; // Ajuste para índice baseado em 0
    DateTime now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, initialDay);

    categoryDataByDate[selectedDate] = getDefaultCategories(selectedDate);
    categories = List.from(categoryDataByDate[selectedDate]!);
  }

  List<Map<String, dynamic>> getDefaultCategories(DateTime date) {
    // Se a data for depois do dia inicialmente definido (dia 5), retorna valores nulos
    if (date.day > initialDay) {
      return [
        {
          'icon': Icons.phone_android,
          'label': 'Dispositivos pequenos',
          'value': 0,
        },
        {'icon': Icons.tv, 'label': 'Monitores / TVs', 'value': 0},
        {'icon': Icons.battery_6_bar_sharp, 'label': 'Baterias', 'value': 0},
        {'icon': Icons.memory, 'label': 'Componentes', 'value': 0},
      ];
    } else {
      int valueMultiplier = date.day % 12;

      return [
        {
          'icon': Icons.phone_android,
          'label': 'Dispositivos pequenos',
          'value': 2 * valueMultiplier,
        },
        {
          'icon': Icons.tv,
          'label': 'Monitores / TVs',
          'value': 1 * valueMultiplier,
        },
        {
          'icon': Icons.battery_6_bar_sharp,
          'label': 'Baterias',
          'value': 4 * valueMultiplier,
        },
        {
          'icon': Icons.memory,
          'label': 'Componentes',
          'value': 3 * valueMultiplier,
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 250, 250),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed('/home', arguments: 0);
          },
        ),
        title: const Text(
          'Histórico',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildWeekSelector(),
            const SizedBox(height: 20),
            _buildProgressCard(),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Itens reciclados:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: List.generate(categories.length, (index) {
                  final cat = categories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedCategories.contains(index)) {
                          selectedCategories.remove(index);
                        } else {
                          selectedCategories.add(index);
                        }
                      });
                    },
                    child: _buildCategoryCard(
                      icon: cat['icon'],
                      label: cat['label'],
                      value: cat['value'],
                      isSelected: selectedCategories.contains(index),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
        onTabChange: (index) {
          if (index != 2) {
            Get.offNamed('/home', arguments: index);
          }
          if (index == 3) {
            Get.toNamed('/perfil');
          }
        },
      ),
    );
  }
Widget _buildWeekSelector() {
  DateTime now = DateTime.now();
  int totalDays = DateTime(now.year, now.month + 1, 0).day;

  return Container(
    height: 80, // Increased height to accommodate bottom padding
    padding: const EdgeInsets.only(bottom: 0), // Adds space at the bottom
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: totalDays,
      itemBuilder: (context, index) {
        DateTime date = DateTime(now.year, now.month, index + 1);
        bool isSelected = selectedDayIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDayIndex = index;
              selectedDate = DateTime(now.year, now.month, index + 1);

              if (!categoryDataByDate.containsKey(selectedDate)) {
                categoryDataByDate[selectedDate] = getDefaultCategories(
                  selectedDate,
                );
              }

              categories = List.from(categoryDataByDate[selectedDate]!);
              selectedCategories.clear();
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: 60,
              margin: const EdgeInsets.only(bottom: 4), // Additional margin for shadow
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(12),
               
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(82, 145, 145, 145),
                    blurRadius: 4, // Increased blur for better visibility
                    offset: const Offset(1, 2), // Slightly larger offset
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${date.day}',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      _getWeekdayName(date.weekday),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

  String _getWeekdayName(int weekday) {
    const names = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
    return names[weekday % 7];
  }

  Widget _buildProgressCard() {
    double percentage = 0.7;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade100,
            const Color.fromARGB(255, 178, 224, 179),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 45.0,
            lineWidth: 8.0,
            percent: percentage,
            center: Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
                fontSize: 20,
              ),
            ),
            progressColor: Colors.green,
            backgroundColor: Colors.green.shade200,
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            animationDuration: 1000,
            curve: Curves.easeInOut,
            animateFromLastPercent: true,
            restartAnimation: true,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              "Você reciclou 70% da sua meta semanal! Parabéns!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.green.shade900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String label,
    required int value,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),

        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(133, 180, 180, 180),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: const Color.fromARGB(255, 118, 187, 120)),
          const SizedBox(height: 12),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 97, 97, 97),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 104, 104, 104),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
