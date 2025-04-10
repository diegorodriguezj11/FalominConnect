// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Importar Firestore y FlutterFlow
import 'package:cloud_firestore/cloud_firestore.dart';

// Función para actualizar la ruta en el mapa
Future<void> updateRoute(
    String startingStopId, String destinationSchoolId) async {
  try {
    print("🚀 Iniciando acción personalizada 'updateRoute'...");

    // Verificar que ambos IDs sean válidos
    if (startingStopId.isEmpty || destinationSchoolId.isEmpty) {
      print(
          "⚠️ Advertencia: Se debe seleccionar un punto de inicio y un destino.");
      return;
    }

    // Buscar datos en Firestore
    print(
        "🔍 Buscando datos en la colección 'stops' para el punto de inicio...");

    // Obtener punto de inicio desde la colección `stops`
    DocumentSnapshot startDoc = await FirebaseFirestore.instance
        .collection('stops')
        .doc(startingStopId)
        .get();

    if (!startDoc.exists) {
      print("⚠️ Advertencia: No se encontró el punto de inicio.");
      return;
    }

    print("🔍 Buscando datos en la colección 'School' para el destino...");

    // Obtener punto de destino desde la colección `School`
    DocumentSnapshot destinationDoc = await FirebaseFirestore.instance
        .collection('School')
        .doc(destinationSchoolId)
        .get();

    if (!destinationDoc.exists) {
      print("⚠️ Advertencia: No se encontró el destino.");
      return;
    }

    // Extraer coordenadas de inicio y destino
    var startData = startDoc.data() as Map<String, dynamic>;
    var destinationData = destinationDoc.data() as Map<String, dynamic>;

    double startLat = startData['latitude'] ?? 0.0;
    double startLng = startData['longitude'] ?? 0.0;
    double destLat = destinationData['latitude'] ?? 0.0;
    double destLng = destinationData['longitude'] ?? 0.0;

    print("📍 Inicio: Lat: $startLat, Lng: $startLng");
    print("🏫 Destino: Lat: $destLat, Lng: $destLng");

    // Actualizar el estado global para el mapa
    FFAppState().update(() {
      FFAppState().startingLocation = LatLng(startLat, startLng);
      FFAppState().destinationLocation = LatLng(destLat, destLng);
    });

    print("✅ Ruta actualizada correctamente en el mapa.");
  } catch (e) {
    print("❌ ERROR al actualizar la ruta: $e");
    throw e;
  }
}
