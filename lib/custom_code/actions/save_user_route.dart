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

Future<void> saveUserRoute(
    DocumentReference pickupStopRef, DocumentReference dropoffStopRef) async {
  try {
    print("🔍 Iniciando guardado de ruta...");

    // Verificar si el usuario está autenticado
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("❌ ERROR: No hay un usuario autenticado.");
      throw Exception('No hay un usuario autenticado.');
    }

    print("✅ Usuario autenticado: ${user.uid}");

    // Verificar si las referencias son válidas
    if (pickupStopRef == null || dropoffStopRef == null) {
      print("❌ ERROR: Una de las referencias es nula.");
      throw Exception('La referencia de recogida o destino es nula.');
    }

    print("📍 Punto de recogida: ${pickupStopRef.path}");
    print("📍 Punto de destino: ${dropoffStopRef.path}");

    // Obtener la referencia del documento del usuario en Firestore
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    // Verificar si el documento del usuario existe
    final userSnapshot = await userDoc.get();
    if (!userSnapshot.exists) {
      print("⚠️ ADVERTENCIA: El documento del usuario no existe en Firestore.");
      throw Exception('El documento del usuario no existe.');
    }

    print("📝 Actualizando Firestore...");

    // Actualizar Firestore con la selección del usuario
    await userDoc.update({
      'pickup_stop': pickupStopRef,
      'dropoff_stop': dropoffStopRef,
    });

    print("✅ ¡Ruta guardada exitosamente en Firestore!");
  } catch (error) {
    print("❌ ERROR: $error");
    throw Exception("Ocurrió un error al guardar la ruta: $error");
  }
}
