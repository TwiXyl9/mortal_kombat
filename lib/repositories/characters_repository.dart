
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mortal_combat/repositories/character_winrate_repository.dart';

import '../general_providers.dart';
import '../models/character/character.dart';
import '../models/custom_exception.dart';


final charactersRepositoryProvider = Provider<CharactersRepository>((ref) => CharactersRepository(ref));

abstract class BaseCharactersRepository {
  Future<List<Character>> retrieveCharacters();
  Future<String> createCharacter({required Character character});
  Future<void> updateCharacter({required Character character});
  Future<void> deleteCharacter({required String characterId});
}

class CharactersRepository implements BaseCharactersRepository {
  final Ref _ref;

  const CharactersRepository(this._ref);

  @override
  Future<String> createCharacter({
    required Character character
  }) async {
    try {
      final docRef = await _ref.read(firebaseFirestoreProvider)
          .collection('characters')
          .add(character.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteCharacter({
    required String characterId
  }) async {
    try {
      await _ref.read(firebaseFirestoreProvider)
          .collection('characters')
          .doc(characterId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }

  }

  @override
  Future<List<Character>> retrieveCharacters() async {
    try {
      final snap = await _ref.read(firebaseFirestoreProvider)
          .collection('characters')
          .get();
      return snap.docs.map((doc) => Character.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateCharacter({
    required Character character
  }) async {
    try {
      await _ref.read(firebaseFirestoreProvider)
          .collection('characters')
          .doc(character.id)
          .update(character.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

}