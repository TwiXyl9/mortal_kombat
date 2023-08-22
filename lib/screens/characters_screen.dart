import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/character/character.dart';
import '../widgets/characters/character_dialog.dart';
import '../widgets/characters/characters_listview.dart';

class CharactersScreen extends HookConsumerWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Characters'),
        centerTitle: true,
      ),
      body: const CharactersListView(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => CharacterDialog.show(context, Character.empty()),
          child: const Icon(Icons.add)
      ),
    );
  }
}