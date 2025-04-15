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
import 'package:intl/intl.dart';
import 'package:auto_bus/flutter_flow/lat_lng.dart' as ff;

Future<void> startTrip(BuildContext context, String driverId) async {
  try {
    print("🚀 [DEBUG] Iniciando viaje para Driver: $driverId...");

    // 1️⃣ Verificar permisos de ubicación
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
      await Geolocator.openAppSettings();
      return;
    }

    // 2️⃣ Obtener ubicación actual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    ff.LatLng driverCurrentLocation =
        ff.LatLng(position.latitude, position.longitude);
    print("📍 [DEBUG] Ubicación actual del conductor: $driverCurrentLocation");

    // 3️⃣ Obtener rideMarkers
    List<ff.LatLng> rideMarkers = FFAppState().rideMarkers;
    if (rideMarkers.isEmpty) {
      print("⚠️ [WARNING] No hay marcadores en rideMarkers.");
      return;
    }

    // 4️⃣ Definir puntos de ruta
    ff.LatLng routeLatLng = rideMarkers.first;
    ff.LatLng schoolLatLng = rideMarkers.last;
    List<ff.LatLng> stopsLatLng =
        rideMarkers.sublist(1, rideMarkers.length - 1);

    print(
        "✅ [DEBUG] Inicio: $routeLatLng, Destino: $schoolLatLng, Stops: $stopsLatLng");

    // 5️⃣ Crear línea amarilla
    List<ff.LatLng> polylinePoints = [];
    polylinePoints.add(driverCurrentLocation);
    polylinePoints.add(routeLatLng);
    polylinePoints.addAll(stopsLatLng);
    polylinePoints.add(schoolLatLng);

    FFAppState().update(() {
      FFAppState().routePolyline = polylinePoints;
      FFAppState().routeColor = [Color(0xFFE7AD09)];
    });
    print("✅ [DEBUG] Línea de ruta amarilla creada: $polylinePoints");

    // 6️⃣ Simular movimiento en tiempo real
    DocumentReference driverRef =
        FirebaseFirestore.instance.collection('users').doc(driverId);

    for (var location in polylinePoints) {
      await driverRef.update({
        'current_latitude': location.latitude,
        'current_longitude': location.longitude,
      });
      print(
          "📌 [DEBUG] Conductor en: ${location.latitude}, ${location.longitude}");
      await Future.delayed(Duration(seconds: 3));
    }

    // 7️⃣ Al finalizar el viaje: guardar en Trips, borrar en RouteDriver y actualizar usuario
    print("📦 [DEBUG] Iniciando registro del viaje...");

    final userDoc = await driverRef.get();
    final driverData = userDoc.data() as Map<String, dynamic>?;

    if (driverData == null) {
      print("❌ [ERROR] No se encontró el usuario driver.");
      return;
    }

    final driverName = driverData['display_name'] ?? 'Conductor';

    // 🔢 Obtener número de ruta como entero
    final routeNumber = driverData['RouteNumberDriver'] != null
        ? int.tryParse(driverData['RouteNumberDriver'].toString()) ?? 0
        : 0;

    // 🏫 Obtener ubicación de la escuela
    String schoolLocation = 'Escuela no definida';
    if (driverData['school'] != null && driverData['school'] != '') {
      final schoolId = driverData['school'];
      final schoolDoc = await FirebaseFirestore.instance
          .collection('School')
          .doc(schoolId)
          .get();

      if (schoolDoc.exists) {
        final schoolData = schoolDoc.data();
        if (schoolData != null && schoolData.containsKey('Location')) {
          schoolLocation = schoolData['Location'] ?? 'Sin ubicación';
        }
      }
    }

    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    await FirebaseFirestore.instance.collection('Trips').add({
      'title': today,
      'NumberRoute': routeNumber,
      'Driver': driverName,
      'School': schoolLocation,
      'iduser': driverRef,
      'timestamp': FieldValue.serverTimestamp(),
    });
    print("✅ [SUCCESS] Viaje guardado en Trips.");

    // Eliminar documento de RouteDriver
    await FirebaseFirestore.instance
        .collection('RouteDriver')
        .doc(driverId)
        .delete();
    print("🗑️ [SUCCESS] Documento de RouteDriver eliminado.");

    // Actualizar el campo route del driver
    await driverRef.update({'route': false});
    print("🔄 [SUCCESS] Campo 'route' actualizado a false para el driver.");

    print("🎉 [COMPLETADO] Proceso de viaje finalizado correctamente.");
  } catch (e, stackTrace) {
    print("❌ [ERROR] Ocurrió un error en startTrip: $e");
    print("🛠️ [DEBUG] StackTrace: $stackTrace");
  }
}
