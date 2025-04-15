// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> actualizarColoresDeMarcadores() async {
  try {
    print("🎨 [DEBUG] Iniciando actualización de colores de marcadores...");

    // Verificamos que haya marcadores
    if (FFAppState().rideMarkersInfo.isEmpty) {
      print("⚠️ [WARNING] rideMarkersInfo está vacío.");
      return;
    }

    // Mapear los tipos a colores reales
    final colores = FFAppState().rideMarkersInfo.map((marker) {
      final tipo = marker["tipo"];

      if (tipo == "inicio") return Colors.green;
      if (tipo == "final") return Colors.red;
      return Colors.orange; // stops
    }).toList();

    // Asignar al AppState
    FFAppState().update(() {
      FFAppState().markerColors = colores;
    });

    print("✅ [SUCCESS] markerColors actualizado con: $colores");
  } catch (e, stackTrace) {
    print("❌ [ERROR] Ocurrió un error en actualizarColoresDeMarcadores: $e");
    print("🛠️ [DEBUG] StackTrace: $stackTrace");
  }
}
