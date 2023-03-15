import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/expenses/domain/entities/expense.dart';

Either<Failure, List<Expense>> hiveGetAllExpenses() {
  try {
    List<Expense> expenses =
        Hive.box(HiveBoxes.expenses).toMap().values.cast<Expense>().toList();
    return Right(expenses);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
