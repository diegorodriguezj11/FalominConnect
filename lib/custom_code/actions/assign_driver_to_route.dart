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
import 'package:intl/intl.dart';

Future<void> assignDriverToRoute(String driverId, String rideId,
    String schoolId, DateTime assignedDate) async {
  try {
    print("🚀 [DEBUG] Iniciando assignDriverToRoute...");

    // Validación
    if (driverId.isEmpty ||
        rideId.isEmpty ||
        schoolId.isEmpty ||
        assignedDate == null) {
      print("❌ [ERROR] Faltan datos obligatorios.");
      return;
    }

    // Obtener el documento de ride
    final rideSnapshot =
        await FirebaseFirestore.instance.collection('ride').doc(rideId).get();

    if (!rideSnapshot.exists) {
      print("❌ [ERROR] No se encontró el documento ride con ID: $rideId");
      return;
    }

    final rideData = rideSnapshot.data() as Map<String, dynamic>?;

    if (rideData == null || !rideData.containsKey('route_ref')) {
      print("❌ [ERROR] El campo 'route_ref' no está presente en ride.");
      return;
    }

    final DocumentReference routeRef = rideData['route_ref'];

    // Obtener el documento de ruta referenciado
    final routeSnapshot = await routeRef.get();

    if (!routeSnapshot.exists) {
      print("❌ [ERROR] No se encontró la ruta referenciada: ${routeRef.path}");
      return;
    }

    final routeData = routeSnapshot.data() as Map<String, dynamic>?;

    if (routeData == null || !routeData.containsKey('RouteNumber')) {
      print("❌ [ERROR] El campo 'RouteNumber' no está presente en la ruta.");
      return;
    }

    final int routeNumber = routeData['RouteNumber'];
    print("✅ [DEBUG] RouteNumber obtenido: $routeNumber");

    // Crear referencias
    final driverRef =
        FirebaseFirestore.instance.collection('users').doc(driverId);
    final schoolRef =
        FirebaseFirestore.instance.collection('school').doc(schoolId);
    final formattedDate = DateFormat('yyyy-MM-dd').format(assignedDate);

    // Guardar en routeDriver
    final routeDriverRef =
        await FirebaseFirestore.instance.collection('routeDriver').add({
      'driver_ref': driverRef,
      'ride_ref': rideSnapshot.reference,
      'school_ref': schoolRef,
      'route_ref': routeRef,
      'assigned_date': formattedDate,
      'created_at': FieldValue.serverTimestamp(),
    });

    print("✅ [SUCCESS] Asignación guardada. ID: ${routeDriverRef.id}");

    // Actualizar el usuario
    await driverRef.update({
      'route': true,
      'RouteNumberDriver': routeNumber,
      'route_ref': routeRef,
    });

    print(
        "✅ [SUCCESS] Usuario actualizado con RouteNumberDriver = $routeNumber");
  } catch (e, stackTrace) {
    print("❌ [ERROR] Ocurrió un error en assignDriverToRoute: $e");
    print("🛠️ [DEBUG] StackTrace: $stackTrace");
  }
}
