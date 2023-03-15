part of 'operations_bloc.dart';

@immutable
abstract class OperationsState {}

class OperationsInitial extends OperationsState {}

class OperationsLoadedAllState extends OperationsState {}

class OperationsLoadedProductOfOperationState extends OperationsState {}

class OperationsLoadedClientOrSupplierOfOperationState
    extends OperationsState {}

class OperationsChangeSortTypeState extends OperationsState {}

class OperationsResultSearchState extends OperationsState {
  final List<Operation> operations;
  OperationsResultSearchState(this.operations);
}
