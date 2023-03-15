import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/expenses/domain/repository/expenses_repository.dart';

import '../entities/expense.dart';

class DeleteExpenseUsecase {
  ExpensesRepository expensesRepository;
  DeleteExpenseUsecase(this.expensesRepository);
  Future<Either<Failure, Expense>> call(Expense expense) =>
      expensesRepository.deleteExpense(expense);
}
