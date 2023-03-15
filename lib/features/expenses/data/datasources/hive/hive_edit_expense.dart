import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/expenses/domain/entities/expense.dart';

Future<Either<Failure, Expense>> hiveEditExpense(Expense expense) async {
  try {
    await Hive.box(HiveBoxes.expenses).put(expense.id, expense);
    return Right(expense);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
