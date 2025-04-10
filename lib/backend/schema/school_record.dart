import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SchoolRecord extends FirestoreRecord {
  SchoolRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "SchoolName" field.
  String? _schoolName;
  String get schoolName => _schoolName ?? '';
  bool hasSchoolName() => _schoolName != null;

  // "Location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "Photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  bool hasPhoto() => _photo != null;

  // "Type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "latitude" field.
  double? _latitude;
  double get latitude => _latitude ?? 0.0;
  bool hasLatitude() => _latitude != null;

  // "longitude" field.
  double? _longitude;
  double get longitude => _longitude ?? 0.0;
  bool hasLongitude() => _longitude != null;

  void _initializeFields() {
    _schoolName = snapshotData['SchoolName'] as String?;
    _location = snapshotData['Location'] as String?;
    _photo = snapshotData['Photo'] as String?;
    _type = snapshotData['Type'] as String?;
    _latitude = castToType<double>(snapshotData['latitude']);
    _longitude = castToType<double>(snapshotData['longitude']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('School');

  static Stream<SchoolRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SchoolRecord.fromSnapshot(s));

  static Future<SchoolRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SchoolRecord.fromSnapshot(s));

  static SchoolRecord fromSnapshot(DocumentSnapshot snapshot) => SchoolRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SchoolRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SchoolRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SchoolRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SchoolRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSchoolRecordData({
  String? schoolName,
  String? location,
  String? photo,
  String? type,
  double? latitude,
  double? longitude,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'SchoolName': schoolName,
      'Location': location,
      'Photo': photo,
      'Type': type,
      'latitude': latitude,
      'longitude': longitude,
    }.withoutNulls,
  );

  return firestoreData;
}

class SchoolRecordDocumentEquality implements Equality<SchoolRecord> {
  const SchoolRecordDocumentEquality();

  @override
  bool equals(SchoolRecord? e1, SchoolRecord? e2) {
    return e1?.schoolName == e2?.schoolName &&
        e1?.location == e2?.location &&
        e1?.photo == e2?.photo &&
        e1?.type == e2?.type &&
        e1?.latitude == e2?.latitude &&
        e1?.longitude == e2?.longitude;
  }

  @override
  int hash(SchoolRecord? e) => const ListEquality().hash([
        e?.schoolName,
        e?.location,
        e?.photo,
        e?.type,
        e?.latitude,
        e?.longitude
      ]);

  @override
  bool isValidKey(Object? o) => o is SchoolRecord;
}
