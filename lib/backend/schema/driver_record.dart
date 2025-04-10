import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DriverRecord extends FirestoreRecord {
  DriverRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "School" field.
  String? _school;
  String get school => _school ?? '';
  bool hasSchool() => _school != null;

  // "Photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  bool hasPhoto() => _photo != null;

  // "Experience" field.
  String? _experience;
  String get experience => _experience ?? '';
  bool hasExperience() => _experience != null;

  // "Email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "Certifications" field.
  String? _certifications;
  String get certifications => _certifications ?? '';
  bool hasCertifications() => _certifications != null;

  // "ServiceArea" field.
  String? _serviceArea;
  String get serviceArea => _serviceArea ?? '';
  bool hasServiceArea() => _serviceArea != null;

  // "Schedule" field.
  String? _schedule;
  String get schedule => _schedule ?? '';
  bool hasSchedule() => _schedule != null;

  // "LicenseNumber" field.
  String? _licenseNumber;
  String get licenseNumber => _licenseNumber ?? '';
  bool hasLicenseNumber() => _licenseNumber != null;

  // "Phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  bool hasPhone() => _phone != null;

  // "EmergencyPhone" field.
  String? _emergencyPhone;
  String get emergencyPhone => _emergencyPhone ?? '';
  bool hasEmergencyPhone() => _emergencyPhone != null;

  // "RouteNumber" field.
  String? _routeNumber;
  String get routeNumber => _routeNumber ?? '';
  bool hasRouteNumber() => _routeNumber != null;

  // "NumberBus" field.
  String? _numberBus;
  String get numberBus => _numberBus ?? '';
  bool hasNumberBus() => _numberBus != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "userId" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "pickup_stop" field.
  DocumentReference? _pickupStop;
  DocumentReference? get pickupStop => _pickupStop;
  bool hasPickupStop() => _pickupStop != null;

  // "dropoff_school" field.
  DocumentReference? _dropoffSchool;
  DocumentReference? get dropoffSchool => _dropoffSchool;
  bool hasDropoffSchool() => _dropoffSchool != null;

  void _initializeFields() {
    _name = snapshotData['Name'] as String?;
    _school = snapshotData['School'] as String?;
    _photo = snapshotData['Photo'] as String?;
    _experience = snapshotData['Experience'] as String?;
    _email = snapshotData['Email'] as String?;
    _certifications = snapshotData['Certifications'] as String?;
    _serviceArea = snapshotData['ServiceArea'] as String?;
    _schedule = snapshotData['Schedule'] as String?;
    _licenseNumber = snapshotData['LicenseNumber'] as String?;
    _phone = snapshotData['Phone'] as String?;
    _emergencyPhone = snapshotData['EmergencyPhone'] as String?;
    _routeNumber = snapshotData['RouteNumber'] as String?;
    _numberBus = snapshotData['NumberBus'] as String?;
    _uid = snapshotData['uid'] as String?;
    _userId = snapshotData['userId'] as DocumentReference?;
    _pickupStop = snapshotData['pickup_stop'] as DocumentReference?;
    _dropoffSchool = snapshotData['dropoff_school'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Driver');

  static Stream<DriverRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DriverRecord.fromSnapshot(s));

  static Future<DriverRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DriverRecord.fromSnapshot(s));

  static DriverRecord fromSnapshot(DocumentSnapshot snapshot) => DriverRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DriverRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DriverRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DriverRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DriverRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDriverRecordData({
  String? name,
  String? school,
  String? photo,
  String? experience,
  String? email,
  String? certifications,
  String? serviceArea,
  String? schedule,
  String? licenseNumber,
  String? phone,
  String? emergencyPhone,
  String? routeNumber,
  String? numberBus,
  String? uid,
  DocumentReference? userId,
  DocumentReference? pickupStop,
  DocumentReference? dropoffSchool,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Name': name,
      'School': school,
      'Photo': photo,
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
      'uid': uid,
      'userId': userId,
      'pickup_stop': pickupStop,
      'dropoff_school': dropoffSchool,
    }.withoutNulls,
  );

  return firestoreData;
}

class DriverRecordDocumentEquality implements Equality<DriverRecord> {
  const DriverRecordDocumentEquality();

  @override
  bool equals(DriverRecord? e1, DriverRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.school == e2?.school &&
        e1?.photo == e2?.photo &&
        e1?.experience == e2?.experience &&
        e1?.email == e2?.email &&
        e1?.certifications == e2?.certifications &&
        e1?.serviceArea == e2?.serviceArea &&
        e1?.schedule == e2?.schedule &&
        e1?.licenseNumber == e2?.licenseNumber &&
        e1?.phone == e2?.phone &&
        e1?.emergencyPhone == e2?.emergencyPhone &&
        e1?.routeNumber == e2?.routeNumber &&
        e1?.numberBus == e2?.numberBus &&
        e1?.uid == e2?.uid &&
        e1?.userId == e2?.userId &&
        e1?.pickupStop == e2?.pickupStop &&
        e1?.dropoffSchool == e2?.dropoffSchool;
  }

  @override
  int hash(DriverRecord? e) => const ListEquality().hash([
        e?.name,
        e?.school,
        e?.photo,
        e?.experience,
        e?.email,
        e?.certifications,
        e?.serviceArea,
        e?.schedule,
        e?.licenseNumber,
        e?.phone,
        e?.emergencyPhone,
        e?.routeNumber,
        e?.numberBus,
        e?.uid,
        e?.userId,
        e?.pickupStop,
        e?.dropoffSchool
      ]);

  @override
  bool isValidKey(Object? o) => o is DriverRecord;
}
