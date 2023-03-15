part of 'editor_expense_bloc.dart';

@immutable
abstract class EditorExpenseEvent {}

class EditorExpenseSetDateEvent extends EditorExpenseEvent {
  final Expense expense;

  EditorExpenseSetDateEvent(this.expense);
}

class EditorExpenseAddEvent extends EditorExpenseEvent {}

class EditorExpensePickDateEvent extends EditorExpenseEvent {}

class EditorExpenseEditEvent extends EditorExpenseEvent {}

class EditorExpenseDeleteEvent extends EditorExpenseEvent {}
