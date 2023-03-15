import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSalesProductsWidget extends StatelessWidget {
  const ChartSalesProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
        backgroundColor: colorScheme.secondary.withAlpha(10),
        title: ChartTitle(
            text: 'Sales Products',
            textStyle: Fonts.t5(),
            alignment: ChartAlignment.near),
        series: <CircularSeries>[
          DoughnutSeries<_ChartData, String>(
              dataLabelSettings: DataLabelSettings(
                  builder: (data, point, series, pointIndex, seriesIndex) =>
                      Text(data.y.toString(), style: Fonts.t4()),
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside),
              enableTooltip: true,
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Sales Products')
        ]);
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

// ignore: library_private_types_in_public_api
List<_ChartData> data = [
  _ChartData('David', 25),
  _ChartData('Steve', 38),
  _ChartData('Jack', 34),
  _ChartData('Others', 52)
];
