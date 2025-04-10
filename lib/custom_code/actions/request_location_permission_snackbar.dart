// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:location/location.dart';

Future<void> requestLocationPermissionSnackbar(BuildContext context) async {
  Location location = Location();
  PermissionStatus permissionGranted = await location.hasPermission();

  if (permissionGranted == PermissionStatus.denied) {
    // Mostrar SnackBar pidiendo los permisos
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Esta app necesita acceso a tu ubicación. Actívala en Configuración.",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: "Permitir",
          textColor: Colors.white,
          onPressed: () async {
            // Solicitar permisos cuando el usuario presiona "Permitir"
            permissionGranted = await location.requestPermission();
            if (permissionGranted == PermissionStatus.granted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("¡Permiso concedido! 🎉"),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Permiso denegado. No se podrá acceder a la ubicación."),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
        duration: Duration(seconds: 5),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Los permisos ya están concedidos. 🎉"),
        backgroundColor: Colors.green,
      ),
    );
  }
}
