// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

Future<void> updateDriverDetails(
  String email, // Buscará al conductor usando su email
  String? certifications,
  String? emergencyPhone,
  String? experience,
  String? licenseNumber,
  String? name,
  String? numberBus,
  String? phone,
  String? routeNumber,
  String? schedule,
  String? school,
  String? serviceArea,
) async {
  try {
    // Buscar al conductor en Firestore por Email
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Driver')
        .where('Email', isEqualTo: email)
        .limit(1) // Solo obtenemos un resultado
        .get();

    if (querySnapshot.docs.isEmpty) {
      print('Error: No se encontró un conductor con ese email');
      return;
    }

    // Obtener el ID del documento
    final documentId = querySnapshot.docs.first.id;
    final driverRef =
        FirebaseFirestore.instance.collection('Driver').doc(documentId);

    // Crear un mapa solo con los valores que no sean nulos
    Map<String, dynamic> updatedData = {};

    if (certifications != null) updatedData['Certifications'] = certifications;
    if (emergencyPhone != null) updatedData['EmergencyPhone'] = emergencyPhone;
    if (experience != null) updatedData['Experience'] = experience;
    if (licenseNumber != null) updatedData['LicenseNumber'] = licenseNumber;
    if (name != null) updatedData['Name'] = name;
    if (numberBus != null) updatedData['NumberBus'] = numberBus;
    if (phone != null) updatedData['Phone'] = phone;
    if (routeNumber != null) updatedData['RouteNumber'] = routeNumber;
    if (schedule != null) updatedData['Schedule'] = schedule;
    if (school != null) updatedData['School'] = school;
    if (serviceArea != null) updatedData['ServiceArea'] = serviceArea;

    // Si hay datos para actualizar, hacer la actualización
    if (updatedData.isNotEmpty) {
      await driverRef.update(updatedData);
    }
  } catch (e) {
    print('Error al actualizar los datos del conductor: $e');
  }
}
