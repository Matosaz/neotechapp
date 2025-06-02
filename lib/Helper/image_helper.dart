import 'package:flutter/material.dart';
import 'dart:convert';

class ImageHelper {
  /// Converte uma string Base64 em Widget de Image
  static Widget imageFromBase64(String base64String, {BoxFit fit = BoxFit.cover}) {
    try {
      return Image.memory(
        base64Decode(base64String),
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
      );
    } catch (e) {
      debugPrint('Erro ao decodificar imagem: $e');
      return _buildDefaultAvatar();
    }
  }

  /// Cria um CircleAvatar a partir de Base64
  static Widget circleAvatarFromBase64(String? base64String, {double radius = 30}) {
    if (base64String == null || base64String.isEmpty) {
      return _buildDefaultAvatar(radius: radius);
    }

    try {
      return CircleAvatar(
        radius: radius,
        backgroundImage: MemoryImage(base64Decode(base64String)),
      );
    } catch (e) {
      debugPrint('Erro ao criar CircleAvatar: $e');
      return _buildDefaultAvatar(radius: radius);
    }
  }

  /// Widget de fallback padrão
  static Widget _buildDefaultAvatar({double radius = 30}) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[300],
      child: Icon(Icons.person, size: radius),
    );
  }
}