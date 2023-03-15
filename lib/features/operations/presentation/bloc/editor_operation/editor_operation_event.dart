part of 'editor_operation_bloc.dart';

@immutable
abstract class EditorOperationEvent {}

class EditorOperationInitEvent extends EditorOperationEvent {}

class EditorOperationAddEvent extends EditorOperationEvent {
  final Operation operation;
  EditorOperationAddEvent(this.operation);
}

class EditorOperationEditEvent extends EditorOperationEvent {
  final Operation operation;
  EditorOperationEditEvent(this.operation);
}

class EditorOperationDeleteEvent extends EditorOperationEvent {
  final Operation operation;
  EditorOperationDeleteEvent(this.operation);
}

class EditorOperationPickDateEvent extends EditorOperationEvent {}

class EditorOperationChangeTypeOperationEvent extends EditorOperationEvent {
  final TypeOperation typeOperation;

  EditorOperationChangeTypeOperationEvent(this.typeOperation);
}

class EditorOperationSetOperationDateEvent extends EditorOperationEvent {
  final Operation operation;
  final Product? product;
  final Supplier? supplier;
  final Client? client;

  EditorOperationSetOperationDateEvent(
      this.operation, this.product, this.supplier, this.client);
}

class EditorOperationChangeProductEvent extends EditorOperationEvent {
  final Product product;

  EditorOperationChangeProductEvent(this.product);
}

class EditorOperationChangeClientEvent extends EditorOperationEvent {
  final Client client;

  EditorOperationChangeClientEvent(this.client);
}

class EditorOperationChangeSupplierEvent extends EditorOperationEvent {
  final Supplier supplier;

  EditorOperationChangeSupplierEvent(this.supplier);
}
