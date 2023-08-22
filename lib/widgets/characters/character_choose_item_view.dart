import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mortal_combat/config/routes_names.dart';
import 'package:mortal_combat/helpers/navigation_helper.dart';
import 'package:mortal_combat/locator.dart';
import 'package:mortal_combat/screens/character_choose_screen.dart';
import 'package:mortal_combat/widgets/characters/character_dialog.dart';
import 'package:mortal_combat/widgets/components/line_chart_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/character/character.dart';
import '../../models/win_rate/win_rate.dart';
import '../../repositories/character_winrate_repository.dart';

class CharacterChooseItemView extends ConsumerWidget {
  final ListItemData data;
  final Character selectedValue;
  final Function callback;

  const CharacterChooseItemView({
    super.key,
    required this.data,
    required this.selectedValue,
    required this.callback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (data.chart == null) {
      GlobalKey<SfCartesianChartState> cartesianChartKey = GlobalKey();

      data.chart = LineChart(
        character: data.character,
        cartesianChartKey: cartesianChartKey,
      );
      data.key = cartesianChartKey;
    }

    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(data.character.name),
          data.character.rates != null?
          Container(
            width: 200,
            height: 50,
            child: data.chart,
          ) :
          Container(),
          Radio(
              value: data.character,
              groupValue: selectedValue,
              onChanged: (val) {
                callback(val, data.key);
              })
        ],
      ),
    );
  }
}
