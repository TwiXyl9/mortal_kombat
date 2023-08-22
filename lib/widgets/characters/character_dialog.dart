import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/characters_controller.dart';
import '../../models/character/character.dart';
import '../components/image_picker_view.dart';

class CharacterDialog extends HookConsumerWidget {

  final Character character;

  const CharacterDialog({Key? key, required this.character}) : super(key: key);

  static void show(BuildContext context, Character character) {
    showDialog(
      context: context,
      builder: (context) => CharacterDialog(character: character,),
    );
  }

  bool get isUpdating => character.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(text: character.name);
    XFile? selectedImage;

    if(character.id != null) {
      selectedImage = XFile(character.imgUrl);
    }

    void imgCallback(vals) {
      selectedImage = vals[0];
    }


    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(height: 12,),
              ImagePickerView(imgCallback, [selectedImage], 1),
              const SizedBox(height: 12,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: isUpdating? Colors.orange : Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    isUpdating ?
                    ref.read(charactersControllerProvider.notifier).updateCharacter(
                      updatedCharacter: character.copyWith(
                        name: textController.text.trim(),
                      ),
                      image: selectedImage!
                    ) :
                    ref.read(charactersControllerProvider.notifier).addCharacter(name: textController.text.trim(), image: selectedImage!);
                    Navigator.of(context).pop();
                  },
                  child: Text(isUpdating? 'Обновить' : 'Создать'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}