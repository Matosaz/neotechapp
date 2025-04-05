import 'package:flutter/material.dart';
import 'package:neotechapp/routes/RouteManager.dart'; // Caminho ajustado
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  bool isLogin = true;
  bool obscureText = true;

  // Controladores separados para LoginPage e cadastro
  final TextEditingController emailControllerLogin = TextEditingController();
  final TextEditingController passwordControllerLogin = TextEditingController();

  final TextEditingController nameControllerCadastro = TextEditingController();
  final TextEditingController emailControllerCadastro = TextEditingController();
  final TextEditingController passwordControllerCadastro =
      TextEditingController();

  // Função para alternar entre LoginPage e cadastro
  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void navigateToHome() {
    Get.offNamed(RouteManager.home);
  }

  // Função de validação de email
  bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          // Curvas no canto superior esquerdo
          Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: const Size(300, 150),
              painter: TopLeftWavePainter(),
            ),
          ),
          // Curvas no canto inferior direito
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomPaint(
              size: const Size(300, 200),
              painter: BottomRightWavePainter(),
            ),
          ),

          // Conteúdo principal
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, 20), // ou qualquer valor que te agrade
                      child: Image.asset(
                        "assets/images/logoneotech.png",
                        width: 200,
                      ),
                    ),
                    // Título
                    Text(
                      isLogin ? "Que bom que você retornou!" : "Crie sua conta",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const SizedBox(height: 20),

                    // Campos de entrada
                    if (!isLogin)
                      _buildTextField(
                        Icons.person,
                        "Nome completo",
                        TextStyle(color: Colors.grey[500]),
                        false,
                        nameControllerCadastro,
                      ),
                    _buildTextField(
                      Icons.email,
                      "Email",
                      TextStyle(color: Colors.grey[500]),
                      false,
                      isLogin ? emailControllerLogin : emailControllerCadastro,
                    ),
                    _buildTextField(
                      Icons.lock,
                      "Senha",
                      TextStyle(color: Colors.grey[500]),
                      obscureText,
                      isLogin
                          ? passwordControllerLogin
                          : passwordControllerCadastro,
                    ),

                    const SizedBox(height: 20),

                    // Botão principal
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 12,
                        ),
                        backgroundColor: const Color.fromRGBO(95, 170, 132, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (isLogin) {
                          // Validar LoginPage
                          if (emailControllerLogin.text.isEmpty ||
                              !isValidEmail(emailControllerLogin.text)) {
                            showErrorDialog(
                              "Por favor, insira um e-mail válido.",
                            );
                          } else if (passwordControllerLogin.text.isEmpty ||
                              passwordControllerLogin.text.length < 6) {
                            showErrorDialog(
                              "A senha deve ter no mínimo 6 caracteres.",
                            );
                          } else {
                            // Lógica de LoginPage
                            print("Login realizado");
                          }
                        } else {
                          // Validar cadastro
                          if (nameControllerCadastro.text.isEmpty) {
                            showErrorDialog("Por favor, insira seu nome.");
                          } else if (emailControllerCadastro.text.isEmpty ||
                              !isValidEmail(emailControllerCadastro.text)) {
                            showErrorDialog(
                              "Por favor, insira um e-mail válido.",
                            );
                          } else if (passwordControllerCadastro.text.isEmpty ||
                              passwordControllerCadastro.text.length < 6) {
                            showErrorDialog(
                              "A senha deve ter no mínimo 6 caracteres.",
                            );
                          } else {
                            // Lógica de cadastro
                            print("Cadastro realizado");
                            navigateToHome(); // Chama a navegação para Home após o cadastro
                          }
                        }
                      },
                      child: Text(
                        isLogin ? "Entrar" : "Cadastrar",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Alternar entre Login e Cadastro
                    TextButton(
                      onPressed: toggleForm,
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 96, 108, 128),
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  isLogin
                                      ? "Ainda não tem uma conta? "
                                      : "Já tem uma conta? ",
                            ),
                            TextSpan(
                              text: isLogin ? "Cadastre-se" : "Faça login",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 52, 142, 216),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para mostrar um erro de validação
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Erro de validação"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  // Método para o campo de texto com ícones
  Widget _buildTextField(
    IconData icon,
    String hint,
    TextStyle? hintStyle,
    bool obscure,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 161, 161, 161),
          ),
          hintText: hint,
          hintStyle:
              hintStyle ??
              TextStyle(
                color: Colors.grey,
              ), // Usa a cor cinza por padrão, caso não passe `hintStyle`
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon:
              icon == Icons.lock
                  ? IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromARGB(255, 161, 161, 161),
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                  : null,
        ),
      ),
    );
  }
}class TopLeftWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 190, 231, 193)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.9);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.7, size.width * 0.3, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.8, size.width * 0.7, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.1, size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
class BottomRightWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 190, 231, 193)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.85, size.width * 0.5, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.65, 0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
