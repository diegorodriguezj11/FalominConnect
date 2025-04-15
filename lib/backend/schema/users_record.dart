import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "City" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "IsAdmin" field.
  bool? _isAdmin;
  bool get isAdmin => _isAdmin ?? false;
  bool hasIsAdmin() => _isAdmin != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "shortDescription" field.
  String? _shortDescription;
  String get shortDescription => _shortDescription ?? '';
  bool hasShortDescription() => _shortDescription != null;

  // "last_active_time" field.
  DateTime? _lastActiveTime;
  DateTime? get lastActiveTime => _lastActiveTime;
  bool hasLastActiveTime() => _lastActiveTime != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "LicenseNumberDriver" field.
  int? _licenseNumberDriver;
  int get licenseNumberDriver => _licenseNumberDriver ?? 0;
  bool hasLicenseNumberDriver() => _licenseNumberDriver != null;

  // "PhoneDriver" field.
  int? _phoneDriver;
  int get phoneDriver => _phoneDriver ?? 0;
  bool hasPhoneDriver() => _phoneDriver != null;

  // "EmergencyPhoneDriver" field.
  int? _emergencyPhoneDriver;
  int get emergencyPhoneDriver => _emergencyPhoneDriver ?? 0;
  bool hasEmergencyPhoneDriver() => _emergencyPhoneDriver != null;

  // "certificationsDrivers" field.
  String? _certificationsDrivers;
  String get certificationsDrivers => _certificationsDrivers ?? '';
  bool hasCertificationsDrivers() => _certificationsDrivers != null;

  // "RouteNumberDriver" field.
  int? _routeNumberDriver;
  int get routeNumberDriver => _routeNumberDriver ?? 0;
  bool hasRouteNumberDriver() => _routeNumberDriver != null;

  // "NumberBusDriver" field.
  String? _numberBusDriver;
  String get numberBusDriver => _numberBusDriver ?? '';
  bool hasNumberBusDriver() => _numberBusDriver != null;

  // "ScheduleDriver" field.
  String? _scheduleDriver;
  String get scheduleDriver => _scheduleDriver ?? '';
  bool hasScheduleDriver() => _scheduleDriver != null;

  // "ServiceAreaDriver" field.
  String? _serviceAreaDriver;
  String get serviceAreaDriver => _serviceAreaDriver ?? '';
  bool hasServiceAreaDriver() => _serviceAreaDriver != null;

  // "ExperienceDriver" field.
  String? _experienceDriver;
  String get experienceDriver => _experienceDriver ?? '';
  bool hasExperienceDriver() => _experienceDriver != null;

  // "route" field.
  bool? _route;
  bool get route => _route ?? false;
  bool hasRoute() => _route != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _city = snapshotData['City'] as String?;
    _isAdmin = snapshotData['IsAdmin'] as bool?;
    _role = snapshotData['role'] as String?;
    _shortDescription = snapshotData['shortDescription'] as String?;
    _lastActiveTime = snapshotData['last_active_time'] as DateTime?;
    _title = snapshotData['title'] as String?;
    _licenseNumberDriver = castToType<int>(snapshotData['LicenseNumberDriver']);
    _phoneDriver = castToType<int>(snapshotData['PhoneDriver']);
    _emergencyPhoneDriver =
        castToType<int>(snapshotData['EmergencyPhoneDriver']);
    _certificationsDrivers = snapshotData['certificationsDrivers'] as String?;
    _routeNumberDriver = castToType<int>(snapshotData['RouteNumberDriver']);
    _numberBusDriver = snapshotData['NumberBusDriver'] as String?;
    _scheduleDriver = snapshotData['ScheduleDriver'] as String?;
    _serviceAreaDriver = snapshotData['ServiceAreaDriver'] as String?;
    _experienceDriver = snapshotData['ExperienceDriver'] as String?;
    _route = snapshotData['route'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? city,
  bool? isAdmin,
  String? role,
  String? shortDescription,
  DateTime? lastActiveTime,
  String? title,
  int? licenseNumberDriver,
  int? phoneDriver,
  int? emergencyPhoneDriver,
  String? certificationsDrivers,
  int? routeNumberDriver,
  String? numberBusDriver,
  String? scheduleDriver,
  String? serviceAreaDriver,
  String? experienceDriver,
  bool? route,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'City': city,
      'IsAdmin': isAdmin,
      'role': role,
      'shortDescription': shortDescription,
      'last_active_time': lastActiveTime,
      'title': title,
      'LicenseNumberDriver': licenseNumberDriver,
      'PhoneDriver': phoneDriver,
      'EmergencyPhoneDriver': emergencyPhoneDriver,
      'certificationsDrivers': certificationsDrivers,
      'RouteNumberDriver': routeNumberDriver,
      'NumberBusDriver': numberBusDriver,
      'ScheduleDriver': scheduleDriver,
      'ServiceAreaDriver': serviceAreaDriver,
      'ExperienceDriver': experienceDriver,
      'route': route,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.city == e2?.city &&
        e1?.isAdmin == e2?.isAdmin &&
        e1?.role == e2?.role &&
        e1?.shortDescription == e2?.shortDescription &&
        e1?.lastActiveTime == e2?.lastActiveTime &&
        e1?.title == e2?.title &&
        e1?.licenseNumberDriver == e2?.licenseNumberDriver &&
        e1?.phoneDriver == e2?.phoneDriver &&
        e1?.emergencyPhoneDriver == e2?.emergencyPhoneDriver &&
        e1?.certificationsDrivers == e2?.certificationsDrivers &&
        e1?.routeNumberDriver == e2?.routeNumberDriver &&
        e1?.numberBusDriver == e2?.numberBusDriver &&
        e1?.scheduleDriver == e2?.scheduleDriver &&
        e1?.serviceAreaDriver == e2?.serviceAreaDriver &&
        e1?.experienceDriver == e2?.experienceDriver &&
        e1?.route == e2?.route;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.city,
        e?.isAdmin,
        e?.role,
        e?.shortDescription,
        e?.lastActiveTime,
        e?.title,
        e?.licenseNumberDriver,
        e?.phoneDriver,
        e?.emergencyPhoneDriver,
        e?.certificationsDrivers,
        e?.routeNumberDriver,
        e?.numberBusDriver,
        e?.scheduleDriver,
        e?.serviceAreaDriver,
        e?.experienceDriver,
        e?.route
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
