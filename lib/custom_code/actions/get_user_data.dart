// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getUserData() async {
  try {
    // Obtener el usuario autenticado
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return "No hay usuario autenticado";
    }

    // Referencia a la colección 'users' en Firestore
    final DocumentSnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

    if (!userData.exists) {
      return "No se encontraron datos para este usuario";
    }

    // Obtener los datos como una cadena
    String name = userData.data()?['display_name'] ?? "Nombre no disponible";
    String email = userData.data()?['email'] ?? "Correo no disponible";
    String uid = userData.data()?['uid'] ?? "UID no disponible";

    // Devolver una cadena con los datos del usuario
    return "Name: $name, Email: $email, UID: $uid";
  } catch (e) {
    return "Error obteniendo datos del usuario: $e";
  }
}
