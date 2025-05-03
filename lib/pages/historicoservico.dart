import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ElegantCollectionHistory extends StatefulWidget {
  const ElegantCollectionHistory({super.key});

  @override
  State<ElegantCollectionHistory> createState() =>
      _ElegantCollectionHistoryState();
}

class _ElegantCollectionHistoryState extends State<ElegantCollectionHistory> {
  bool showActive = true;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'agendada':
        return const Color(0xFF81B89A); // Verde suave
      case 'em andamento':
        return Colors.orange.shade600; // Laranja forte
      case 'concluída':
        return  Colors.green.shade800; // Cinza escuro
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
                  _buildCollectionCard(
                    status: 'Agendada',
                    date: DateTime.now().add(const Duration(days: 2)),
                    items: ['3 Notebooks', '5 Monitores', '10 Celulares'],
                    address: 'Av. Paulista, 1000 - São Paulo/SP',
                    isActive: true,
                  ),
                  _buildCollectionCard(
                    status: 'Em andamento',
                    date: DateTime.now().add(const Duration(days: 5)),
                    items: ['2 Geladeiras', '1 Máquina de Lavar'],
                    address: 'Rua Oscar Freire, 500 - São Paulo/SP',
                    isActive: true,
                  ),
                ] else ...[
                  _buildSectionHeader('Histórico de coletas'),
                  _buildCollectionCard(
                    status: 'Concluída',
                    date: DateTime.now().subtract(const Duration(days: 15)),
                    items: ['5 CPUs', '3 Impressoras', '20 Cabos'],
                    address: 'Alameda Santos, 200 - São Paulo/SP',
                    isActive: false,
                    points: 250,
                  ),
                  _buildCollectionCard(
                    status: 'Concluída',
                    date: DateTime.now().subtract(const Duration(days: 30)),
                    items: ['10 Celulares', '5 Tablets'],
                    address: 'Rua Augusta, 1500 - São Paulo/SP',
                    isActive: false,
                    points: 120,
                  ),
                ],
              ],
            ),
          ),
        ],
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
    required DateTime date,
    required List<String> items,
    required String address,
    required bool isActive,
    int? points,
  }) {
    final dateFormat = DateFormat('dd MMM yyyy • HH:mm');
    final isConfirmed = status == 'Confirmada';

    return Card(
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
      dateFormat.format(date),
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
                    style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 115, 163, 136).withOpacity(1), fontWeight: FontWeight.w500),
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
                      onPressed: () {},
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
                      onPressed: () => _showConfirmationDialog(context),
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
    );
  }
}

void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (_) => AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),

          ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

          title: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: const Color.fromARGB(255, 170, 212, 172),
                size: 48,
              ),
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
            style: TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w600, color:  Color(0xFF757575)),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
                          const SizedBox(height: 12),

            TextButton(
              onPressed: () => Navigator.pop(context),
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
