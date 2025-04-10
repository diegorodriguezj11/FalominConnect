import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RideRecord extends FirestoreRecord {
  RideRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "RouteName" field.
  String? _routeName;
  String get routeName => _routeName ?? '';
  bool hasRouteName() => _routeName != null;

  // "route_ref" field.
  DocumentReference? _routeRef;
  DocumentReference? get routeRef => _routeRef;
  bool hasRouteRef() => _routeRef != null;

  // "school_ref" field.
  DocumentReference? _schoolRef;
  DocumentReference? get schoolRef => _schoolRef;
  bool hasSchoolRef() => _schoolRef != null;

  // "stop_ref" field.
  DocumentReference? _stopRef;
  DocumentReference? get stopRef => _stopRef;
  bool hasStopRef() => _stopRef != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  void _initializeFields() {
    _routeName = snapshotData['RouteName'] as String?;
    _routeRef = snapshotData['route_ref'] as DocumentReference?;
    _schoolRef = snapshotData['school_ref'] as DocumentReference?;
    _stopRef = snapshotData['stop_ref'] as DocumentReference?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ride');

  static Stream<RideRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RideRecord.fromSnapshot(s));

  static Future<RideRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RideRecord.fromSnapshot(s));

  static RideRecord fromSnapshot(DocumentSnapshot snapshot) => RideRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RideRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RideRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RideRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RideRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRideRecordData({
  String? routeName,
  DocumentReference? routeRef,
  DocumentReference? schoolRef,
  DocumentReference? stopRef,
  DocumentReference? userRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'RouteName': routeName,
      'route_ref': routeRef,
      'school_ref': schoolRef,
      'stop_ref': stopRef,
      'user_ref': userRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class RideRecordDocumentEquality implements Equality<RideRecord> {
  const RideRecordDocumentEquality();

  @override
  bool equals(RideRecord? e1, RideRecord? e2) {
    return e1?.routeName == e2?.routeName &&
        e1?.routeRef == e2?.routeRef &&
        e1?.schoolRef == e2?.schoolRef &&
        e1?.stopRef == e2?.stopRef &&
        e1?.userRef == e2?.userRef;
  }

  @override
  int hash(RideRecord? e) => const ListEquality()
      .hash([e?.routeName, e?.routeRef, e?.schoolRef, e?.stopRef, e?.userRef]);

  @override
  bool isValidKey(Object? o) => o is RideRecord;
}
