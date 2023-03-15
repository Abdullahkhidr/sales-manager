import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';

import '../entities/expense.dart';
import '../repository/expenses_repository.dart';

class EditExpenseUsecase {
  ExpensesRepository expensesRepository;
  EditExpenseUsecase(this.expensesRepository);
  Future<Either<Failure, Expense>> call(Expense expense) =>
      expensesRepository.editExpense(expense);
}
