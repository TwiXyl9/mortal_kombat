import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:home_widget/home_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mortal_combat/helpers/image_helper.dart';

import 'package:mortal_combat/repositories/images_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


import '../models/character/character.dart';
import '../models/custom_exception.dart';
import '../models/win_rate/win_rate.dart';
import '../repositories/character_winrate_repository.dart';
import '../repositories/characters_repository.dart';
import '../widgets/components/line_chart_view.dart';



final charactersExceptionProvider = StateProvider<CustomException?>((_) => null);

final charactersControllerProvider = StateNotifierProvider<CharactersController, AsyncValue<List<Character>>>((ref) {
      return CharactersController(ref);
    }
);

class CharactersController extends StateNotifier<AsyncValue<List<Character>>> {
  final Ref _ref;

  CharactersController(this._ref) : super(AsyncValue.loading())  {
    retrieveCharacters();
  }

  Future<void> retrieveCharacters({bool isRefreshing = false}) async {
    if(isRefreshing) state = AsyncValue.loading();
    try {
      final tasks = await _ref.read(charactersRepositoryProvider).retrieveCharacters();
      if (mounted) {
        state = AsyncValue.data(tasks);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addCharacter({
    required String name,
    required XFile image
  }) async {
    try {
      final imgUrl = await _ref.read(imagesRepositoryProvider).addImage(image: image);
      final character = Character(name: name, imgUrl: imgUrl);
      final characterId = await _ref.read(charactersRepositoryProvider).createCharacter(character: character);
      state.whenData((characters) => state = AsyncValue.data(characters..add(character.copyWith(id: characterId))));
    } on CustomException catch (e) {
      _ref.read(charactersExceptionProvider.notifier).state = e;
    }
  }

  Future<void> updateCharacter({
    required Character updatedCharacter,
    required XFile image
  }) async {
    try {
      final imgUrl = await _ref.read(imagesRepositoryProvider).updateImage(oldUrl: updatedCharacter.imgUrl,image: image);
      updatedCharacter = updatedCharacter.copyWith(imgUrl: imgUrl);
      await _ref.read(charactersRepositoryProvider).updateCharacter(character: updatedCharacter);
      state.whenData(
              (characters) {
            state = AsyncValue.data([
              for (final character in characters)
                if (character.id == updatedCharacter.id) updatedCharacter else character
            ]);
          });
    } on CustomException catch (e) {
      _ref.read(charactersExceptionProvider.notifier).state = e;
    }
  }

  Future<void> deleteCharacter({
    required Character character,
  }) async {
    try {
      await _ref.read(imagesRepositoryProvider).deleteImage(imgUrl: character.imgUrl);
      await _ref.read(charactersRepositoryProvider).deleteCharacter(characterId: character.id!);
      state.whenData((characters) => state = AsyncValue.data(characters..removeWhere((char) => char.id == character.id)));
    } on CustomException catch (e) {
      _ref.read(charactersExceptionProvider.notifier).state = e;
    }
  }

  Future<void> sendCharacterToWidget(String widgetId, Character character) async {
    try {
      String characterImgName = 'mk/$widgetId/characterImg.png';
      String? characterImg = await ImageHelper().downloadImage(character.imgUrl, characterImgName);
      await HomeWidget.saveWidgetData<String>(
          widgetId,
          jsonEncode({
            'id': character.id,
            'name': character.name,
            'img': characterImg
          })
      );
      await HomeWidget.updateWidget(name: 'CharacterWidgetProvider', iOSName: 'CharacterWidgetProvider');
    } on CustomException catch (e) {
      _ref.read(charactersExceptionProvider.notifier).state = e;
    }
  }

  Future<void> sendCharacterWithChartToWidget(String widgetId, Character character, GlobalKey<SfCartesianChartState> cartesianChartKey) async {
    try {
      String statisticImg = await ImageHelper().saveWidgetToImage(cartesianChartKey, widgetId);
      String characterImgName = 'mk/$widgetId/characterImg.png';
      String? characterImg = await ImageHelper().downloadImage(character.imgUrl, characterImgName);
      await HomeWidget.saveWidgetData<String>(
          widgetId,
          jsonEncode({
            'id': character.id,
            'name': character.name,
            'img': characterImg,
            'statistic': {
              'statisticLast': character.rates!.last.value,
              'statisticHigh': character.rates!.reduce((f, s) => f.value > s.value ? f : s).value,
              'statisticDiff': character.rates!.last.value - character.rates![character.rates!.length - 2].value,
              'img': statisticImg
            }
          })
      );
      await HomeWidget.updateWidget(name: 'StatisticWidgetProvider', iOSName: 'StatisticWidgetProvider');
    } on CustomException catch (e) {
      _ref.read(charactersExceptionProvider.notifier).state = e;
    }
  }
}