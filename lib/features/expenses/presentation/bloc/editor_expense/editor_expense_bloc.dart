import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/features/expenses/data/repository/expenses_repository_impl.dart';
import 'package:manager/features/expenses/domain/entities/expense.dart';
import 'package:manager/features/expenses/domain/usecases/add_expense_usecase.dart';
import 'package:manager/features/expenses/domain/usecases/delete_expense_usecase.dart';
import 'package:manager/features/expenses/domain/usecases/edit_expense_usecase.dart';
import 'package:manager/features/navigation/navigation_pages.dart';
import 'package:manager/features/operations/data/datasources/select_date.dart';

import '../../../domain/repository/expenses_repository.dart';

part 'editor_expense_event.dart';
part 'editor_expense_state.dart';

class EditorExpenseBloc extends Bloc<EditorExpenseEvent, EditorExpenseState> {
  ExpensesRepository expensesRepository = ExpensesRepositoryImpl();
  EditorExpenseBloc() : super(EditorExpenseInitial()) {
    on<EditorExpenseSetDateEvent>((event, emit) {
      _setDate(event.expense.date ?? DateTime.now());
      id = event.expense.id;
      titleController.text = event.expense.title ?? '';
      costController.text = (event.expense.cost ?? 0).toString();
      detailsController.text = event.expense.details ?? '';
      emit(EditorExpenseSetDataState());
    });

    on<EditorExpenseAddEvent>((event, emit) async {
      Either<Failure, Expense> result =
          await AddExpenseUsecase(expensesRepository).call(expense);

      result.fold((l) => debugPrint(l.message), (success) {
        Nav.back;
        Nav.replace(const NavigationPages(pageNumber: 1));
      });
    });
    on<EditorExpenseEditEvent>((event, emit) async {
      Either<Failure, Expense> result =
          await EditExpenseUsecase(expensesRepository).call(expense);

      result.fold((l) => debugPrint(l.message), (success) {
        Nav.back;
        Nav.replace(const NavigationPages(pageNumber: 1));
      });
    });
    on<EditorExpenseDeleteEvent>((event, emit) async {
      Either<Failure, Expense> result =
          await DeleteExpenseUsecase(expensesRepository).call(expense);

      result.fold((l) => null, (success) {
        Nav.back;
        Nav.replace(const NavigationPages(pageNumber: 1));
      });
    });
    on<EditorExpensePickDateEvent>((event, emit) async {
      _setDate(await pickDate(date));
      emit(EditorExpenseChangedDateState());
    });
  }

  Expense get expense {
    double cost = double.tryParse(costController.text.trim()) ?? 0;
    if (cost > 0) cost *= -1;
    return Expense(
        id: id,
        title: titleController.text.trim(),
        date: date,
        cost: cost,
        details: detailsController.text.trim());
  }

  String? id;

  // ignore: no_leading_underscores_for_local_identifiers
  _setDate(DateTime _date) {
    date = _date;
    dateTimeController.text = DateFormat.yMMMMd().format(date);
  }

  DateTime date = DateTime.now();

  TextEditingController titleController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController get dateTimeController =>
      TextEditingController(text: DateFormat.yMMMMd().format(date));
}
