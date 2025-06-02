import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _notesRef = FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(String uid, String title, String description) async {
    await _notesRef.add({
      'title': title,
      'description': description,
      'userId': uid,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNotes(String uid) {
    return _notesRef
        .where('userId', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> deleteNote(String docId) async {
    await _notesRef.doc(docId).delete();
  }
}
