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

Future<String> sendPasswordResetEmail(String email) async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Enviar correo de restablecimiento de contraseña
    await auth.sendPasswordResetEmail(email: email);

    return "Correo de restablecimiento enviado a $email.";
  } catch (e) {
    return "Error: $e";
  }
}
