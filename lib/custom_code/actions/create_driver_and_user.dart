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

Future<String> createDriverAndUser(
  String name,
  String schoolId, // Ahora school es el ID de la escuela
  String experience,
  String email,
  String certifications,
  String serviceArea,
  String schedule,
  String licenseNumber,
  String phone,
  String emergencyPhone,
  String routeNumber,
  String numberBus,
  String
      photo, // Este parámetro se define como String (Image Path en FlutterFlow)
) async {
  String mensaje = "Driver and user registered successfully";

  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    // Crear la cuenta con el email y la contraseña por defecto ("Driver123")
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: "Driver123", // Contraseña fija por defecto
    );
    user = userCredential.user;

    if (user == null) {
      return "Error creating user";
    }

    // Obtener el ID del usuario recién creado
    final String userId = user.uid;

    // Obtener el nombre de la escuela desde la colección 'School'
    String schoolName =
        "Unknown School"; // Valor predeterminado si no encuentra la escuela

    try {
      DocumentSnapshot<Map<String, dynamic>> schoolDoc = await FirebaseFirestore
          .instance
          .collection('School')
          .doc(schoolId)
          .get();

      if (schoolDoc.exists) {
        schoolName = schoolDoc.data()?['SchoolName'] ?? "Unknown School";
      }
    } catch (e) {
      return "Error retrieving school name: $e";
    }

    // Referencia a la colección 'users'
    final CollectionReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users');

    // Guardar los datos del usuario en Firestore
    await users.doc(userId).set({
      'uid': userId,
      'display_name': name,
      'role': 'Driver',
      'email': email,
      'photo_url': photo,
      'created_time': DateTime.now(),
    });

    // Referencia a la colección 'Driver'
    final CollectionReference<Map<String, dynamic>> driver =
        FirebaseFirestore.instance.collection('Driver');

    // Guardar los datos del conductor en Firestore,
    // ahora School guarda el **nombre** en lugar del ID
    await driver.add({
      'Name': name,
      'School': schoolName, // Se guarda el nombre en lugar del ID
      'Experience': experience,
      'Email': email,
      'Certifications': certifications,
      'ServiceArea': serviceArea,
      'Schedule': schedule,
      'LicenseNumber': licenseNumber,
      'Phone': phone,
      'EmergencyPhone': emergencyPhone,
      'RouteNumber': routeNumber,
      'NumberBus': numberBus,
      'uid': userId,
      'userId': users.doc(userId),
      'Photo': photo,
    });

    return mensaje;
  } on FirebaseAuthException catch (e) {
    return "Firebase Auth Error: ${e.code}";
  } catch (e) {
    return "Error: $e";
  }
}
