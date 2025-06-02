import 'package:flutter/material.dart';
import 'package:neotechapp/routes/RouteManager.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neotechapp/userProvider/UserModel.dart';
import 'package:neotechapp/userProvider/UserProvider.dart';
import 'package:provider/provider.dart'; // Importar provider

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  bool isLogin = true;
  bool obscureText = true;
  final String apiBaseUrl =
      "https://intellij-neotech.onrender.com/api/v1/users";
  final TextEditingController emailControllerLogin = TextEditingController();
  final TextEditingController passwordControllerLogin = TextEditingController();
  final TextEditingController nameControllerCadastro = TextEditingController();
  final TextEditingController emailControllerCadastro = TextEditingController();
  final TextEditingController passwordControllerCadastro =
      TextEditingController();

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void navigateToHome() {
    Get.offNamed(RouteManager.home);
  }

  bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool isLoading = false;

  Future<void> login() async {
    setState(() => isLoading = true);
    final email = emailControllerLogin.text.trim();
    final senha = passwordControllerLogin.text;

    try {
      // 1. Primeiro fazemos o login básico
      final loginResponse = await http.post(
        Uri.parse("$apiBaseUrl/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': senha}),
      );

      debugPrint('Resposta do login: ${loginResponse.body}');

      if (loginResponse.statusCode == 200) {
        final loginData = jsonDecode(loginResponse.body);
        final userId = loginData['id'];

        // 2. Agora buscamos os dados completos do usuário
        final userResponse = await http.get(
          Uri.parse("$apiBaseUrl/$userId"),
          headers: {'Content-Type': 'application/json'},
        );

        debugPrint('Resposta dos dados do usuário: ${userResponse.body}');

        if (userResponse.statusCode == 200) {
          final userData = jsonDecode(userResponse.body);
          final user = User.fromJson(userData);
          final userProvider = Provider.of<UserProvider>(
            context,
            listen: false,
          );
          await userProvider.setUser(user);

          navigateToHome();
        } else {
          final errorMsg =
              jsonDecode(userResponse.body)['mensagem'] ??
              'Erro ao obter dados do usuário';
          showErrorDialog(errorMsg);
        }
      } else {
        final errorMsg =
            jsonDecode(loginResponse.body)['mensagem'] ?? 'Erro ao fazer login';
        showErrorDialog(errorMsg);
      }
    } catch (e) {
      showErrorDialog('Erro: ${e.toString()}');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> cadastrar() async {
    setState(() => isLoading = true);

    final nome = nameControllerCadastro.text.trim();
    final email = emailControllerCadastro.text.trim();
    final senha = passwordControllerCadastro.text;

    try {
      final response = await http.post(
        Uri.parse(apiBaseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nome': nome, 'email': email, 'senha': senha}),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data); // Supondo que a API retorna o usuário
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.setUser(user); // Salva o usuário
        navigateToHome();
      } else {
        final erro =
            jsonDecode(response.body)['mensagem'] ?? 'Erro ao cadastrar.';
        showErrorDialog(erro);
      }
    } catch (e) {
      showErrorDialog('Erro de conexão. Verifique sua internet.');
    } finally {
      setState(() => isLoading = false);
    }
  }

  bool isPasswordValid(String password) {
    final hasLower = RegExp(r'[a-z]').hasMatch(password);
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasDigit = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecial = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);
    final validLength = password.length >= 8 && password.length <= 70;

    return hasLower && hasUpper && hasDigit && hasSpecial && validLength;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: const Size(300, 150),
              painter: TopLeftWavePainter(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomPaint(
              size: const Size(300, 200),
              painter: BottomRightWavePainter(),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, 20),
                      child: Image.asset(
                        "assets/images/logoneotech.png",
                        width: 200,
                      ),
                    ),
                    Text(
                      isLogin ? "Que bom que você retornou!" : "Crie sua conta",
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(188, 27, 27, 27),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
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

                    if (!isLogin)
                      PasswordCriteriaWidget(
                        password: passwordControllerCadastro.text,
                      ),

                    const SizedBox(height: 20),
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
                            login();
                          }
                        } else {
                          if (nameControllerCadastro.text.isEmpty) {
                            showErrorDialog("Por favor, insira seu nome.");
                          } else if (emailControllerCadastro.text.isEmpty ||
                              !isValidEmail(emailControllerCadastro.text)) {
                            showErrorDialog(
                              "Por favor, insira um e-mail válido.",
                            );
                          } else if (passwordControllerCadastro.text.isEmpty) {
                            showErrorDialog("Por favor, insira uma senha.");
                          } else if (!isPasswordValid(
                            passwordControllerCadastro.text,
                          )) {
                            showErrorDialog(
                              "A senha não atende a todos os critérios.",
                            );
                          } else {
                            cadastrar();
                          }
                        }
                      },
                      child: Text(
                        isLogin ? "Entrar" : "Cadastrar",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: toggleForm,
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 131, 131, 131),
                            fontWeight: FontWeight.w600,
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
                                color: Color.fromARGB(255, 68, 132, 151),
                                fontWeight: FontWeight.w700,
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
        style: TextStyle(fontSize: 16),
        controller: controller,
        obscureText: obscure,
        onChanged: (_) {
          setState(() {}); // Atualiza o PasswordCriteriaWidget dinamicamente
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(204, 112, 112, 112),
            size: 22,
          ),
          hintText: hint,
          hintStyle: hintStyle ?? TextStyle(color: Colors.grey),
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
}

class TopLeftWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color.fromARGB(255, 164, 206, 167)
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.9);
    path.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.7,
      size.width * 0.3,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.8,
      size.width * 0.7,
      size.height * 0.3,
    );
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
    final paint =
        Paint()
          ..color = const Color.fromARGB(255, 164, 206, 167)
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.85,
      size.width * 0.5,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.65,
      0,
      size.height,
    );
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Widget de validação de senha
class PasswordCriteriaWidget extends StatelessWidget {
  final String password;

  const PasswordCriteriaWidget({super.key, required this.password});

  Widget _buildCriteria(bool condition, String text) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.cancel,
          color: condition ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: condition ? Colors.green[800] : Colors.red[800],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasLower = RegExp(r'[a-z]').hasMatch(password);
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasDigit = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecial = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);
    final validLength = password.length >= 8 && password.length <= 70;

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(26, 179, 178, 178),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCriteria(validLength, 'De 8 à 70 caracteres'),
          _buildCriteria(hasLower, 'Letra minúscula'),
          _buildCriteria(hasUpper, 'Letra maiúscula'),
          _buildCriteria(hasDigit, 'Número'),
          _buildCriteria(hasSpecial, 'Símbolo (Ex: !@#%)'),
        ],
      ),
    );
  }
}
