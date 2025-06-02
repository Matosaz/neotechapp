import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../userProvider/UserProvider.dart';
import 'package:neotechapp/widgets/user_avatar.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoadingImage = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  String? _newAvatarBase64;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    
    if (user != null) {
      _nameController.text = user.nome;
      _emailController.text = user.email;
      _phoneController.text = user.telefone ?? '';
    }
  }

  Future<void> _pickImage() async {
    setState(() => _isLoadingImage = true);
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _newAvatarBase64 = base64Encode(bytes);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao selecionar imagem: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoadingImage = false);
    }
  }

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
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;
        final nome = user?.nome ?? 'Usuário';
        final currentAvatar = _newAvatarBase64 ?? user?.avatar;

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
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        _isLoadingImage
                            ? CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey[200],
                                child: CircularProgressIndicator(),
                              )
                            : UserAvatar(
                                base64Image: currentAvatar,
                                radius: 60,
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFF81B89A),
                            radius: 16,
                            child: Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    nome,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
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
                            _saveProfile(context);
                          }
                        },
                        child: Text('Salvar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF81B89A),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveProfile(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    final updatedUser = userProvider.user?.copyWith(
      nome: _nameController.text,
      email: _emailController.text,
      telefone: _phoneController.text.isEmpty ? null : _phoneController.text,
      avatar: _newAvatarBase64 ?? userProvider.user?.avatar,
    );

    if (updatedUser != null) {
      await userProvider.setUser(updatedUser);
      Navigator.pop(context);
    }
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
                fontSize: 16,
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
                height: 0,
                color: Colors.red,
                fontFamily: 'Poppins',
              ),
            ),
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            validator: validator ?? (value) {
              if (value == null || value.isEmpty) return 'Campo obrigatório';
              return null;
            },
          ),
        ],
      ),
    );
  }
}