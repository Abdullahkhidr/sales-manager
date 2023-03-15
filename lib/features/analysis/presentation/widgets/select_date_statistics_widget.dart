import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/analysis/presentation/bloc/statistics/statistics_bloc.dart';

class SelectDateStatisticsWidget extends StatelessWidget {
  final StatisticsBloc bloc;
  const SelectDateStatisticsWidget({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
      decoration:
          BoxDecoration(color: colorScheme.secondary.withAlpha(10), boxShadow: [
        BoxShadow(
            blurRadius: 3,
            spreadRadius: -1,
            color: colorScheme.primary.withAlpha(10))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _ArrowMove(isNext: true, bloc: bloc),
              Text(
                  DateFormat(bloc.periodTypeStatistics ==
                              PeriodTypeStatistics.Monthly
                          ? 'MMMM yyyy'
                          : bloc.periodTypeStatistics ==
                                  PeriodTypeStatistics.Yearly
                              ? 'yyyy'
                              : bloc.startDate.toString())
                      .format(bloc.dateTime),
                  style: Fonts.t5()),
              _ArrowMove(isNext: false, bloc: bloc),
            ],
          ),
          PopupMenuButton<PeriodTypeStatistics>(
            color: colorScheme.background,
            onSelected: (type) =>
                bloc.add(StatisticsChangePeriodTypeStatisticsEvent(type)),
            itemBuilder: (BuildContext bc) {
              return [
                _ItemSelectDate('Monthly', PeriodTypeStatistics.Monthly),
                _ItemSelectDate('Yearly', PeriodTypeStatistics.Yearly),
                _ItemSelectDate('Custom', PeriodTypeStatistics.Custom),
              ];
            },
            child: Text(
                bloc.periodTypeStatistics == PeriodTypeStatistics.Monthly
                    ? 'Monthly'
                    : bloc.periodTypeStatistics == PeriodTypeStatistics.Yearly
                        ? 'Yearly'
                        : 'Custom',
                style: Fonts.t5()),
          )
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
PopupMenuItem<PeriodTypeStatistics> _ItemSelectDate(
    String title, PeriodTypeStatistics periodTypeStatistics) {
  return PopupMenuItem(
    value: periodTypeStatistics,
    child: Text(title, style: Fonts.t4()),
  );
}

class _ArrowMove extends StatelessWidget {
  final StatisticsBloc bloc;
  final bool isNext;
  // ignore: unused_element
  const _ArrowMove({super.key, required this.bloc, required this.isNext});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => bloc.add(StatisticsChangePeriodEvent(isNext)),
      icon: Icon(isNext ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
          color: colorScheme.secondary),
    );
  }
}
