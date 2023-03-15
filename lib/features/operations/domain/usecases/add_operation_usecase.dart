import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/domain/repository/operations_repository.dart';

class AddOperationUsecase {
  OperationsRepository operationsRepository;
  AddOperationUsecase(this.operationsRepository);
  Future<Either<Failure, Operation>> call(Operation operation) async =>
      await operationsRepository.addOperation(operation);
}
