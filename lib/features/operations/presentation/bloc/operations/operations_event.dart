// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'operations_bloc.dart';

@immutable
abstract class OperationsEvent {}

class OperationsGetAllEvent extends OperationsEvent {}

class OperationsGetClientOrSupplierEvent extends OperationsEvent {
  final Operation operation;
  OperationsGetClientOrSupplierEvent(this.operation);
}

class OperationsGetProductEvent extends OperationsEvent {
  final Operation operation;
  OperationsGetProductEvent(this.operation);
}

class OperationsOpenSortFilterOptionsEvent extends OperationsEvent {}

class OperationsSearchEvent extends OperationsEvent {
  final String text;
  OperationsSearchEvent(this.text);
}
