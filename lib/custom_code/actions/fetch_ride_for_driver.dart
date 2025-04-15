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
import 'package:auto_bus/flutter_flow/lat_lng.dart' as ff;

Future<void> fetchRideForDriver(DocumentReference driverRef) async {
  try {
    print(
        "🚀 [DEBUG] Iniciando fetchRideForDriver para DriverRef: ${driverRef.id}...");

    // 1️⃣ Buscar el routeDriver asignado al driver
    QuerySnapshot routeDriverSnapshot = await FirebaseFirestore.instance
        .collection('routeDriver')
        .where('driver_ref', isEqualTo: driverRef)
        .limit(1)
        .get();

    if (routeDriverSnapshot.docs.isEmpty) {
      print("⚠️ [WARNING] No se encontró un routeDriver asignado.");
      return;
    }

    var routeDriverDoc = routeDriverSnapshot.docs.first;
    DocumentReference rideRef = routeDriverDoc.get('ride_ref');

    DocumentSnapshot rideDoc = await rideRef.get();
    if (!rideDoc.exists) {
      print("⚠️ [WARNING] No se encontró el documento en ride.");
      return;
    }

    DocumentReference routeRef = rideDoc.get('route_ref');
    DocumentReference schoolRef = rideDoc.get('school_ref');

    // 2️⃣ Obtener punto inicial
    ff.LatLng? routeLatLng;
    if (routeRef != null) {
      DocumentSnapshot routeDoc = await routeRef.get();
      if (routeDoc.exists) {
        routeLatLng = ff.LatLng(
          routeDoc.get('latitude'),
          routeDoc.get('longitude'),
        );
        print("✅ [DEBUG] Punto inicial obtenido: $routeLatLng");
      }
    }

    // 3️⃣ Obtener punto final (escuela)
    ff.LatLng? schoolLatLng;
    if (schoolRef != null) {
      DocumentSnapshot schoolDoc = await FirebaseFirestore.instance
          .collection('School')
          .doc(schoolRef.id)
          .get();

      if (schoolDoc.exists) {
        schoolLatLng = ff.LatLng(
          schoolDoc.get('latitude'),
          schoolDoc.get('longitude'),
        );
        print("✅ [DEBUG] Punto final obtenido: $schoolLatLng");
      }
    }

    // 4️⃣ Obtener paradas intermedias
    List<ff.LatLng> stopsLatLng = [];
    if (routeRef != null) {
      QuerySnapshot stopSnapshot = await FirebaseFirestore.instance
          .collection('stops')
          .where('route_ref', isEqualTo: routeRef)
          .get();

      for (var doc in stopSnapshot.docs) {
        stopsLatLng.add(
          ff.LatLng(doc.get('latitude'), doc.get('longitude')),
        );
      }
    }

    print("✅ [DEBUG] Paradas obtenidas: $stopsLatLng");

    // 5️⃣ Construir lista con tipo
    List<Map<String, dynamic>> rideMarkersInfo = [];

    if (routeLatLng != null) {
      rideMarkersInfo.add({
        "latLng": routeLatLng,
        "tipo": "inicio",
      });
    }

    for (var stop in stopsLatLng) {
      rideMarkersInfo.add({
        "latLng": stop,
        "tipo": "stop",
      });
    }

    if (schoolLatLng != null) {
      rideMarkersInfo.add({
        "latLng": schoolLatLng,
        "tipo": "final",
      });
    }

    // 6️⃣ Actualizar el AppState global
    FFAppState().update(() {
      // Lista con tipo para tooltips o texto
      FFAppState().rideMarkersInfo = rideMarkersInfo;

      // Solo las ubicaciones (para GoogleMap)
      FFAppState().rideMarkers =
          rideMarkersInfo.map((e) => e["latLng"] as ff.LatLng).toList();

      // Colores (List<Color>) para cada punto
      FFAppState().markerColors = rideMarkersInfo.map((e) {
        final tipo = e["tipo"];
        if (tipo == "inicio") return Colors.green;
        if (tipo == "final") return Colors.red;
        return Colors.orange;
      }).toList();

      // Centro inicial del mapa
      FFAppState().initialMapCenter = [
        rideMarkersInfo.first["latLng"] as ff.LatLng
      ];

      // Polilínea de ruta
      FFAppState().routePolyline =
          rideMarkersInfo.map((e) => e["latLng"] as ff.LatLng).toList();
    });

    print("✅ [SUCCESS] rideMarkersInfo actualizado con tipos y colores.");
  } catch (e, stackTrace) {
    print("❌ [ERROR] Ocurrió un error en fetchRideForDriver: $e");
    print("🛠️ [DEBUG] StackTrace: $stackTrace");
  }
}
