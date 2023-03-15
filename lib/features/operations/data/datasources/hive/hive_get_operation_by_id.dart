import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';

Either<Failure, Operation> hiveGetOperationById(String idOperation) {
  try {
    Operation operation = Hive.box(HiveBoxes.operations).get(idOperation);
    return Right(operation);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
