import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommentsRecord extends FirestoreRecord {
  CommentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "comments" field.
  String? _comments;
  String get comments => _comments ?? '';
  bool hasComments() => _comments != null;

  // "starts" field.
  int? _starts;
  int get starts => _starts ?? 0;
  bool hasStarts() => _starts != null;

  // "iduser" field.
  DocumentReference? _iduser;
  DocumentReference? get iduser => _iduser;
  bool hasIduser() => _iduser != null;

  // "emailUser" field.
  String? _emailUser;
  String get emailUser => _emailUser ?? '';
  bool hasEmailUser() => _emailUser != null;

  // "PhotoUser" field.
  String? _photoUser;
  String get photoUser => _photoUser ?? '';
  bool hasPhotoUser() => _photoUser != null;

  void _initializeFields() {
    _comments = snapshotData['comments'] as String?;
    _starts = castToType<int>(snapshotData['starts']);
    _iduser = snapshotData['iduser'] as DocumentReference?;
    _emailUser = snapshotData['emailUser'] as String?;
    _photoUser = snapshotData['PhotoUser'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('comments');

  static Stream<CommentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommentsRecord.fromSnapshot(s));

  static Future<CommentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CommentsRecord.fromSnapshot(s));

  static CommentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CommentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCommentsRecordData({
  String? comments,
  int? starts,
  DocumentReference? iduser,
  String? emailUser,
  String? photoUser,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'comments': comments,
      'starts': starts,
      'iduser': iduser,
      'emailUser': emailUser,
      'PhotoUser': photoUser,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommentsRecordDocumentEquality implements Equality<CommentsRecord> {
  const CommentsRecordDocumentEquality();

  @override
  bool equals(CommentsRecord? e1, CommentsRecord? e2) {
    return e1?.comments == e2?.comments &&
        e1?.starts == e2?.starts &&
        e1?.iduser == e2?.iduser &&
        e1?.emailUser == e2?.emailUser &&
        e1?.photoUser == e2?.photoUser;
  }

  @override
  int hash(CommentsRecord? e) => const ListEquality()
      .hash([e?.comments, e?.starts, e?.iduser, e?.emailUser, e?.photoUser]);

  @override
  bool isValidKey(Object? o) => o is CommentsRecord;
}
