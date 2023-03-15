import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';

Future<Either<Failure, Operation>> hiveDeleteOperation(
    Operation operation) async {
  try {
    Hive.box(HiveBoxes.operations).delete(operation.id);
    return Right(operation);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
