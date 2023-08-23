import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mortal_combat/styles/colors/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:path_provider/path_provider.dart';

import '../../controllers/characters_controller.dart';
import '../../models/character/character.dart';
import '../../models/win_rate/win_rate.dart';

enum ChartMode {full, short}

class LineChart extends ConsumerWidget {
  final Character character;
  final ChartMode mode;
  final GlobalKey<SfCartesianChartState> cartesianChartKey;

  LineChart({super.key, required this.character, required this.cartesianChartKey, this.mode = ChartMode.full});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        key: cartesianChartKey,
        primaryXAxis: CategoryAxis(
            isVisible: mode == ChartMode.full? true : false
        ),
        primaryYAxis: CategoryAxis(
            isVisible: mode == ChartMode.full? true : false
        ),
        series: <ChartSeries<WinRate, String>>[
          SplineAreaSeries<WinRate, String>(
              splineType: SplineType.natural,
              dataSource:  character.rates!,
              xValueMapper: (WinRate rate, _) => rate.id,
              yValueMapper: (WinRate rate, _) => rate.value,
              gradient: LinearGradient(
                  colors: [
                    AppColors.spline_color,
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          SplineSeries(
              dataSource:  character.rates!,
              xValueMapper: (WinRate rate, _) => rate.id,
              yValueMapper: (WinRate rate, _) => rate.value,
              color: AppColors.accent_color,
              width: 4,
              markerSettings: MarkerSettings(
                isVisible: true,
                color: AppColors.spline_color,
                borderWidth: 3,
                borderColor: AppColors.accent_color,
                shape: DataMarkerType.circle,
              )
          )
        ]
    );
  }
}



