import 'package:flutter/material.dart';
import 'home.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  bool isLogin = true;
  bool obscureText = true;

  // Controladores separados para login e cadastro
  final TextEditingController emailControllerLogin = TextEditingController();
  final TextEditingController passwordControllerLogin = TextEditingController();
  
  final TextEditingController nameControllerCadastro = TextEditingController();
  final TextEditingController emailControllerCadastro = TextEditingController();
  final TextEditingController passwordControllerCadastro = TextEditingController();

  // Função para alternar entre login e cadastro
  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void navigateToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
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
            top: -50,
            left: -50,
            child: CustomPaint(
              size: Size(300, 300),
              painter: TopLeftCirclePainter(),
            ),
          ),

          // Curvas no canto inferior direito
          Positioned(
            bottom: -50,
            right: -50,
            child: CustomPaint(
              size: Size(200, 190),
              painter: BottomRightCirclePainter(),
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
                    // Ícone
                    Image.asset(
                      "assets/images/neotechlogo.png", // Substitua pelo caminho correto
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),

                    // Título
                    Text(
                      isLogin ? "Que bom que você retornou!" : "Crie sua conta",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const SizedBox(height: 30),

                    // Campos de entrada
                    if (!isLogin)
                      _buildTextField(Icons.person, "Nome completo", TextStyle(color: Colors.grey[500]), false, nameControllerCadastro),
                    _buildTextField(Icons.email, "Email", TextStyle(color: Colors.grey[500]), false, isLogin ? emailControllerLogin : emailControllerCadastro),
                    _buildTextField(Icons.lock, "Senha", TextStyle(color: Colors.grey[500]), obscureText, isLogin ? passwordControllerLogin : passwordControllerCadastro),

                    const SizedBox(height: 20),

                    // Botão principal
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        backgroundColor: const Color.fromRGBO(95, 170, 132, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (isLogin) {
                          // Validar login
                          if (emailControllerLogin.text.isEmpty || !isValidEmail(emailControllerLogin.text)) {
                            showErrorDialog("Por favor, insira um e-mail válido.");
                          } else if (passwordControllerLogin.text.isEmpty || passwordControllerLogin.text.length < 6) {
                            showErrorDialog("A senha deve ter no mínimo 6 caracteres.");
                          } else {
                            // Lógica de login
                            print("Login realizado");
                          }
                        } else {
                          // Validar cadastro
                          if (nameControllerCadastro.text.isEmpty) {
                            showErrorDialog("Por favor, insira seu nome.");
                          } else if (emailControllerCadastro.text.isEmpty || !isValidEmail(emailControllerCadastro.text)) {
                            showErrorDialog("Por favor, insira um e-mail válido.");
                          } else if (passwordControllerCadastro.text.isEmpty || passwordControllerCadastro.text.length < 6) {
                            showErrorDialog("A senha deve ter no mínimo 6 caracteres.");
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
                              text: isLogin
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
      builder: (context) => AlertDialog(
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
  Widget _buildTextField(IconData icon, String hint, TextStyle? hintStyle, bool obscure, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color.fromARGB(255, 161, 161, 161)),
          hintText: hint,
          hintStyle: hintStyle ?? TextStyle(color: Colors.grey),  // Usa a cor cinza por padrão, caso não passe `hintStyle`
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon: icon == Icons.lock
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
}

// Desenhando um círculo no canto superior esquerdo
class TopLeftCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromARGB(255, 200, 231, 202)
      ..style = PaintingStyle.fill;

    // Desenhando o círculo
    canvas.drawCircle(Offset(80, 95), 130, paint);  // Círculo com raio de 100
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Desenhando um círculo no canto inferior direito
class BottomRightCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromARGB(255, 190, 231, 193)
      ..style = PaintingStyle.fill;

    // Desenhando o círculo
    canvas.drawCircle(Offset(140, 100), 100, paint);  // Círculo com raio de 100
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}