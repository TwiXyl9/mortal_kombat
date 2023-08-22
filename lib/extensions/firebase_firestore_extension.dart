import 'package:cloud_firestore/cloud_firestore.dart';
extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference characterWinRateRef(String characterId) =>
      collection('winRate').doc(characterId).collection('characterWinRate');
}

