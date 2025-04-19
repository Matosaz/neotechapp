import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'Editar perfil',
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      "https://i.postimg.cc/0jqKB6mS/Profile-Image.png",
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      radius: 16,
                      child: Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: const Color(0xFF81B89A),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),

              // Adicionando texto abaixo da foto de perfil
              Text(
                'João Alves',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 87, 87, 87),
                ),
              ),
              SizedBox(height: 30),

              _buildTextField(
                label: 'Nome',
                hint: 'Seu nome',
                controller: _nameController,
              ),
              _buildTextField(
                label: 'Email',
                hint: 'usuario@gmail.com',
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Campo obrigatório';
                  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                  if (!emailRegex.hasMatch(value)) return 'Email inválido';
                  return null;
                },
              ),
              _buildTextField(
                label: 'Senha',
                hint: 'Insira sua senha',
                controller: _passwordController,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xFF81B89A),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              _buildTextField(
                label: 'Telefone',
                hint: '(99) 99999-9999',
                controller: _phoneController,
                inputFormatters: [_phoneMaskFormatter],
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 5),

              // Botões de salvar e cancelar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Ação ao cancelar (voltar à tela anterior)
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Color(0xFF81B89A),
                      side: const BorderSide(
                        color: Color(0xFF81B89A),
                        width: 2,
                      ),
                    ),
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Ação ao salvar
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Salvar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF81B89A),
                      foregroundColor: Colors.white, // Cor do texto
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 2, // Sombra do botão
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

  Widget _buildTextField({
    required String label,
    required String hint,
    bool obscureText = false,
    Widget? suffixIcon,
    TextEditingController? controller,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Color.fromARGB(255, 87, 87, 87),
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              color: const Color.fromARGB(255, 12, 12, 12),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontFamily: 'Poppins',
              ),
              filled: true,
              fillColor: const Color.fromARGB(101, 230, 230, 230),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),
              errorStyle: TextStyle(
                fontSize: 12,
                height: 0, // evita empurrar os campos
                color: Colors.red,
                fontFamily: 'Poppins',
              ),
            ),
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            validator:
                validator ??
                (value) {
                  if (value == null || value.isEmpty)
                    return 'Campo obrigatório';
                  return null;
                },
          ),
        ],
      ),
    );
  }
}
