import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SonRecord extends FirestoreRecord {
  SonRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "Age" field.
  String? _age;
  String get age => _age ?? '';
  bool hasAge() => _age != null;

  // "Degree" field.
  String? _degree;
  String get degree => _degree ?? '';
  bool hasDegree() => _degree != null;

  // "idSchool" field.
  DocumentReference? _idSchool;
  DocumentReference? get idSchool => _idSchool;
  bool hasIdSchool() => _idSchool != null;

  // "address" field.
  LatLng? _address;
  LatLng? get address => _address;
  bool hasAddress() => _address != null;

  // "FathersName" field.
  String? _fathersName;
  String get fathersName => _fathersName ?? '';
  bool hasFathersName() => _fathersName != null;

  // "ContactTelephone" field.
  String? _contactTelephone;
  String get contactTelephone => _contactTelephone ?? '';
  bool hasContactTelephone() => _contactTelephone != null;

  // "DepartureTime" field.
  String? _departureTime;
  String get departureTime => _departureTime ?? '';
  bool hasDepartureTime() => _departureTime != null;

  void _initializeFields() {
    _name = snapshotData['Name'] as String?;
    _age = snapshotData['Age'] as String?;
    _degree = snapshotData['Degree'] as String?;
    _idSchool = snapshotData['idSchool'] as DocumentReference?;
    _address = snapshotData['address'] as LatLng?;
    _fathersName = snapshotData['FathersName'] as String?;
    _contactTelephone = snapshotData['ContactTelephone'] as String?;
    _departureTime = snapshotData['DepartureTime'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Son');

  static Stream<SonRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SonRecord.fromSnapshot(s));

  static Future<SonRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SonRecord.fromSnapshot(s));

  static SonRecord fromSnapshot(DocumentSnapshot snapshot) => SonRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SonRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SonRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SonRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SonRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSonRecordData({
  String? name,
  String? age,
  String? degree,
  DocumentReference? idSchool,
  LatLng? address,
  String? fathersName,
  String? contactTelephone,
  String? departureTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Name': name,
      'Age': age,
      'Degree': degree,
      'idSchool': idSchool,
      'address': address,
      'FathersName': fathersName,
      'ContactTelephone': contactTelephone,
      'DepartureTime': departureTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class SonRecordDocumentEquality implements Equality<SonRecord> {
  const SonRecordDocumentEquality();

  @override
  bool equals(SonRecord? e1, SonRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.age == e2?.age &&
        e1?.degree == e2?.degree &&
        e1?.idSchool == e2?.idSchool &&
        e1?.address == e2?.address &&
        e1?.fathersName == e2?.fathersName &&
        e1?.contactTelephone == e2?.contactTelephone &&
        e1?.departureTime == e2?.departureTime;
  }

  @override
  int hash(SonRecord? e) => const ListEquality().hash([
        e?.name,
        e?.age,
        e?.degree,
        e?.idSchool,
        e?.address,
        e?.fathersName,
        e?.contactTelephone,
        e?.departureTime
      ]);

  @override
  bool isValidKey(Object? o) => o is SonRecord;
}
