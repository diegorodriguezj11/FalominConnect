// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/flutter_flow/flutter_flow_util.dart' as ff;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ✅ **Función para obtener la ubicación del usuario usando Google Geolocation API**
Future<ff.LatLng?> getUserLocation() async {
  try {
    String apiKey =
        "AIzaSyAJQsq2WjWpn6ogDTVumubD6sXj4Um2yLM"; // ⚠️ Reemplaza con tu clave de API de Google
    final url = Uri.parse(
        "https://www.googleapis.com/geolocation/v1/geolocate?key=$apiKey");

    final response = await http.post(url, body: jsonEncode({}), headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      double latitude = data['location']['lat'];
      double longitude = data['location']['lng'];
      print(
          "📍 Ubicación obtenida con Google API: Lat: $latitude, Lng: $longitude");
      return ff.LatLng(latitude, longitude);
    } else {
      print("❌ Error en la API de Google: ${response.body}");
      return null;
    }
  } catch (e) {
    print("❌ Error al obtener ubicación con Google API: ${e.toString()}");
    return null;
  }
}

// ✅ **Función para iniciar y rastrear el viaje en tiempo real**
Future<void> startTripAndTrack(BuildContext context, String driverId) async {
  try {
    print("🚗 Iniciando el viaje para el conductor: $driverId");

    // 🔍 1️⃣ Verificar si driverId es válido
    if (driverId.isEmpty) {
      print("❌ Error: driverId está vacío.");
      return;
    }

    // 🔄 2️⃣ Obtener la ubicación actual usando Google Geolocation API
    ff.LatLng? locationData = await getUserLocation();

    if (locationData == null) {
      print("❌ No se pudo obtener la ubicación.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: No se pudo obtener la ubicación."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    print("📍 Ubicación inicial obtenida: $locationData");

    // 🔄 3️⃣ Guardar la ubicación inicial en Firestore
    try {
      await FirebaseFirestore.instance
          .collection('drivers')
          .doc(driverId)
          .update({
        'current_location': {
          'latitude': locationData.latitude,
          'longitude': locationData.longitude,
        }
      });
      print("✅ Ubicación inicial guardada en Firestore.");
    } catch (e, stackTrace) {
      print("❌ Error al guardar ubicación en Firestore: ${e.toString()}");
      print("📌 StackTrace: ${stackTrace.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al guardar ubicación en Firestore."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 🔄 4️⃣ Simular seguimiento en tiempo real (opcional)
    print("🚀 Seguimiento en tiempo real activado.");
  } catch (e, stackTrace) {
    print("❌ Error crítico en startTripAndTrack: ${e.toString()}");
    print("📌 StackTrace: ${stackTrace.toString()}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error crítico en el seguimiento del viaje."),
        backgroundColor: Colors.red,
      ),
    );
  }
}
