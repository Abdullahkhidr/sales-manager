import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartProfitProductsWidget extends StatelessWidget {
  final List<Operation> operations;
  const ChartProfitProductsWidget({super.key, required this.operations});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        backgroundColor: colorScheme.secondary.withAlpha(10),
        title: ChartTitle(
            text: 'Profit Products',
            textStyle: Fonts.t5(),
            alignment: ChartAlignment.near),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(interval: 1),
        tooltipBehavior: TooltipBehavior(),
        series: <ChartSeries<Operation, String>>[
          ColumnSeries<Operation, String>(
              dataSource: operations,
              xValueMapper: (Operation data, _) => data.idProduct,
              yValueMapper: (Operation data, _) => data.amount,
              name: 'Gold',
              color: const Color.fromRGBO(8, 142, 255, 1))
        ]);
  }
}
