import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/expenses/domain/entities/expense.dart';

import '../repository/expenses_repository.dart';

class GetAllExpensesUsecase {
  ExpensesRepository expensesRepository;
  GetAllExpensesUsecase(this.expensesRepository);
  Either<Failure, List<Expense>> call() => expensesRepository.getAllExpenses();
}
