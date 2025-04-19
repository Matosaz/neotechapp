import 'package:flutter/material.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  bool showMore = false;

  final List<_StepData> steps = [
    _StepData(
      "Agendamento recebido",
      "08/10/2025 às 17:45",
      Icons.bookmark_added_rounded,
      true,
    ),
    _StepData(
      "Endereço confirmado",
      "ITB Brasílio Flores de Azevedo - Barueri/SP",
      Icons.location_on,
      true,
    ),
    _StepData(
      "Data e horário de coleta",
      "10/10/2025 às 15:35",
      Icons.schedule,
      true,
    ),
    _StepData(
      "Profissional a caminho",
      "Chegará em 15 minutos",
      Icons.directions_bike,
      false,
    ),
    _StepData("Status da coleta", "Em andamento", Icons.verified, false),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      appBar: AppBar(
        title: const Text(
          'Acompanhamento',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Simulated Map
            Container(
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior:
                  Clip.antiAlias, // garante que a imagem seja recortada com bordas arredondadas
              child: Image.asset(
                'assets/images/routetemplate.png',
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 10),

            // Service Card
            Card(
              elevation: 2,
              color: const Color.fromARGB(216, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                leading: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 128, 128, 128),
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Quem realizará a coleta:",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 104, 104, 104),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Fernando Alves",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Coletor experiente",
                      style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
                    ),
                  ],
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.phone), onPressed: () {}),
                    IconButton(
                      icon: const Icon(Icons.message),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Timeline Section
            // Timeline Section
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Etapas do Serviço:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "ID da coleta: #35858292",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Vertical Timeline
            Column(
              children: List.generate(steps.length, (index) {
                final step = steps[index];
                final isLast = index == steps.length - 1;
                return _buildTimelineStep(step, isLast);
              }),
            ),
            const SizedBox(height: 20),

            // Show more details
            GestureDetector(
              onTap: () => setState(() => showMore = !showMore),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    showMore ? "Ocultar Detalhes" : "Ver Mais",
                    style: const TextStyle(
                      color: Color(0xFF81B89A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    showMore ? Icons.expand_less : Icons.expand_more,
                    color: Color(0xFF81B89A),
                  ),
                ],
              ),
            ),
            if (showMore) _personalInfoSection(),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFF81B89A),
                  side: const BorderSide(color: Color(0xFF81B89A), width: 2),
                ),
                child: const Text("Ver no mapa"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF81B89A),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Confirmar Entrega"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep(_StepData step, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon + Line
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: step.done ? Color(0xFF81B89A) : Colors.grey[400],
                shape: BoxShape.circle,
              ),
              child: Icon(step.icon, color: Colors.white, size: 20),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: Color(0xFF81B89A).withOpacity(0.5),
              ),
          ],
        ),
        const SizedBox(width: 12),

        // Text
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  step.subtitle,
                  style: TextStyle(
                    
                    color:
                        step.done
                            ? Colors.grey[800]
                            : Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _personalInfoSection() {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                "https://i.postimg.cc/0jqKB6mS/Profile-Image.png",
              ),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Dados do solicitante:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color.fromARGB(255, 90, 90, 90),
                    ),
                  ),
                  SizedBox(height: 1),

                  Text(
                    "João Alves",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.message), onPressed: () {}),
            IconButton(icon: const Icon(Icons.phone), onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

class _StepData {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool done;

  _StepData(this.title, this.subtitle, this.icon, this.done);
}
