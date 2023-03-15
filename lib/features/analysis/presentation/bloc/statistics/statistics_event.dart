part of 'statistics_bloc.dart';

@immutable
abstract class StatisticsEvent {}

class StatisticsGetLastOperationsEvent extends StatisticsEvent {}

class StatisticsChangePeriodTypeStatisticsEvent extends StatisticsEvent {
  final PeriodTypeStatistics periodTypeStatistics;
  StatisticsChangePeriodTypeStatisticsEvent(this.periodTypeStatistics);
}

class StatisticsGetMonthlyEarningEvent extends StatisticsEvent {}

class StatisticsChangePeriodEvent extends StatisticsEvent {
  final bool isNext;
  StatisticsChangePeriodEvent(this.isNext);
}

class StatisticsGetDailyProfitsEvent extends StatisticsEvent {}
