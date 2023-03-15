import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/line_widget.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/features/analysis/presentation/bloc/statistics/statistics_bloc.dart';
import 'package:manager/features/analysis/presentation/widgets/chart_monthly_earnings_widget.dart';
import 'package:manager/features/analysis/presentation/widgets/profits_expenses_widget.dart';
import 'package:manager/features/analysis/presentation/widgets/select_date_statistics_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
        child: BlocProvider(
          create: (context) => StatisticsBloc(),
          child: BlocBuilder<StatisticsBloc, StatisticsState>(
            builder: (context, state) {
              StatisticsBloc bloc = context.read<StatisticsBloc>();
              if (state is StatisticsInitial) {
                bloc.add(StatisticsGetLastOperationsEvent());
              }
              return CustomScrollView(
                slivers: [
                  AppBarWidget('Statistics'),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    SelectDateStatisticsWidget(bloc: bloc),
                    const Space(isH: true, count: 3),
                    ProfitsExpensesWidget(
                        sales: bloc.sales, expense: bloc.expense),
                    const Space(isH: true, count: 3),
                    ChartEarningsWidget(bloc: bloc),
                    // const Space(isH: true, count: 3),
                    // const ChartSalesProductsWidget(),
                    const Space(isH: true, count: 3),
                    // ChartProfitProductsWidget(operations: bloc.allOperations),
                    const Space(isH: true, count: 3),
                    const LineWidget(),
                    const Space(isH: true, count: 3),
                    // Text('Last Operations', style: Fonts.t3()),
                    // const Space(isH: true, count: 4)
                  ])),
                  // ListOperations(operations: bloc.lastOperations)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
