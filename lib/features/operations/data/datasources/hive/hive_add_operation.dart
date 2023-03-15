import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';

Future<Either<Failure, Operation>> hiveAddOperation(Operation operation) async {
  try {
    operation.id ??= DateTime.now().microsecondsSinceEpoch.toString();

    Hive.box(HiveBoxes.operations).put(operation.id, operation);
    return Right(operation);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
