
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mortal_combat/extensions/firebase_firestore_extension.dart';
import 'package:mortal_combat/models/win_rate/win_rate.dart';

import '../general_providers.dart';
import '../models/character/character.dart';
import '../models/custom_exception.dart';


final charactersWinRateRepositoryProvider = Provider<CharacterWinRateRepository>((ref) => CharacterWinRateRepository(ref));


class CharacterWinRateRepository {
  final Ref _ref;

  const CharacterWinRateRepository(this._ref);


  Future<List<WinRate>> getWinRate(String characterId) async {
    try {
      final snap = await _ref.read(firebaseFirestoreProvider)
          .characterWinRateRef(characterId)
          .get();
      print(snap.docs.map((doc) => WinRate.fromDocument(doc)).toList());
      return snap.docs.map((doc) => WinRate.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

}