part of 'expenses_bloc.dart';

@immutable
abstract class ExpensesState {}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoadedAllState extends ExpensesState {}
