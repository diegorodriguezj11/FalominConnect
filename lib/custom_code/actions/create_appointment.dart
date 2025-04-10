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
import 'package:firebase_auth/firebase_auth.dart';

Future<String> createAppointment(
  String idSchool,
  String name,
  String age,
  String degree,
  String address,
  String fathersName,
  String contactTelephone,
  String departureTime,
) async {
  String mensaje = "Registered child";

  try {
    // Obtener el usuario actualmente autenticado
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return "User not authenticated";
    }

    // Obtener el ID del usuario
    final String userId = user.uid;

    // Referencia a la colección 'Son'
    final CollectionReference<Map<String, dynamic>> son =
        FirebaseFirestore.instance.collection('Son');

    // Crear un nuevo documento con un ID generado automáticamente
    DocumentReference newDocRef = son.doc();
    String sonId = newDocRef.id;

    // Guardar los datos en Firestore, incluyendo el ID del usuario
    await newDocRef.set({
      'id': sonId,
      'Name': name,
      'Age': age,
      'Degree': degree,
      'IdSchool': FirebaseFirestore.instance.collection('School').doc(idSchool),
      'Address': address,
      'FathersName': fathersName,
      'ContactTelephone': contactTelephone, // Asegúrate de incluir este campo
      'DepartureTime': departureTime,
      'userId': userId, // Agregar el ID del usuario que crea el registro
    });

    return mensaje;
  } on FirebaseAuthException catch (e) {
    return e.code;
  } catch (e) {
    return "Error: $e";
  }
}
