import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UserModel.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = true;

  User? get user => _user;
  bool get isLoading => _isLoading;

  UserProvider();

  Future<void> init() async {
    await _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      final userName = prefs.getString('userName');
      final userEmail = prefs.getString('userEmail');
      final userTelefone = prefs.getString('userTelefone');
      final isAdmin = prefs.getBool('userIsAdmin') ?? false;

      debugPrint('Dados carregados do SharedPreferences:');
      debugPrint('ID: $userId');
      debugPrint('Nome: $userName');
      debugPrint('Email: $userEmail');
      debugPrint('Telefone: $userTelefone');
      debugPrint('Admin: $isAdmin');

      if (userId != null && userName != null && userEmail != null) {
        _user = User(
          id: userId,
          nome: userName,
          email: userEmail,
          telefone: userTelefone, // Agora carregando o telefone
          isAdmin: isAdmin,
        );
      }
    } catch (e) {
      debugPrint('Erro ao carregar usuário: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setUser(User? user) async {
    _user = user;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      if (user != null) {
        await prefs.setInt('userId', user.id);
        if (user.avatar != null)
          await prefs.setString('userAvatar', user.avatar!);
        await prefs.setString('userName', user.nome);
        await prefs.setString('userEmail', user.email);
        await prefs.setBool('userIsAdmin', user.isAdmin);

        // Salva telefone (pode ser nulo)
        if (user.telefone != null) {
          await prefs.setString('userTelefone', user.telefone!);
        } else {
          await prefs.remove('userTelefone'); // Limpa se for nulo
        }
      } else {
        // Limpa todos os dados ao fazer logout
        await prefs.remove('userId');
        await prefs.remove('userName');
        await prefs.remove('userEmail');
        await prefs.remove('userTelefone');
        await prefs.remove('userIsAdmin');
      }
    } catch (e) {
      debugPrint('Erro ao salvar usuário: $e');
    }
  }
}
