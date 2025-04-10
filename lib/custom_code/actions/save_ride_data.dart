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

Future<void> saveRideData(
    String userId, // Se ingresa manualmente
    String selectedRouteName,
    String selectedStopName,
    String selectedSchoolId // Ahora es el ID en lugar del nombre
    ) async {
  try {
    print("🚀 [DEBUG] Iniciando saveRideData...");

    if (userId.isEmpty ||
        selectedRouteName.isEmpty ||
        selectedStopName.isEmpty ||
        selectedSchoolId.isEmpty) {
      print("❌ [ERROR] Faltan datos obligatorios. No se puede guardar.");
      return;
    }

    print("🔍 [DEBUG] Buscando IDs en Firestore...");

    // Crear referencia a la colección `users` con el ID del usuario
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    print("✅ [DEBUG] Usuario referenciado como: ${userRef.path}");

    // Buscar el documento en `routes` basado en el nombre seleccionado
    QuerySnapshot routeSnapshot = await FirebaseFirestore.instance
        .collection('routes')
        .where('name', isEqualTo: selectedRouteName)
        .limit(1)
        .get();
    if (routeSnapshot.docs.isEmpty) {
      print("❌ [ERROR] No se encontró la ruta con nombre: $selectedRouteName");
      return;
    }
    DocumentReference routeRef = routeSnapshot.docs.first.reference;
    String routeNumber = routeSnapshot.docs.first
        .get('RouteNumber')
        .toString(); // Obtener RouteNumber
    print(
        "✅ [DEBUG] Ruta encontrada: ${routeRef.path} con RouteNumber: $routeNumber");

    // Buscar el ID del documento en `stops` basado en el nombre seleccionado
    QuerySnapshot stopSnapshot = await FirebaseFirestore.instance
        .collection('stops')
        .where('name', isEqualTo: selectedStopName)
        .limit(1)
        .get();
    if (stopSnapshot.docs.isEmpty) {
      print("❌ [ERROR] No se encontró la parada con nombre: $selectedStopName");
      return;
    }
    DocumentReference stopRef = stopSnapshot.docs.first.reference;
    print("✅ [DEBUG] Parada encontrada: ${stopRef.path}");

    // Obtener la referencia del `school` directamente por su ID
    DocumentReference schoolRef =
        FirebaseFirestore.instance.collection('school').doc(selectedSchoolId);
    print("✅ [DEBUG] Escuela encontrada: ${schoolRef.path}");

    // Guardar los datos en la colección `ride`
    DocumentReference rideRef =
        await FirebaseFirestore.instance.collection('ride').add({
      'user_ref':
          userRef, // 🔥 Ahora el usuario se guarda como referencia users/id
      'route_ref': routeRef,
      'stop_ref': stopRef,
      'school_ref': schoolRef,
      'RouteName': routeNumber, // 🔥 Guardar el RouteNumber en el campo name
      'created_at': FieldValue.serverTimestamp(),
    });

    print("✅ [SUCCESS] Ride guardado con éxito. ID: ${rideRef.id}");
  } catch (e, stackTrace) {
    print("❌ [ERROR] Ocurrió un error en saveRideData: $e");
    print("🛠️ [DEBUG] StackTrace: $stackTrace");
  }
}
