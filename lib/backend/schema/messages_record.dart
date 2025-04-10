import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessagesRecord extends FirestoreRecord {
  MessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "senderId" field.
  String? _senderId;
  String get senderId => _senderId ?? '';
  bool hasSenderId() => _senderId != null;

  // "receiverId" field.
  String? _receiverId;
  String get receiverId => _receiverId ?? '';
  bool hasReceiverId() => _receiverId != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "chatId" field.
  String? _chatId;
  String get chatId => _chatId ?? '';
  bool hasChatId() => _chatId != null;

  void _initializeFields() {
    _senderId = snapshotData['senderId'] as String?;
    _receiverId = snapshotData['receiverId'] as String?;
    _message = snapshotData['message'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _chatId = snapshotData['chatId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Messages');

  static Stream<MessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MessagesRecord.fromSnapshot(s));

  static Future<MessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MessagesRecord.fromSnapshot(s));

  static MessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMessagesRecordData({
  String? senderId,
  String? receiverId,
  String? message,
  DateTime? timestamp,
  String? chatId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'chatId': chatId,
    }.withoutNulls,
  );

  return firestoreData;
}

class MessagesRecordDocumentEquality implements Equality<MessagesRecord> {
  const MessagesRecordDocumentEquality();

  @override
  bool equals(MessagesRecord? e1, MessagesRecord? e2) {
    return e1?.senderId == e2?.senderId &&
        e1?.receiverId == e2?.receiverId &&
        e1?.message == e2?.message &&
        e1?.timestamp == e2?.timestamp &&
        e1?.chatId == e2?.chatId;
  }

  @override
  int hash(MessagesRecord? e) => const ListEquality()
      .hash([e?.senderId, e?.receiverId, e?.message, e?.timestamp, e?.chatId]);

  @override
  bool isValidKey(Object? o) => o is MessagesRecord;
}
