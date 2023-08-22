import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mortal_combat/controllers/characters_controller.dart';
import 'package:mortal_combat/widgets/components/line_chart_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/character/character.dart';
import '../models/custom_exception.dart';
import '../widgets/characters/character_dialog.dart';
import '../widgets/characters/character_error.dart';
import '../widgets/characters/characters_listview.dart';
import '../widgets/characters/character_choose_item_view.dart';

class CharacterChooseScreen extends ConsumerStatefulWidget {
  final String widgetId;
  final String mode;
  const CharacterChooseScreen({super.key, required this.widgetId, required this.mode});

  @override
  ConsumerState<CharacterChooseScreen> createState() => _CharacterChooseScreenState();
}

class _CharacterChooseScreenState extends ConsumerState<CharacterChooseScreen> {
  late List<ListItemData> listData = [];
  Character selectedValue = Character.empty();
  GlobalKey<SfCartesianChartState> cartesianChartKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final charactersState = ref.watch(charactersControllerProvider);

    callback(val, key){
      setState(() {
        selectedValue = val;
        cartesianChartKey = key;
      });
    }

    void getListData(List<Character> characters){
      listData = characters.map((e) => ListItemData(e, callback, null)).toList();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Choose character'),
        centerTitle: true,
      ),
      body: charactersState.when(
        data: (characters) {
          if (listData.isEmpty){
            getListData(characters);
          }
          return ListView(
            children: listData.map((e) => CharacterChooseItemView(data: e, selectedValue: selectedValue, callback: callback,)).toList(),
          );
        },

        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, _) => CharacterError(
          message:
          error is CustomException ? error.message! : 'Что-то пошло не так!',
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if(selectedValue.id != null){
              if(widget.mode == 'character'){
                await ref.read(charactersControllerProvider.notifier).sendCharacterToWidget(widget.widgetId, selectedValue);
              } else if(widget.mode == "statistic"){
                await ref.read(charactersControllerProvider.notifier).sendCharacterWithChartToWidget(widget.widgetId, selectedValue, cartesianChartKey);
              }
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          },
          child: const Icon(Icons.done)
      ),
    );
  }
}

class ListItemData {
  final Character character;
  final Function callback;
  LineChart? chart;
  GlobalKey<SfCartesianChartState>? key;

  ListItemData(this.character, this.callback, this.chart);
}

