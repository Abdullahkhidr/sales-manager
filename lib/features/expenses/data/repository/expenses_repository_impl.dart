import 'package:manager/features/expenses/domain/entities/expense.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:manager/features/expenses/domain/repository/expenses_repository.dart';

import '../datasources/hive/hive_add_expense.dart';
import '../datasources/hive/hive_delete_expense.dart';
import '../datasources/hive/hive_edit_expense.dart';
import '../datasources/hive/hive_get_all_expenses.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  @override
  Future<Either<Failure, Expense>> addExpense(Expense expense) {
    return hiveAddExpense(expense);
  }

  @override
  Future<Either<Failure, Expense>> deleteExpense(Expense expense) {
    return hiveDeleteExpense(expense);
  }

  @override
  Future<Either<Failure, Expense>> editExpense(Expense expense) {
    return hiveEditExpense(expense);
  }

  @override
  Either<Failure, List<Expense>> getAllExpenses() {
    return hiveGetAllExpenses();
  }

  @override
  Either<Failure, Expense> getExpenseById(String idExpense) {
    throw UnimplementedError();
  }
}
