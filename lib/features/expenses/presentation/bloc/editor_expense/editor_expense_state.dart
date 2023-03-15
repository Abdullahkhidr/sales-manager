part of 'editor_expense_bloc.dart';

@immutable
abstract class EditorExpenseState {}

class EditorExpenseInitial extends EditorExpenseState {}

class EditorExpenseSetDataState extends EditorExpenseState {}

class EditorExpenseAddedState extends EditorExpenseState {}

class EditorExpenseEditedState extends EditorExpenseState {}

class EditorExpenseDeletedState extends EditorExpenseState {}

class EditorExpenseChangedDateState extends EditorExpenseState {}
