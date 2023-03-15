import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/domain/repository/operations_repository.dart';

class GetAllOperationsUsecase {
  OperationsRepository operationsRepository;
  GetAllOperationsUsecase(this.operationsRepository);
  Either<Failure, List<Operation>> call() =>
      operationsRepository.getAllOperations();
}
