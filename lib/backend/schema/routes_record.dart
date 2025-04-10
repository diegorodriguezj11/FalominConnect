import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoutesRecord extends FirestoreRecord {
  RoutesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "latitude" field.
  double? _latitude;
  double get latitude => _latitude ?? 0.0;
  bool hasLatitude() => _latitude != null;

  // "longitude" field.
  double? _longitude;
  double get longitude => _longitude ?? 0.0;
  bool hasLongitude() => _longitude != null;

  // "RouteNumber" field.
  int? _routeNumber;
  int get routeNumber => _routeNumber ?? 0;
  bool hasRouteNumber() => _routeNumber != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _latitude = castToType<double>(snapshotData['latitude']);
    _longitude = castToType<double>(snapshotData['longitude']);
    _routeNumber = castToType<int>(snapshotData['RouteNumber']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('routes');

  static Stream<RoutesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RoutesRecord.fromSnapshot(s));

  static Future<RoutesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RoutesRecord.fromSnapshot(s));

  static RoutesRecord fromSnapshot(DocumentSnapshot snapshot) => RoutesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RoutesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RoutesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RoutesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RoutesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRoutesRecordData({
  String? name,
  double? latitude,
  double? longitude,
  int? routeNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'RouteNumber': routeNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class RoutesRecordDocumentEquality implements Equality<RoutesRecord> {
  const RoutesRecordDocumentEquality();

  @override
  bool equals(RoutesRecord? e1, RoutesRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.latitude == e2?.latitude &&
        e1?.longitude == e2?.longitude &&
        e1?.routeNumber == e2?.routeNumber;
  }

  @override
  int hash(RoutesRecord? e) => const ListEquality()
      .hash([e?.name, e?.latitude, e?.longitude, e?.routeNumber]);

  @override
  bool isValidKey(Object? o) => o is RoutesRecord;
}
