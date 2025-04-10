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

Future<void> saveStopWithRouteId(
    String selectedRouteId, String stopName, LatLng? stopLocation) async {
  try {
    print("🚀 Iniciando acción personalizada saveStopWithRouteId...");

    // Verifica que el ID de la ruta no esté vacío
    if (selectedRouteId.isEmpty) {
      print("❌ ERROR: No se seleccionó un ID de ruta válido.");
      return;
    }

    // Verifica que el nombre de la parada no esté vacío
    if (stopName.isEmpty) {
      print("❌ ERROR: El nombre de la parada es obligatorio.");
      return;
    }

    // Verifica que se haya seleccionado una ubicación
    if (stopLocation == null) {
      print("⚠️ Advertencia: No se seleccionó una ubicación.");
      return;
    }

    // Crear la referencia del documento en la colección "routes"
    DocumentReference selectedRouteRef =
        FirebaseFirestore.instance.collection('routes').doc(selectedRouteId);

    print("🔗 [DEBUG] Referencia a la ruta: ${selectedRouteRef.path}");

    // Verificar si la ruta realmente existe en Firestore
    DocumentSnapshot routeDoc = await selectedRouteRef.get();

    if (!routeDoc.exists) {
      print("❌ ERROR: No se encontró una ruta con el ID: $selectedRouteId");
      return;
    }

    print("✅ [DEBUG] Ruta encontrada con ID: $selectedRouteId");

    // Extraer latitud y longitud del PlacePickerStops
    double latitude = stopLocation.latitude;
    double longitude = stopLocation.longitude;

    print(
        "📍 [DEBUG] Ubicación obtenida: Latitud -> $latitude, Longitud -> $longitude");

    // Referencia a la colección "stops" en Firestore
    CollectionReference stops = FirebaseFirestore.instance.collection('stops');

    // Guardar la parada con referencia a la ruta en Firestore
    DocumentReference docRef = await stops.add({
      'name': stopName, // Nombre de la parada
      'latitude': latitude,
      'longitude': longitude,
      'route_ref': selectedRouteRef, // Referencia directa al documento "routes"
      'created_at': FieldValue.serverTimestamp(),
    });

    print("✅ Parada guardada con éxito en 'stops'. ID: ${docRef.id}");
  } catch (e, stackTrace) {
    print("❌ [ERROR] Ocurrió un error en saveStopWithRouteId: $e");
    print("🛠️ [DEBUG] StackTrace: $stackTrace");
    throw e;
  }
}
