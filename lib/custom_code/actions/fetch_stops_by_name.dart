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

Future<List<String>> fetchStopsByName(String selectedName) async {
  try {
    print("🚀 Buscando paradas con el nombre: $selectedName");

    // Referencia a la colección "stops"
    CollectionReference stopsCollection =
        FirebaseFirestore.instance.collection('stops');

    // Realizar la consulta filtrando por el nombre
    QuerySnapshot querySnapshot =
        await stopsCollection.where('name', isEqualTo: selectedName).get();

    // Extraer los valores de 'namestops' y convertirlos en una lista
    List<String> stopsList =
        querySnapshot.docs.map((doc) => doc['namestops'].toString()).toList();

    print("✅ Paradas encontradas: $stopsList");

    return stopsList;
  } catch (e) {
    print("❌ ERROR al obtener paradas: $e");
    return [];
  }
}
