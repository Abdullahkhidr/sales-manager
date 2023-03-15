part of 'suppliers_bloc.dart';

@immutable
abstract class SuppliersState {}

class SuppliersInitial extends SuppliersState {}

class SuppliersLoadedState extends SuppliersState {}

class SuppliersResultSearchState extends SuppliersState {}

class SuppliersLoadedDetailsDataState extends SuppliersState {}
