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

Future<bool> requestLocationPermission(BuildContext context) async {
  try {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      bool userAccepted = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Permiso de Ubicación"),
            content: Text(
                "Esta aplicación necesita acceder a tu ubicación. ¿Deseas conceder el permiso?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Aceptar"),
              ),
            ],
          );
        },
      );

      if (userAccepted) {
        LocationPermission newPermission = await Geolocator.requestPermission();
        return newPermission == LocationPermission.always ||
            newPermission == LocationPermission.whileInUse;
      } else {
        return false;
      }
    } else if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  } catch (e) {
    print("❌ [ERROR] No se pudo solicitar el permiso de ubicación: $e");
    return false;
  }
}
