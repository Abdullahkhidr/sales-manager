import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/expenses/domain/entities/expense.dart';
import 'package:manager/features/expenses/domain/repository/expenses_repository.dart';

class AddExpenseUsecase {
  ExpensesRepository expensesRepository;
  AddExpenseUsecase(this.expensesRepository);
  Future<Either<Failure, Expense>> call(Expense expense) =>
      expensesRepository.addExpense(expense);
}
