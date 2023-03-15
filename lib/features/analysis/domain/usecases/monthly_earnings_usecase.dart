import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/analysis/domain/entities/earning_statistics.dart';
import 'package:manager/features/analysis/domain/repository/statistics_repository.dart';

class GetMonthlyEarningsUsecase {
  StatisticsRepository statisticsRepository;
  GetMonthlyEarningsUsecase(this.statisticsRepository);
  Either<Failure, List<EarningStatistics>> call(int year) =>
      statisticsRepository.monthlyEarnings(year);
}
