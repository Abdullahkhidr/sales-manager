import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/analysis/domain/entities/earning_statistics.dart';
import 'package:manager/features/analysis/domain/repository/statistics_repository.dart';

class GetDailyProfitsUsecase {
  StatisticsRepository statisticsRepository;
  GetDailyProfitsUsecase(this.statisticsRepository);
  Either<Failure, List<EarningStatistics>> call(DateTime dateTime) =>
      statisticsRepository.dailyProfits(dateTime);
}
