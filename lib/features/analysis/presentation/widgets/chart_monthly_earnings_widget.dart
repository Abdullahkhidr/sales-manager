import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/analysis/domain/entities/earning_statistics.dart';
import 'package:manager/features/analysis/presentation/bloc/statistics/statistics_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartEarningsWidget extends StatelessWidget {
  final StatisticsBloc bloc;
  const ChartEarningsWidget({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: colorScheme.secondary.withAlpha(10),
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Earnings',
          textStyle: Fonts.t5(),
          alignment: ChartAlignment.near),
      primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: NumericAxis(
          // minimum: 30,
          // maximum: 80,
          axisLine: const AxisLine(width: 1),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          // labelFormat: 'value/1000 $currency',
          axisLabelFormatter: (axisLabelRenderArgs) {
            int value = axisLabelRenderArgs.value.toInt();
            return ChartAxisLabel(
                '${value > 999 || value < -999 ? '${value ~/ 1000}K' : value}',
                axisLabelRenderArgs.textStyle);
          },
          labelStyle: Fonts.t6(),
          majorTickLines: const MajorTickLines(size: 4)),
      series: [
        SplineSeries<EarningStatistics, String>(
          dataSource: bloc.periodTypeStatistics == PeriodTypeStatistics.Yearly
              ? bloc.monthlyEarnings
              : bloc.dailyProfits,
          xValueMapper: (data, index) => DateFormat(
                  bloc.periodTypeStatistics == PeriodTypeStatistics.Yearly
                      ? 'MMM'
                      : 'dd')
              .format(data.date),
          yValueMapper: (data, index) => data.amount,
          markerSettings: const MarkerSettings(isVisible: true),
          name: 'Earnings',
        ),
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}

// LineChartBarData get lineChartBarData2_3 => LineChartBarData(
//       isCurved: true,
//       curveSmoothness: 0,
//       color: colorScheme.primary,
//       barWidth: 2,
//       isStrokeCapRound: true,
//       dotData: FlDotData(show: true),
//       belowBarData: BarAreaData(show: false),
//       spots: const [
//         FlSpot(1, 3.8),
//         FlSpot(3, 1.9),
//         FlSpot(6, 5),
//         FlSpot(10, 3.3),
//         FlSpot(13, 4.5),
//       ],
//     );
