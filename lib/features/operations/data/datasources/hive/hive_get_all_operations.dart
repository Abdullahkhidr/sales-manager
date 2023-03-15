import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';

Either<Failure, List<Operation>> hiveGetAllOperations() {
  try {
    List<Operation> operations = Hive.box(HiveBoxes.operations)
        .toMap()
        .values
        .cast<Operation>()
        .toList();
    operations.sort((a, b) => b.date!.compareTo(a.date!));
    return Right(operations);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
