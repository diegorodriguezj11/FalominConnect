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
import 'package:intl/intl.dart'; // Para formatear la fecha

Future<void> assignDriverToRoute(
    String driverId, // ID del conductor seleccionado
    String rideId, // ID de la ruta seleccionada
    String schoolId, // ID de la escuela seleccionada
    DateTime assignedDate // Fecha seleccionada en el calendario
    ) async {
  try {
    print("🚀 [DEBUG] Iniciando assignDriverToRoute...");

    if (driverId.isEmpty ||
        rideId.isEmpty ||
        schoolId.isEmpty ||
        assignedDate == null) {
      print("❌ [ERROR] Faltan datos obligatorios. No se puede asignar.");
      return;
    }

    print("🔍 [DEBUG] Creando referencias en Firestore...");

    // Crear referencia al conductor en `users`
    DocumentReference driverRef =
        FirebaseFirestore.instance.collection('users').doc(driverId);
    print("✅ [DEBUG] Conductor referenciado: ${driverRef.path}");

    // Crear referencia a la ruta en `ride`
    DocumentReference rideRef =
        FirebaseFirestore.instance.collection('ride').doc(rideId);
    print("✅ [DEBUG] Ruta referenciada: ${rideRef.path}");

    // Crear referencia a la escuela en `school`
    DocumentReference schoolRef =
        FirebaseFirestore.instance.collection('school').doc(schoolId);
    print("✅ [DEBUG] Escuela referenciada: ${schoolRef.path}");

    // Formatear la fecha como `YYYY-MM-DD` sin la hora
    String formattedDate = DateFormat('yyyy-MM-dd').format(assignedDate);
    print("✅ [DEBUG] Fecha asignada (sin hora): $formattedDate");

    // Guardar la asignación en `routeDriver`
    DocumentReference routeDriverRef =
        await FirebaseFirestore.instance.collection('routeDriver').add({
      'driver_ref': driverRef,
      'ride_ref': rideRef,
      'school_ref': schoolRef,
      'assigned_date': formattedDate,
      'created_at': FieldValue.serverTimestamp(),
    });

    print(
        "✅ [SUCCESS] Asignación guardada con éxito. ID: ${routeDriverRef.id}");
  } catch (e, stackTrace) {
    print("❌ [ERROR] Ocurrió un error en assignDriverToRoute: $e");
    print("🛠️ [DEBUG] StackTrace: $stackTrace");
  }
}
