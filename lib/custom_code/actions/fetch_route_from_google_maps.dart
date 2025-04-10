// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;
import '/flutter_flow/lat_lng.dart';

Future<List<LatLng>> fetchRouteFromGoogleMaps(List<LatLng> waypoints) async {
  const String apiKey = "AIzaSyCYyiRm3qt_mC8aUUoGYAKbdPLMhWv48f0";

  if (waypoints.isEmpty) {
    print("⚠️ [WARNING] No hay waypoints disponibles.");
    return [];
  }

  // Definir el punto de inicio y final
  String origin = "${waypoints.first.latitude},${waypoints.first.longitude}";
  String destination = "${waypoints.last.latitude},${waypoints.last.longitude}";

  // Formatear los puntos intermedios (waypoints)
  String waypointsString = waypoints
      .sublist(1, waypoints.length - 1)
      .map((point) => "${point.latitude},${point.longitude}")
      .join("|");

  // Construcción de la URL de Google Maps Directions API
  String url =
      "https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination"
      "&waypoints=$waypointsString&key=$apiKey";

  print("🗺️ [DEBUG] Solicitando ruta a Google Maps API...");

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data["status"] != "OK") {
        print("❌ [ERROR] Google Maps API devolvió un error: ${data['status']}");
        return [];
      }

      // Extraer los puntos de la ruta desde `legs`
      List<LatLng> routePoints = [];
      List steps = data["routes"][0]["legs"][0]["steps"];

      for (var step in steps) {
        double lat = step["end_location"]["lat"];
        double lng = step["end_location"]["lng"];
        routePoints.add(LatLng(lat, lng));
      }

      print(
          "✅ [SUCCESS] Ruta obtenida correctamente con ${routePoints.length} puntos.");
      return routePoints;
    } else {
      print(
          "❌ [ERROR] Falló la solicitud a Google Maps: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("❌ [ERROR] Excepción al solicitar la ruta: $e");
    return [];
  }
}

// DO NOT REMOVE OR MODIFY THE CODE BELOW!
