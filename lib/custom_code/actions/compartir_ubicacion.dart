// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; // Necesario para kIsWeb

Future<void> compartirUbicacion(
    BuildContext context, DocumentReference userRef) async {
  try {
    // Solicitar permiso
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("❌ [ERROR] Permiso de ubicación denegado por el usuario.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("⚠️ [ERROR] Permiso de ubicación denegado permanentemente.");

      if (!kIsWeb) {
        await Geolocator.openAppSettings();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Debes permitir la ubicación desde la configuración del navegador.",
            ),
          ),
        );
      }

      return;
    }

    // Obtener ubicación actual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double lat = position.latitude;
    double lng = position.longitude;

    print("📍 [DEBUG] Ubicación actual: $lat, $lng");

    // Actualizar en Firestore
    await userRef.update({
      'current_latitude': lat,
      'current_longitude': lng,
      'last_updated': FieldValue.serverTimestamp(),
    });

    // Mostrar mensaje en pantalla
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ Ubicación compartida exitosamente.")),
    );
  } catch (e) {
    print("❌ [ERROR] Al compartir ubicación: $e");
  }
}
