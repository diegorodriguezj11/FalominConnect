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

Future<void> saveStopData(
    String name, LatLng? placePickerValue, int routeNumber) async {
  try {
    print("🚀 Iniciando acción personalizada saveStopData...");

    // Verifica que el nombre no esté vacío
    if (name.isEmpty) {
      print("❌ ERROR: El nombre del stop es obligatorio.");
      return;
    }

    // Verifica que se haya seleccionado una ubicación
    if (placePickerValue == null) {
      print("⚠️ Advertencia: No se seleccionó una ubicación.");
      return;
    }

    // Verifica que el RouteNumber sea válido (mayor que 0)
    if (routeNumber <= 0) {
      print("⚠️ Advertencia: El número de ruta debe ser mayor a 0.");
      return;
    }

    // Extraer latitud y longitud del PlacePicker
    double latitude = placePickerValue.latitude;
    double longitude = placePickerValue.longitude;

    print(
        "📍 Ubicación obtenida: Latitud -> $latitude, Longitud -> $longitude, Ruta -> $routeNumber");

    // Referencia a la colección "routes" en Firestore
    CollectionReference routes =
        FirebaseFirestore.instance.collection('routes');

    // Crear documento con los datos en "routes"
    DocumentReference docRef = await routes.add({
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'RouteNumber': routeNumber, // Ahora guardado en la colección "routes"
      'created_at': FieldValue.serverTimestamp(),
    });

    print("✅ Ruta guardada con éxito en 'routes'. ID: ${docRef.id}");
  } catch (e) {
    print("❌ ERROR al guardar la ruta: $e");
    throw e;
  }
}
