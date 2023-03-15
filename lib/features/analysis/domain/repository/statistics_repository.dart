import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/analysis/domain/entities/earning_statistics.dart';

abstract class StatisticsRepository {
  Either<Failure, List<EarningStatistics>> monthlyEarnings(int year);
  Either<Failure, List<EarningStatistics>> dailyProfits(DateTime dateTime);
  // Either<Failure, List<SalesStatistics>> salesProducts(DateTime dateTime);
  // Either<Failure, List<SalesStatistics>> salesClients(DateTime dateTime);
}
