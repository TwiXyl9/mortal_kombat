import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mortal_combat/config/routes_names.dart';
import 'package:mortal_combat/helpers/navigation_helper.dart';
import 'package:mortal_combat/locator.dart';
import 'package:mortal_combat/widgets/characters/character_dialog.dart';

import '../../models/character/character.dart';

class CharacterItemView extends ConsumerWidget {
  final Character character;
  const CharacterItemView({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      key: ValueKey(character.id),
      title: Text(character.name),
      onTap: () => CharacterDialog.show(context, character),
      trailing: TextButton(
        onPressed: () {
          locator<NavigationHelper>().navigateToWithParams('character', {'id': character.id!});
        },
        child: Text("Подробнее..."),

      ),
      //onLongPress: () => ref.read(tasksControllerProvider.notifier).deleteTask(taskId: task.id!),
    );
  }
}