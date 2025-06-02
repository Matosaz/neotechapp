import 'package:flutter/material.dart';
import 'dart:convert';

class UserAvatar extends StatelessWidget {
  final double radius;
  final String? base64Image;
  final ImageProvider? defaultImage;

  const UserAvatar({
    super.key, 
    this.radius = 30, 
    this.base64Image,
    this.defaultImage,
  });

  @override
  Widget build(BuildContext context) {
    // Use imagem padrão fornecida ou a padrão da rede
    final defaultAvatar = defaultImage ?? 
        NetworkImage("https://i.postimg.cc/0jqKB6mS/Profile-Image.png");

    if (base64Image == null || base64Image!.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: defaultAvatar,
      );
    }

    try {
      return CircleAvatar(
        radius: radius,
        backgroundImage: MemoryImage(base64Decode(base64Image!)),
      );
    } catch (e) {
      debugPrint('Erro ao carregar avatar: $e');
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.person, size: radius),
      );
    }
  }
}