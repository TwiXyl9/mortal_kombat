import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mortal_combat/config/routes_names.dart';
import 'package:mortal_combat/helpers/navigation_helper.dart';
import 'package:mortal_combat/models/win_rate/win_rate.dart';
import 'package:mortal_combat/repositories/character_winrate_repository.dart';
import 'package:mortal_combat/widgets/components/line_chart_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/characters_controller.dart';
import '../locator.dart';
import '../models/character/character.dart';
import '../models/custom_exception.dart';
import '../widgets/characters/character_dialog.dart';
import '../widgets/characters/character_error.dart';
import '../widgets/characters/characters_listview.dart';

class CharacterItemScreen extends ConsumerWidget {
  String id;
  CharacterItemScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charactersState = ref.watch(charactersControllerProvider);
    return charactersState.when(
      data: (characters) {
          Character? character = characters.firstWhere((element) => element.id == id);
          return Scaffold(
            backgroundColor: Colors.black54,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: character == null? Text('Error') : Text(character!.name),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => locator<NavigationHelper>().goBack(),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Image.network(character!.imgUrl),
                    (character.rates != null && character.rates!.length > 0)?
                    LineChart(character: character, cartesianChartKey: GlobalKey()) :
                    Container(),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await ref.read(charactersControllerProvider.notifier).deleteCharacter(character: character);
                  locator<NavigationHelper>().navigateTo(charactersRoute);
                },
                child: const Icon(Icons.delete,)
            ),
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