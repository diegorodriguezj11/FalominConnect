// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_bus/flutter_flow/lat_lng.dart' as ff;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

Future<void> startTrip(BuildContext context, String driverId) async {
  try {
    print("🚀 [DEBUG] Iniciando viaje para Driver: $driverId...");

    // 📌 1️⃣ Verificar permisos de ubicación
    bool hasPermission = await requestLocationPermission(context);
    if (!hasPermission) {
      print("❌ [ERROR] No se pudo obtener permiso de ubicación.");
      return;
    }

    // 📌 2️⃣ Obtener la ubicación actual del conductor
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    ff.LatLng driverCurrentLocation =
        ff.LatLng(position.latitude, position.longitude);
    print("📍 [DEBUG] Ubicación actual del conductor: $driverCurrentLocation");

    // 📌 3️⃣ Obtener los marcadores de rideMarkers desde FFAppState
    List<ff.LatLng> rideMarkers = FFAppState().rideMarkers;

    if (rideMarkers.isEmpty) {
      print("⚠️ [WARNING] No hay marcadores en rideMarkers.");
      return;
    }

    // 📌 4️⃣ Definir puntos de la ruta
    ff.LatLng routeLatLng = rideMarkers.first; // Inicio (verde)
    ff.LatLng schoolLatLng = rideMarkers.last; // Destino (rojo)
    List<ff.LatLng> stopsLatLng =
        rideMarkers.sublist(1, rideMarkers.length - 1); // Paradas (naranja)

    print(
        "✅ [DEBUG] Inicio: $routeLatLng, Destino: $schoolLatLng, Stops: $stopsLatLng");

    // 📌 5️⃣ Crear la línea amarilla de la ruta
    List<ff.LatLng> polylinePoints = [];
    polylinePoints.add(
        driverCurrentLocation); // Inicia en la ubicación actual del conductor
    polylinePoints.add(routeLatLng); // Luego va al punto inicial de la ruta
    polylinePoints
        .addAll(stopsLatLng); // Pasa por todas las paradas intermedias
    polylinePoints.add(schoolLatLng); // Termina en el destino final

    FFAppState().update(() {
      FFAppState().routePolyline = polylinePoints;
      FFAppState().routeColor = "yellow"; // Línea amarilla
    });

    print("✅ [DEBUG] Línea de ruta amarilla creada: $polylinePoints");

    // 📌 6️⃣ Simular el movimiento del conductor en tiempo real
    DocumentReference driverRef =
        FirebaseFirestore.instance.collection('users').doc(driverId);

    for (var location in polylinePoints) {
      await driverRef.update({
        'current_latitude': location.latitude,
        'current_longitude': location.longitude,
      });
      print(
          "📌 [DEBUG] Conductor en: ${location.latitude}, ${location.longitude}");
      await Future.delayed(
          Duration(seconds: 3)); // Simula movimiento en tiempo real
    }

    print("✅ [SUCCESS] Viaje completado.");
  } catch (e, stackTrace) {
    print("❌ [ERROR] Ocurrió un error en startTrip: $e");
    print("🛠️ [DEBUG] StackTrace: $stackTrace");
  }
}
