import 'package:manager/features/analysis/domain/entities/earning_statistics.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:manager/features/analysis/domain/repository/statistics_repository.dart';
import 'package:manager/features/operations/data/datasources/hive/hive_get_all_operations.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  @override
  Either<Failure, List<EarningStatistics>> dailyProfits(DateTime dateTime) {
    try {
      Either<Failure, List<Operation>> allOperations = hiveGetAllOperations();
      late List<Operation> monthOperations;
      allOperations.fold((l) => null, (r) {
        monthOperations = r
            .where((element) =>
                element.date?.year == dateTime.year &&
                element.date?.month == dateTime.month &&
                element.typeOperation != TypeOperation.Buy)
            .toList();
      });
      monthOperations.sort((a, b) => a.date!.day.compareTo(a.date!.day));
      List<EarningStatistics> statistics = [];
      while (monthOperations.isNotEmpty) {
        if (statistics.isNotEmpty &&
            statistics.last.date.day == monthOperations.first.date?.day) {
          statistics.last.amount += monthOperations.first.amount ?? 0;
          monthOperations.removeAt(0);
        } else {
          statistics.add(EarningStatistics(0, monthOperations.first.date!));
        }
      }
      return Right(statistics);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<EarningStatistics>> monthlyEarnings(int year) {
    try {
      Either<Failure, List<Operation>> allOperations = hiveGetAllOperations();
      late List<Operation> yearOperations;
      allOperations.fold((l) => null, (r) {
        yearOperations = r
            .where((element) =>
                element.date?.year == year &&
                element.typeOperation != TypeOperation.Buy)
            .toList();
      });
      yearOperations.sort((a, b) => a.date!.month.compareTo(a.date!.month));
      List<EarningStatistics> statistics = [];
      while (yearOperations.isNotEmpty) {
        if (statistics.isNotEmpty &&
            statistics.last.date.month == yearOperations.first.date?.month) {
          statistics.last.amount += yearOperations.first.amount ?? 0;
          yearOperations.removeAt(0);
        } else {
          statistics.add(EarningStatistics(0, yearOperations.first.date!));
        }
      }
      return Right(statistics);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
