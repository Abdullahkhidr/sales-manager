import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';

abstract class OperationsRepository {
  Either<Failure, List<Operation>> getAllOperations();
  Future<Either<Failure, Operation>> addOperation(Operation operation);
  Future<Either<Failure, Operation>> editOperation(Operation operation);
  Future<Either<Failure, Operation>> deleteOperation(Operation operation);
}
