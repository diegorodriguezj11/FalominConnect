import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _stopimagen = prefs.getString('ff_stopimagen') ?? _stopimagen;
    });
    _safeInit(() {
      _GoImagen = prefs.getString('ff_GoImagen') ?? _GoImagen;
    });
    _safeInit(() {
      _ScoolImagen = prefs.getString('ff_ScoolImagen') ?? _ScoolImagen;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  LatLng? _placePickerValue;
  LatLng? get placePickerValue => _placePickerValue;
  set placePickerValue(LatLng? value) {
    _placePickerValue = value;
  }

  String _selectedStop = '';
  String get selectedStop => _selectedStop;
  set selectedStop(String value) {
    _selectedStop = value;
  }

  double _selectedLatitude = 0.0;
  double get selectedLatitude => _selectedLatitude;
  set selectedLatitude(double value) {
    _selectedLatitude = value;
  }

  double _selectedLongitude = 0.0;
  double get selectedLongitude => _selectedLongitude;
  set selectedLongitude(double value) {
    _selectedLongitude = value;
  }

  LatLng? _startingLocation;
  LatLng? get startingLocation => _startingLocation;
  set startingLocation(LatLng? value) {
    _startingLocation = value;
  }

  LatLng? _destinationLocation;
  LatLng? get destinationLocation => _destinationLocation;
  set destinationLocation(LatLng? value) {
    _destinationLocation = value;
  }

  String _selectedName = '';
  String get selectedName => _selectedName;
  set selectedName(String value) {
    _selectedName = value;
  }

  List<String> _filteredStops = [];
  List<String> get filteredStops => _filteredStops;
  set filteredStops(List<String> value) {
    _filteredStops = value;
  }

  void addToFilteredStops(String value) {
    filteredStops.add(value);
  }

  void removeFromFilteredStops(String value) {
    filteredStops.remove(value);
  }

  void removeAtIndexFromFilteredStops(int index) {
    filteredStops.removeAt(index);
  }

  void updateFilteredStopsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    filteredStops[index] = updateFn(_filteredStops[index]);
  }

  void insertAtIndexInFilteredStops(int index, String value) {
    filteredStops.insert(index, value);
  }

  String _selectedUserId = '';
  String get selectedUserId => _selectedUserId;
  set selectedUserId(String value) {
    _selectedUserId = value;
  }

  List<LatLng> _rideMarkers = [];
  List<LatLng> get rideMarkers => _rideMarkers;
  set rideMarkers(List<LatLng> value) {
    _rideMarkers = value;
  }

  void addToRideMarkers(LatLng value) {
    rideMarkers.add(value);
  }

  void removeFromRideMarkers(LatLng value) {
    rideMarkers.remove(value);
  }

  void removeAtIndexFromRideMarkers(int index) {
    rideMarkers.removeAt(index);
  }

  void updateRideMarkersAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    rideMarkers[index] = updateFn(_rideMarkers[index]);
  }

  void insertAtIndexInRideMarkers(int index, LatLng value) {
    rideMarkers.insert(index, value);
  }

  List<LatLng> _initialMapCenter = [];
  List<LatLng> get initialMapCenter => _initialMapCenter;
  set initialMapCenter(List<LatLng> value) {
    _initialMapCenter = value;
  }

  void addToInitialMapCenter(LatLng value) {
    initialMapCenter.add(value);
  }

  void removeFromInitialMapCenter(LatLng value) {
    initialMapCenter.remove(value);
  }

  void removeAtIndexFromInitialMapCenter(int index) {
    initialMapCenter.removeAt(index);
  }

  void updateInitialMapCenterAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    initialMapCenter[index] = updateFn(_initialMapCenter[index]);
  }

  void insertAtIndexInInitialMapCenter(int index, LatLng value) {
    initialMapCenter.insert(index, value);
  }

  List<LatLng> _routePolyline = [];
  List<LatLng> get routePolyline => _routePolyline;
  set routePolyline(List<LatLng> value) {
    _routePolyline = value;
  }

  void addToRoutePolyline(LatLng value) {
    routePolyline.add(value);
  }

  void removeFromRoutePolyline(LatLng value) {
    routePolyline.remove(value);
  }

  void removeAtIndexFromRoutePolyline(int index) {
    routePolyline.removeAt(index);
  }

  void updateRoutePolylineAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    routePolyline[index] = updateFn(_routePolyline[index]);
  }

  void insertAtIndexInRoutePolyline(int index, LatLng value) {
    routePolyline.insert(index, value);
  }

  LatLng? _currentDriverLocation;
  LatLng? get currentDriverLocation => _currentDriverLocation;
  set currentDriverLocation(LatLng? value) {
    _currentDriverLocation = value;
  }

  LatLng? _driverLocation;
  LatLng? get driverLocation => _driverLocation;
  set driverLocation(LatLng? value) {
    _driverLocation = value;
  }

  String _stopimagen =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/auto-bus-2m7kr7/assets/amey073h3x4l/Stop.png';
  String get stopimagen => _stopimagen;
  set stopimagen(String value) {
    _stopimagen = value;
    prefs.setString('ff_stopimagen', value);
  }

  String _GoImagen =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/auto-bus-2m7kr7/assets/o6hyhuvnbtum/Empezar.png';
  String get GoImagen => _GoImagen;
  set GoImagen(String value) {
    _GoImagen = value;
    prefs.setString('ff_GoImagen', value);
  }

  String _ScoolImagen =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/auto-bus-2m7kr7/assets/ka8agf6sn1ji/Escuelas.png';
  String get ScoolImagen => _ScoolImagen;
  set ScoolImagen(String value) {
    _ScoolImagen = value;
    prefs.setString('ff_ScoolImagen', value);
  }

  String _BusImagen =
      '\"C:\\Users\\diego\\OneDrive\\Documentos\\Universidad\\Desorrollo de Sistemas\\RutaImagenes\\Bus.png\"';
  String get BusImagen => _BusImagen;
  set BusImagen(String value) {
    _BusImagen = value;
  }

  List<dynamic> _rideMarkersInfo = [];
  List<dynamic> get rideMarkersInfo => _rideMarkersInfo;
  set rideMarkersInfo(List<dynamic> value) {
    _rideMarkersInfo = value;
  }

  void addToRideMarkersInfo(dynamic value) {
    rideMarkersInfo.add(value);
  }

  void removeFromRideMarkersInfo(dynamic value) {
    rideMarkersInfo.remove(value);
  }

  void removeAtIndexFromRideMarkersInfo(int index) {
    rideMarkersInfo.removeAt(index);
  }

  void updateRideMarkersInfoAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    rideMarkersInfo[index] = updateFn(_rideMarkersInfo[index]);
  }

  void insertAtIndexInRideMarkersInfo(int index, dynamic value) {
    rideMarkersInfo.insert(index, value);
  }

  List<Color> _markerColors = [];
  List<Color> get markerColors => _markerColors;
  set markerColors(List<Color> value) {
    _markerColors = value;
  }

  void addToMarkerColors(Color value) {
    markerColors.add(value);
  }

  void removeFromMarkerColors(Color value) {
    markerColors.remove(value);
  }

  void removeAtIndexFromMarkerColors(int index) {
    markerColors.removeAt(index);
  }

  void updateMarkerColorsAtIndex(
    int index,
    Color Function(Color) updateFn,
  ) {
    markerColors[index] = updateFn(_markerColors[index]);
  }

  void insertAtIndexInMarkerColors(int index, Color value) {
    markerColors.insert(index, value);
  }

  List<Color> _routeColor = [];
  List<Color> get routeColor => _routeColor;
  set routeColor(List<Color> value) {
    _routeColor = value;
  }

  void addToRouteColor(Color value) {
    routeColor.add(value);
  }

  void removeFromRouteColor(Color value) {
    routeColor.remove(value);
  }

  void removeAtIndexFromRouteColor(int index) {
    routeColor.removeAt(index);
  }

  void updateRouteColorAtIndex(
    int index,
    Color Function(Color) updateFn,
  ) {
    routeColor[index] = updateFn(_routeColor[index]);
  }

  void insertAtIndexInRouteColor(int index, Color value) {
    routeColor.insert(index, value);
  }

  final _userDocQueryManager = FutureRequestManager<UsersRecord>();
  Future<UsersRecord> userDocQuery({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<UsersRecord> Function() requestFn,
  }) =>
      _userDocQueryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserDocQueryCache() => _userDocQueryManager.clear();
  void clearUserDocQueryCacheKey(String? uniqueKey) =>
      _userDocQueryManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}
