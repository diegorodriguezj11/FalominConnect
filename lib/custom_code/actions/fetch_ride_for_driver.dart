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
import 'package:auto_bus/flutter_flow/lat_lng.dart'
    as ff; // Alias para evitar conflictos
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<List<ff.LatLng>> fetchRideForDriver(String driverId) async {
  try {
    print("🚀 [DEBUG] Iniciando fetchRideForDriver para Driver: $driverId...");

    // 📌 1️⃣ Buscar el routeDriver asignado al driver
    QuerySnapshot routeDriverSnapshot = await FirebaseFirestore.instance
        .collection('routeDriver')
        .where('driver_ref',
            isEqualTo:
                FirebaseFirestore.instance.collection('users').doc(driverId))
        .limit(1)
        .get();

    if (routeDriverSnapshot.docs.isEmpty) {
      print("⚠️ [WARNING] No se encontró un routeDriver asignado.");
      return [];
    }

    var routeDriverDoc = routeDriverSnapshot.docs.first;
    DocumentReference rideRef = routeDriverDoc.get('ride_ref');

    print("✅ [DEBUG] routeDriver encontrado.");

    // 📌 2️⃣ Obtener datos del ride
    DocumentSnapshot rideDoc = await rideRef.get();
    if (!rideDoc.exists) {
      print("⚠️ [WARNING] No se encontró el documento en ride.");
      return [];
    }

    DocumentReference routeRef = rideDoc.get('route_ref');
    DocumentReference schoolRef = rideDoc.get('school_ref');

    print("✅ [DEBUG] Ride encontrado con referencias:");
    print("   - RouteRef: $routeRef");
    print("   - SchoolRef: $schoolRef");

    // 📌 3️⃣ Obtener ubicación del route_ref (Inicio - Verde)
    ff.LatLng? routeLatLng;
    if (routeRef != null) {
      DocumentSnapshot routeDoc = await routeRef.get();
      if (routeDoc.exists) {
        routeLatLng =
            ff.LatLng(routeDoc.get('latitude'), routeDoc.get('longitude'));
        print("✅ [DEBUG] Punto inicial obtenido: $routeLatLng");
      }
    }

    // 📌 4️⃣ Obtener ubicación del School (Destino - Rojo)
    ff.LatLng? schoolLatLng;
    if (schoolRef != null) {
      DocumentSnapshot schoolDoc = await FirebaseFirestore.instance
          .collection('School')
          .doc(schoolRef.id)
          .get();

      if (schoolDoc.exists) {
        schoolLatLng =
            ff.LatLng(schoolDoc.get('latitude'), schoolDoc.get('longitude'));
        print("✅ [DEBUG] Punto final obtenido: $schoolLatLng");
      }
    }

    // 📌 5️⃣ Obtener todas las stops asociadas a la misma route_ref
    List<ff.LatLng> stopsLatLng = [];
    if (routeRef != null) {
      QuerySnapshot stopSnapshot = await FirebaseFirestore.instance
          .collection('stops')
          .where('route_ref', isEqualTo: routeRef) // 🔥 Filtrar por route_ref
          .get();

      for (var doc in stopSnapshot.docs) {
        stopsLatLng.add(ff.LatLng(doc.get('latitude'), doc.get('longitude')));
      }
    }
    print("✅ [DEBUG] Paradas obtenidas: $stopsLatLng");

    // **Crear la lista de puntos para el mapa**
    List<Map<String, dynamic>> rideMarkers = [];

// 📌 **PRIMERO: Ubicación de la parada de inicio**
    if (routeLatLng != null && FFAppState().GoImagen != null) {
      rideMarkers.add(
          {'latLng': routeLatLng, 'icon': FFAppState().GoImagen.toString()});
    }

// 📌 **SEGUNDO: Agregar todas las paradas**
    for (var stop in stopsLatLng) {
      if (FFAppState().stopimagen != null) {
        rideMarkers
            .add({'latLng': stop, 'icon': FFAppState().stopimagen.toString()});
      }
    }

// 📌 **TERCERO: Finalmente, agregar el destino final**
    if (schoolLatLng != null && FFAppState().ScoolImagen != null) {
      rideMarkers.add({
        'latLng': schoolLatLng,
        'icon': FFAppState().ScoolImagen.toString()
      });
    }

    print("✅ [SUCCESS] Datos de la ruta obtenidos correctamente.");

// 📌 6️⃣ **Actualizar en FlutterFlow**
    print("🔄 [DEBUG] Actualizando FFAppState con las paradas...");
    FFAppState().update(() {
      FFAppState().rideMarkers =
          rideMarkers.map((marker) => marker['latLng'] as ff.LatLng).toList();

      // Aseguramos que todos los íconos sean string válidos
      FFAppState().markerColors = rideMarkers
          .map((marker) => marker['icon']?.toString() ?? "")
          .toList();
    });

    // 📌 7️⃣ **Establecer la parada de inicio como la posición inicial del mapa**
    if (rideMarkers.isNotEmpty) {
      var firstLocation = rideMarkers.first['latLng'] as ff.LatLng;
      FFAppState().update(() {
        FFAppState().initialMapCenter = [firstLocation];
      });
      print(
          "📌 [DEBUG] Estableciendo centro inicial del mapa en: ${FFAppState().initialMapCenter}");
    }

    // 📌 8️⃣ **Crear la línea de ruta**
    List<ff.LatLng> polylinePoints = [];
    if (routeLatLng != null) polylinePoints.add(routeLatLng);
    polylinePoints.addAll(stopsLatLng);
    if (schoolLatLng != null) polylinePoints.add(schoolLatLng);

    FFAppState().update(() {
      FFAppState().routePolyline = polylinePoints;
    });

    print("✅ [DEBUG] Línea de ruta creada con puntos: $polylinePoints");

    // ✅ **Corrección: Devolver una lista de ff.LatLng**
    return rideMarkers.map((marker) => marker['latLng'] as ff.LatLng).toList();
  } catch (e, stackTrace) {
    print("❌ [ERROR] Ocurrió un error en fetchRideForDriver: $e");
    print("🛠️ [DEBUG] StackTrace: $stackTrace");
    return [];
  }
}
