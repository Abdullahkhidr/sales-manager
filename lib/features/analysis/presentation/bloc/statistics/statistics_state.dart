part of 'statistics_bloc.dart';

@immutable
abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoadedLastOperationsState extends StatisticsState {}

class StatisticsCalculatedMonthlyEarningsState extends StatisticsState {}

class StatisticsCalculatedDailyProfitsState extends StatisticsState {}

class StatisticsChangedPeriodTypeState extends StatisticsState {}

class StatisticsChangedPeriodState extends StatisticsState {}
