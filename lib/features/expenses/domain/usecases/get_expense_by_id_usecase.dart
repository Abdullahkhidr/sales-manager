import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';

import '../entities/expense.dart';
import '../repository/expenses_repository.dart';

class GetExpenseByIdUsecase {
  ExpensesRepository expensesRepository;
  GetExpenseByIdUsecase(this.expensesRepository);
  Either<Failure, Expense> call(String idExpense) =>
      expensesRepository.getExpenseById(idExpense);
}
