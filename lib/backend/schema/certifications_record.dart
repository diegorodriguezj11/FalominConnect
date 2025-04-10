import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CertificationsRecord extends FirestoreRecord {
  CertificationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  void _initializeFields() {
    _name = snapshotData['Name'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Certifications');

  static Stream<CertificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CertificationsRecord.fromSnapshot(s));

  static Future<CertificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CertificationsRecord.fromSnapshot(s));

  static CertificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CertificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CertificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CertificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CertificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CertificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCertificationsRecordData({
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Name': name,
    }.withoutNulls,
  );

  return firestoreData;
}

class CertificationsRecordDocumentEquality
    implements Equality<CertificationsRecord> {
  const CertificationsRecordDocumentEquality();

  @override
  bool equals(CertificationsRecord? e1, CertificationsRecord? e2) {
    return e1?.name == e2?.name;
  }

  @override
  int hash(CertificationsRecord? e) => const ListEquality().hash([e?.name]);

  @override
  bool isValidKey(Object? o) => o is CertificationsRecord;
}
