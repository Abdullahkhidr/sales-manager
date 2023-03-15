import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/expenses/data/repository/expenses_repository_impl.dart';
import 'package:manager/features/expenses/domain/entities/expense.dart';
import 'package:manager/features/expenses/domain/repository/expenses_repository.dart';
import 'package:manager/features/expenses/domain/usecases/get_all_expenses_usecase.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  ExpensesRepository expensesRepository = ExpensesRepositoryImpl();
  ExpensesBloc() : super(ExpensesInitial()) {
    on<ExpensesGetAllEvent>((event, emit) {
      Either<Failure, List<Expense>> result =
          GetAllExpensesUsecase(expensesRepository).call();
      result.fold((l) => debugPrint(l.message), (success) {
        expenses = success;
        expenses!.sort((a, b) => b.date!.compareTo(a.date!));
        emit(ExpensesLoadedAllState());
      });
    });
  }

  List<Expense>? expenses;
}
