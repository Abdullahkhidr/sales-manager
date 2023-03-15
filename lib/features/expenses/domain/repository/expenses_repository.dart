import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';

import '../entities/expense.dart';

abstract class ExpensesRepository {
  Either<Failure, List<Expense>> getAllExpenses();
  Either<Failure, Expense> getExpenseById(String idExpense);
  Future<Either<Failure, Expense>> addExpense(Expense expense);
  Future<Either<Failure, Expense>> editExpense(Expense expense);
  Future<Either<Failure, Expense>> deleteExpense(Expense expense);
}
