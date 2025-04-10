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
import '/flutter_flow/flutter_flow_util.dart'; // Import necesario para actualizar variables en FlutterFlow

Future<void> fetchStopsByRouteName(String selectedRouteName) async {
  try {
    print("🚀 [DEBUG] Iniciando fetchStopsByRouteName...");
    print("🔍 [DEBUG] Nombre de la ruta seleccionada: $selectedRouteName");

    if (selectedRouteName.isEmpty) {
      print("❌ [ERROR] No se seleccionó una ruta válida.");
      FFAppState().filteredStops = []; // Asegurar que la UI se refresque
      return;
    }

    print(
        "🛠️ [DEBUG] Buscando rutas en Firestore con el nombre seleccionado...");

    // Buscar en Firestore el documento de `routes` basado en su `name`
    QuerySnapshot routeSnapshot = await FirebaseFirestore.instance
        .collection('routes')
        .where('name', isEqualTo: selectedRouteName)
        .limit(1)
        .get();

    print(
        "📦 [DEBUG] Documentos encontrados en 'routes': ${routeSnapshot.docs.length}");

    if (routeSnapshot.docs.isEmpty) {
      print(
          "❌ [ERROR] No se encontró ninguna ruta con el nombre: $selectedRouteName.");
      FFAppState().filteredStops = [];
      return;
    }

    // Obtener la referencia correcta de la ruta
    DocumentReference selectedRouteRef = routeSnapshot.docs.first.reference;

    print("🔗 [DEBUG] Ruta encontrada: ${selectedRouteRef.path}");
    print(
        "🛠️ [DEBUG] Consultando la colección 'stops' para obtener paradas asociadas...");

    // Buscar en `stops` todas las paradas que tengan `route_ref` apuntando a la referencia encontrada
    QuerySnapshot stopsSnapshot = await FirebaseFirestore.instance
        .collection('stops')
        .where('route_ref', isEqualTo: selectedRouteRef)
        .get();

    print(
        "📦 [DEBUG] Datos obtenidos de 'stops': ${stopsSnapshot.docs.length} documentos encontrados.");

    if (stopsSnapshot.docs.isEmpty) {
      print(
          "⚠️ [WARNING] No se encontraron paradas para la ruta con nombre: $selectedRouteName.");
      FFAppState().filteredStops = [];
      return;
    }

    // Extraer los nombres de las paradas
    List<String> stopsList = stopsSnapshot.docs.map((doc) {
      String stopName = doc['name'].toString();
      print("🔹 [DEBUG] Parada encontrada: $stopName");
      return stopName;
    }).toList();

    print("✅ [SUCCESS] Paradas obtenidas correctamente: $stopsList");

    // 🔄 Limpiar la variable antes de actualizarla
    FFAppState().filteredStops = []; // Forzar actualización de la UI
    await Future.delayed(Duration(
        milliseconds:
            50)); // Esperar un poco para que FlutterFlow detecte el cambio

    // 🔄 Asignar la nueva lista de paradas
    FFAppState().filteredStops = stopsList;
  } catch (e, stackTrace) {
    print("❌ [ERROR] Ocurrió un error en fetchStopsByRouteName: $e");
    print("🛠️ [DEBUG] StackTrace: $stackTrace");
    FFAppState().filteredStops = []; // Para evitar que queden datos obsoletos
  }
}
