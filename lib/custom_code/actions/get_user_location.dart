// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Importaciones necesarias
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/flutter_flow/flutter_flow_util.dart' as ff; // Alias para FlutterFlow

// ✅ **Función para obtener la ubicación del usuario usando Google Geolocation API**
Future<ff.LatLng?> getUserLocation() async {
  try {
    String apiKey =
        "TU_CLAVE_DE_API"; // ⚠️ Reemplázalo con tu clave de API de Google
    final url = Uri.parse(
        "https://www.googleapis.com/geolocation/v1/geolocate?key=$apiKey");

    debugPrint("🌍 [DEBUG] Enviando solicitud a Google Geolocation API...");

    final response = await http.post(url, body: jsonEncode({}), headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      double latitude = data['location']['lat'];
      double longitude = data['location']['lng'];
      debugPrint(
          "📍 [SUCCESS] Ubicación obtenida con Google API: Lat: $latitude, Lng: $longitude");
      return ff.LatLng(latitude, longitude);
    } else {
      debugPrint(
          "❌ [ERROR] Respuesta inesperada de Google API: ${response.body}");
      return null;
    }
  } catch (e) {
    debugPrint("❌ [ERROR] Excepción al obtener ubicación: ${e.toString()}");
    return null;
  }
}

// ✅ **Función para iniciar y rastrear el viaje en tiempo real**
Future<void> startTripAndTrack(BuildContext context, String driverId) async {
  try {
    debugPrint("🚗 [DEBUG] Iniciando el viaje para el conductor: $driverId");

    // 🔍 1️⃣ Verificar si driverId es válido
    if (driverId.isEmpty) {
      debugPrint("❌ [ERROR] El driverId está vacío.");
      return;
    }

    // 🔄 2️⃣ Obtener la ubicación actual usando Google Geolocation API
    ff.LatLng? locationData = await getUserLocation();

    if (locationData == null) {
      debugPrint("❌ [ERROR] No se pudo obtener la ubicación.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: No se pudo obtener la ubicación."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    debugPrint("📍 [DEBUG] Ubicación inicial obtenida: $locationData");

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
      debugPrint("✅ [SUCCESS] Ubicación inicial guardada en Firestore.");
    } catch (e, stackTrace) {
      debugPrint(
          "❌ [ERROR] Fallo al guardar ubicación en Firestore: ${e.toString()}");
      debugPrint("📌 [STACK TRACE] ${stackTrace.toString()}");
    }

    debugPrint("🚀 [DEBUG] Seguimiento en tiempo real activado.");
  } catch (e, stackTrace) {
    debugPrint(
        "❌ [CRITICAL ERROR] Fallo en `startTripAndTrack`: ${e.toString()}");
    debugPrint("📌 [STACK TRACE] ${stackTrace.toString()}");
  }
}

// ✅ **Pantalla del Mapa con Google Maps**
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  gmaps.GoogleMapController? _mapController;
  Set<gmaps.Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  // 📌 **Cargar Marcadores con `AdvancedMarkerElement`**
  void _initializeMarkers() async {
    ff.LatLng? locationData = await getUserLocation();

    if (locationData != null) {
      setState(() {
        _markers.add(
          gmaps.Marker(
            markerId: gmaps.MarkerId("ubicacion_actual"),
            position: gmaps.LatLng(locationData.latitude,
                locationData.longitude), // ✅ Alias corregido
            infoWindow: gmaps.InfoWindow(title: "Ubicación Actual"),
            icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(
                gmaps.BitmapDescriptor.hueBlue),
          ),
        );
      });
      debugPrint("✅ [SUCCESS] Marcador agregado en: $locationData");
    } else {
      debugPrint("❌ [ERROR] No se pudo obtener la ubicación para el marcador.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapa en Tiempo Real")),
      body: gmaps.GoogleMap(
        onMapCreated: (gmaps.GoogleMapController controller) {
          _mapController = controller;
        },
        initialCameraPosition: gmaps.CameraPosition(
          target: gmaps.LatLng(0, 0), // ✅ Alias corregido
          zoom: 10,
        ),
        markers: _markers,
      ),
    );
  }
}
