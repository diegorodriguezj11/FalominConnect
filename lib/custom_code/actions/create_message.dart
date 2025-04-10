// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> createMessage(
  String receiverId,
  String message,
) async {
  String mensaje = "Message sent successfully";

  try {
    // Obtener el usuario actualmente autenticado
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return "User not authenticated";
    }

    // Obtener el ID del usuario autenticado (senderId)
    final String senderId = user.uid;

    // Generar el chatId automáticamente
    final String chatId = generateChatId(senderId, receiverId);

    // Referencia a la colección 'messages'
    final CollectionReference<Map<String, dynamic>> messages =
        FirebaseFirestore.instance.collection('messages');

    // Crear un nuevo documento en la colección 'messages'
    await messages.add({
      'senderId': senderId, // ID del usuario autenticado
      'receiverId': receiverId, // ID del usuario que recibe el mensaje
      'message': message, // Contenido del mensaje
      'timestamp': DateTime.now(), // Fecha y hora actuales
      'chatId':
          chatId, // ID único de la conversación (generado automáticamente)
    });

    return mensaje;
  } on FirebaseException catch (e) {
    return "Firebase Error: ${e.message}";
  } catch (e) {
    return "Error: $e";
  }
}

// Función para generar el chatId
String generateChatId(String senderId, String receiverId) {
  // Ordenar los IDs alfabéticamente para evitar duplicados
  if (senderId.compareTo(receiverId) < 0) {
    return "${senderId}_${receiverId}";
  } else {
    return "${receiverId}_${senderId}";
  }
}
