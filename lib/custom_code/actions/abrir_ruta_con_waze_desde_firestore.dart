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
import 'package:url_launcher/url_launcher.dart';

Future<void> abrirRutaConWazeDesdeFirestore(
  BuildContext context,
  String driverId, // ID del documento del driver en la colección 'users'
) async {
  try {
    print("🚗 [DEBUG] Obteniendo ubicación actual del conductor...");

    // 1️⃣ Verificar permisos
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("❌ [ERROR] Permiso de ubicación denegado.");
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print("⚠️ [ERROR] Permiso denegado permanentemente.");
      await Geolocator.openAppSettings();
      return;
    }

    // 2️⃣ Obtener ubicación actual
    Position posicionActual = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    print(
        "📍 [DEBUG] Ubicación actual: ${posicionActual.latitude}, ${posicionActual.longitude}");

    // 3️⃣ Obtener documento del driver
    final driverDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(driverId)
        .get();
    if (!driverDoc.exists) {
      print("❌ [ERROR] No se encontró el usuario.");
      return;
    }

    final driverData = driverDoc.data() as Map<String, dynamic>;
    final String? schoolId = driverData['school'];

    if (schoolId == null || schoolId.isEmpty) {
      print("❌ [ERROR] El campo 'school' está vacío.");
      return;
    }

    // 4️⃣ Obtener documento de la escuela
    final schoolDoc = await FirebaseFirestore.instance
        .collection('School')
        .doc(schoolId)
        .get();
    if (!schoolDoc.exists) {
      print("❌ [ERROR] No se encontró la escuela.");
      return;
    }

    final schoolData = schoolDoc.data() as Map<String, dynamic>;
    if (!schoolData.containsKey('Location')) {
      print("❌ [ERROR] La escuela no tiene coordenadas en 'Location'.");
      return;
    }

    final location = schoolData['Location']; // Debe ser un GeoPoint o mapa
    double lat = 0;
    double lng = 0;

    if (location is GeoPoint) {
      lat = location.latitude;
      lng = location.longitude;
    } else if (location is Map<String, dynamic>) {
      lat = location['latitude'];
      lng = location['longitude'];
    } else {
      print("❌ [ERROR] Formato desconocido en 'Location'.");
      return;
    }

    print("🎯 [DEBUG] Ubicación destino (escuela): $lat, $lng");

    // 5️⃣ Abrir Waze con ruta
    final Uri wazeUri =
        Uri.parse('https://waze.com/ul?ll=$lat,$lng&navigate=yes');

    if (await canLaunchUrl(wazeUri)) {
      await launchUrl(wazeUri, mode: LaunchMode.externalApplication);
      print("🧭 [WAZE] Navegación hacia la escuela iniciada.");
    } else {
      print("❌ [ERROR] No se pudo abrir Waze.");
    }
  } catch (e) {
    print("❌ [ERROR] Error en abrirRutaConWazeDesdeFirestore: $e");
  }
}
