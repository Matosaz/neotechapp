import 'package:flutter/material.dart';
import 'package:neotechapp/widgets/bottom_navbar.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ElegantCollectionHistory extends StatefulWidget {
  const ElegantCollectionHistory({super.key});

  @override
  State<ElegantCollectionHistory> createState() =>
      _ElegantCollectionHistoryState();
}

class _ElegantCollectionHistoryState extends State<ElegantCollectionHistory> {
  bool showActive = true;

  List<Map<String, dynamic>> activeCollections = [
    {
      'status': 'Agendada',
      'idColeta': '35858292',
      'items': ['3 Notebooks', '5 Monitores', '10 Celulares'],
      'address': 'Av. Paulista, 1000 - São Paulo/SP',
    },
    {
      'status': 'Em andamento',
      'idColeta': '16482937',
      'items': ['5 Monitores', '3 Placas-mãe'],
      'address': 'ITB Brasílio Flores de Azevedo - Barueri/SP',
    },
  ];

  List<Map<String, dynamic>> completedCollections = [
    {
      'status': 'Concluída',
      'idColeta': '75310984',
      'items': ['5 CPUs', '3 Impressoras', '20 Cabos'],
      'address': 'Alameda Santos, 200 - São Paulo/SP',
      'points': 250,
    },
    {
      'status': 'Concluída',
      'idColeta': '98124567',
      'items': ['10 Celulares', '5 Tablets'],
      'address': 'Rua Augusta, 1500 - São Paulo/SP',
      'points': 120,
    },
  ];

  void _confirmDelivery(Map<String, dynamic> coleta) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            title: Column(
              children: [
                Icon(Icons.check_circle, color: Color(0xFFAAD4AC), size: 48),
                const SizedBox(height: 12),
                const Text(
                  'Entrega Confirmada!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            content: const Text(
              'Obrigado por contribuir com a sustentabilidade. Seus pontos foram adicionados!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Color(0xFF757575),
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    // Espera um tempo antes de mover o item de ativo para concluído
                    Future.delayed(const Duration(milliseconds: 500), () {
                      setState(() {
                        activeCollections.remove(coleta);
                        completedCollections.add({
                          ...coleta,
                          'status': 'Concluída',
                          'points': 150, // ou defina outro valor
                        });
                      });
                    });
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Fechar',
                  style: TextStyle(
                    color: Color(0xFF81B89A),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildEmptyState({required IconData icon, required String message}) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/NoServices.svg',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF757575),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'agendada':
        return const Color(0xFF81B89A); // Verde suave
      case 'em andamento':
        return Colors.orange.shade600; // Laranja forte
      case 'concluída':
        return Colors.green.shade800; // Cinza escuro
      default:
        return Colors.black87; // Padrão
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'agendada':
        return Icons.calendar_today_outlined;
      case 'em andamento':
        return Icons.local_shipping_outlined;
      case 'concluída':
        return Icons.check_circle_outline;

      default:
        return Icons.info_outline; // Ícone genérico para outros casos
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 255),

      appBar: AppBar(
        title: const Text(
          'Status',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          // Segmentação elegante
          Container(
            padding: const EdgeInsets.only(top: 4, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(31, 109, 109, 109),
                  blurRadius: 8,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                GestureDetector(
                  onTap: () => setState(() => showActive = true),
                  child: _buildStatusTab('Ativas', showActive),
                ),
                GestureDetector(
                  onTap: () => setState(() => showActive = false),
                  child: _buildStatusTab('Concluídas', !showActive),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),

              children: [
                if (showActive) ...[
                  _buildSectionHeader('Status das coletas'),
                  if (activeCollections.isEmpty)
                    _buildEmptyState(
                      icon: Icons.hourglass_empty,
                      message: 'Ops, não há nenhuma coleta ativa no momento.',
                    )
                  else
                    for (var coleta in activeCollections)
                      _buildCollectionCard(
                        status: coleta['status'],
                        idColeta: coleta['idColeta'],
                        items: coleta['items'],
                        address: coleta['address'],
                        isActive: true,
                        onConfirm: () => _confirmDelivery(coleta),
                      ),
                ] else ...[
                  _buildSectionHeader('Histórico de coletas'),
                  for (var coleta in completedCollections)
                    _buildCollectionCard(
                      status: coleta['status'],
                      idColeta: coleta['idColeta'],
                      items: coleta['items'],
                      address: coleta['address'],
                      isActive: false,
                      points: coleta['points'],
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        onTabChange: (index) {
          if (index !=0){
            Get.offNamed("/home");
          }
          if (index == 2) {
            Get.offNamed('/historico', arguments: index);
          }
          if (index == 3) {
            Get.toNamed('/perfil');
          }
        },
      ),
    );
  }

  Widget _buildStatusTab(String title, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? Color(0xFF81B89A) : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isActive ? Color(0xFF81B89A) : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 2),

      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontFamily: 'Poppins',

          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildCollectionCard({
    required String status,
    required String idColeta,
    required List<String> items,
    required String address,
    required bool isActive,
    int? points,
    VoidCallback? onConfirm,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final fadeAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation);
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation);

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(position: offsetAnimation, child: child),
        );
      },

      child: Card(
        key: ValueKey(idColeta),
        elevation: 1.5,
        margin: const EdgeInsets.only(bottom: 16),
        color: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.black.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getStatusIcon(status),
                        color: _getStatusColor(status),
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(status),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "ID: #$idColeta",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      address,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 90, 90, 90),
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                'Itens para coleta:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 100, 100, 100),
                ),
              ),
              const SizedBox(height: 5),
              ...items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    '• $item',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              if (points != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.eco_outlined,
                      color: Colors.green.shade400,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$points pontos sustentáveis',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(
                          255,
                          115,
                          163,
                          136,
                        ).withOpacity(1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              if (isActive)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => {Get.toNamed('/acompanhamento')},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Color(0xFF81B89A),
                          side: const BorderSide(
                            color: Color(0xFF81B89A),
                            width: 2,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Detalhes"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onConfirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF81B89A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Confirmar Entrega"),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
