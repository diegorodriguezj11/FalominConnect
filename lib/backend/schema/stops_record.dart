import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StopsRecord extends FirestoreRecord {
  StopsRecord._(
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

  // "route_ref" field.
  DocumentReference? _routeRef;
  DocumentReference? get routeRef => _routeRef;
  bool hasRouteRef() => _routeRef != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _latitude = castToType<double>(snapshotData['latitude']);
    _longitude = castToType<double>(snapshotData['longitude']);
    _routeRef = snapshotData['route_ref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('stops');

  static Stream<StopsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StopsRecord.fromSnapshot(s));

  static Future<StopsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StopsRecord.fromSnapshot(s));

  static StopsRecord fromSnapshot(DocumentSnapshot snapshot) => StopsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StopsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StopsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StopsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StopsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStopsRecordData({
  String? name,
  double? latitude,
  double? longitude,
  DocumentReference? routeRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'route_ref': routeRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class StopsRecordDocumentEquality implements Equality<StopsRecord> {
  const StopsRecordDocumentEquality();

  @override
  bool equals(StopsRecord? e1, StopsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.latitude == e2?.latitude &&
        e1?.longitude == e2?.longitude &&
        e1?.routeRef == e2?.routeRef;
  }

  @override
  int hash(StopsRecord? e) => const ListEquality()
      .hash([e?.name, e?.latitude, e?.longitude, e?.routeRef]);

  @override
  bool isValidKey(Object? o) => o is StopsRecord;
}
