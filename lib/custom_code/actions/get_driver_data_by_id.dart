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
import 'dart:convert';

/// Esta acción consulta la colección "Driver" y retorna los datos
/// del driver que coincidan con el uid proporcionado en formato JSON.
/// Parámetro:
///   driverId: String con el uid del driver
///
/// Retorna:
///   - Un String en formato JSON con los datos del driver, si se encuentra.
///   - Un mensaje de error o "No driver found" si no se encuentra.
Future<String> getDriverDataById(
  String driverId,
) async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Driver')
        .where('uid', isEqualTo: driverId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Convertir los datos del primer documento encontrado a Map<String, dynamic>
      Map<String, dynamic> driverData =
          snapshot.docs.first.data() as Map<String, dynamic>;
      // Convertir el Map a un String en formato JSON
      String jsonString = jsonEncode(driverData);
      return jsonString;
    } else {
      return "No driver found for id: $driverId";
    }
  } catch (e) {
    return "Error: $e";
  }
}
// End custom action code
