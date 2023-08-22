import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/characters_controller.dart';
import '../../models/custom_exception.dart';
import 'character_error.dart';
import 'character_item_view.dart';

class CharactersListView extends HookConsumerWidget {
  const CharactersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charactersState = ref.watch(charactersControllerProvider);
    return charactersState.when(
      data: (characters) {
        return characters.isEmpty ?
        const Center(
          child: Text('Нажмите +, чтобы создать добавить первого персонажа!'),
        ) :
        ListView(
          children: characters.map((e) => CharacterItemView(character: e)).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => CharacterError(
        message:
        error is CustomException ? error.message! : 'Что-то пошло не так!',
      ),
    );
  }
}