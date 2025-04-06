import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Stack(
        children: [
          // Pintura do fundo ondulado
          CustomPaint(
           size: const Size(double.infinity, 170), // Altura fixa, igual ao preferredSize.height
           painter: AppBarBackgroundPainter(),
          ),
          // Conteúdo da AppBar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu_outlined, color: Color.fromARGB(255, 255, 255, 255), size: 32,),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  const Text(
                    "NeoTech",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  const SizedBox(width: 48), // espaço para centralizar o título
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(170);
}

class AppBarBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF81B89A).withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..lineTo(0, size.height * 0.6)
      ..quadraticBezierTo(
  size.width * 0.25, size.height * 0.75,
  size.width * 0.5, size.height * 0.6,
)
..quadraticBezierTo(
  size.width * 0.75, size.height * 0.45,
  size.width, size.height * 0.6,
)

      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
