import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/operations_services.dart';
import 'package:manager/features/analysis/data/repository/statistics_repository_impl.dart';
import 'package:manager/features/analysis/domain/entities/earning_statistics.dart';
import 'package:manager/features/analysis/domain/repository/statistics_repository.dart';
import 'package:manager/features/analysis/domain/usecases/daily_profits_usecase.dart';
import 'package:manager/features/analysis/domain/usecases/monthly_earnings_usecase.dart';
import 'package:manager/features/operations/data/repository/operations_repository_impl.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/domain/repository/operations_repository.dart';
import 'package:manager/features/operations/domain/usecases/get_all_operations_usecase.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  OperationsRepository operationsRepository = OperationsRepositoryImpl();
  StatisticsRepository statisticsRepository = StatisticsRepositoryImpl();
  StatisticsBloc() : super(StatisticsInitial()) {
    on<StatisticsGetLastOperationsEvent>((event, emit) {
      Either<Failure, List<Operation>> result =
          GetAllOperationsUsecase(operationsRepository).call();
      result.fold((failure) {}, (resultOperations) {
        resultOperations.sort((a, b) => b.date!.compareTo(a.date!));
        allOperations = resultOperations;
        allOperations.sort((a, b) => a.date!.compareTo(b.date!));
        _calculateExpenseAndSales();
        lastOperations = resultOperations.sublist(
            0, resultOperations.length > 20 ? 20 : resultOperations.length);
      });
      emit(StatisticsLoadedLastOperationsState());
      _getMonthlyEarnings(emit);
      _getDailyProfits(emit);
    });

    on<StatisticsChangePeriodTypeStatisticsEvent>((event, emit) {
      periodTypeStatistics = event.periodTypeStatistics;
      dateTime = DateTime.now();
      _getStatisticsOfPeriod(emit);
      _calculateExpenseAndSales();
      emit(StatisticsChangedPeriodTypeState());
    });
    on<StatisticsGetMonthlyEarningEvent>((event, emit) {
      _getMonthlyEarnings(emit);
    });
    on<StatisticsGetDailyProfitsEvent>((event, emit) {
      _getDailyProfits(emit);
    });

    on<StatisticsChangePeriodEvent>((event, emit) {
      switch (periodTypeStatistics) {
        case PeriodTypeStatistics.Monthly:
          dateTime = DateTime(
              dateTime.year,
              event.isNext ? dateTime.month + 1 : dateTime.month - 1,
              dateTime.day);
          _getDailyProfits(emit);
          break;
        case PeriodTypeStatistics.Yearly:
          dateTime = DateTime(
              event.isNext ? dateTime.year + 1 : dateTime.year - 1,
              dateTime.month,
              dateTime.day);
          _getMonthlyEarnings(emit);
          break;
        case PeriodTypeStatistics.Custom:
          break;
        default:
      }
      _calculateExpenseAndSales();
      emit(StatisticsChangedPeriodState());
    });
  }

  _getDailyProfits(Emitter emit) {
    Either<Failure, List<EarningStatistics>> statistics =
        GetDailyProfitsUsecase(statisticsRepository).call(dateTime);
    statistics.fold((l) => null, (r) => dailyProfits = r);
    emit(StatisticsCalculatedDailyProfitsState());
  }

  _getMonthlyEarnings(Emitter emit) {
    Either<Failure, List<EarningStatistics>> statistics =
        GetMonthlyEarningsUsecase(statisticsRepository).call(dateTime.year);
    statistics.fold((l) => null, (r) => monthlyEarnings = r);
    emit(StatisticsCalculatedMonthlyEarningsState());
  }

  _getStatisticsOfPeriod(Emitter emit) {
    switch (periodTypeStatistics) {
      case PeriodTypeStatistics.Monthly:
        _getDailyProfits(emit);
        break;
      case PeriodTypeStatistics.Yearly:
        _getMonthlyEarnings(emit);
        break;
      case PeriodTypeStatistics.Custom:
        break;
      default:
    }
  }

  _calculateExpenseAndSales() {
    List<double> expenseAndSales = OperationsServices.calculateExpenseAndSales(
        allOperations
            .where((element) =>
                periodTypeStatistics == PeriodTypeStatistics.Yearly
                    ? element.date?.year == dateTime.year
                    : element.date?.year == dateTime.year &&
                        element.date?.month == dateTime.month)
            .toList());
    expense = expenseAndSales.first;
    sales = expenseAndSales.last;
  }

  double sales = 0;
  double expense = 0;

  DateTime dateTime = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  PeriodTypeStatistics periodTypeStatistics = PeriodTypeStatistics.Monthly;

  List<EarningStatistics> monthlyEarnings = [];
  List<EarningStatistics> dailyProfits = [];

  List<Operation> lastOperations = [];
  List<Operation> allOperations = [];
}

// ignore: constant_identifier_names
enum PeriodTypeStatistics { Monthly, Yearly, Custom }
