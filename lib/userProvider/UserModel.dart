class User {
  final int id;
  final String nome;
  final String email;
  final bool isAdmin;
  final String? message;
  final String? telefone;
  final String? avatar; // Campo para a imagem em Base64

  User({
    required this.id,
    required this.nome,
    required this.email,
    this.isAdmin = false,
    this.message,
    this.telefone,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
        nome: json['nome']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        telefone: json['telefone']?.toString(), // Pode ser nulo
        isAdmin: json['isAdmin']?.toString().toLowerCase() == 'true',
        message: json['message']?.toString(),
        avatar: json['avatar']?.toString(),
      );
    } catch (e) {
      print('Erro ao converter User: $e');
      print('Dados recebidos: $json');
      throw FormatException('Formato de usuário inválido');
    }
  }

  User copyWith({
    int? id,
    String? nome,
    String? email,
    bool? isAdmin,
    String? message,
    String? telefone,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
      message: message ?? this.message,
      telefone: telefone ?? this.telefone,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'email': email,
    'isAdmin': isAdmin,
    if (message != null) 'message': message,
    if (telefone != null) 'telefone': telefone,
    'avatar': avatar,
  };
}
