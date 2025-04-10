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

Future<void> saveSchoolData(String schoolName, String location, String photo,
    String type, LatLng? placePickerValue // Permite nulos para evitar fallos
    ) async {
  try {
    print("🚀 Iniciando acción personalizada `saveSchoolData`...");

    // Verifica que los datos obligatorios no estén vacíos
    if (schoolName.isEmpty || location.isEmpty || type.isEmpty) {
      print("❌ ERROR: Campos obligatorios vacíos.");
      return;
    }

    // Verifica que se haya seleccionado una ubicación
    if (placePickerValue == null) {
      print("⚠️ Advertencia: No se seleccionó una ubicación.");
      return;
    }

    // Extraer latitud y longitud del PlacePicker
    double latitude = placePickerValue.latitude;
    double longitude = placePickerValue.longitude;

    print(
        "📍 Ubicación obtenida: Latitud -> $latitude, Longitud -> $longitude");

    // Referencia a la colección "School" en Firestore
    CollectionReference schools =
        FirebaseFirestore.instance.collection('School');

    // Crear documento con los datos
    DocumentReference docRef = await schools.add({
      'SchoolName': schoolName,
      'Location': location,
      'Photo': photo,
      'Type': type,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': FieldValue.serverTimestamp(),
    });

    print("✅ Escuela guardada con éxito. ID: ${docRef.id}");
  } catch (e) {
    print("❌ ERROR al guardar la escuela: $e");
    throw e;
  }
}
