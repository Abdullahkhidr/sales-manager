part of 'suppliers_bloc.dart';

@immutable
abstract class SuppliersEvent {}

class SuppliersGetAllEvent extends SuppliersEvent {}

class SuppliersSearchEvent extends SuppliersEvent {
  final String textSearch;

  SuppliersSearchEvent(this.textSearch);
}

class EditorAddSupplierEvent extends SuppliersEvent {}

class EditorGetOperationsOfSupplier extends SuppliersEvent {
  final Supplier supplier;

  EditorGetOperationsOfSupplier(this.supplier);
}

class EditorEditSupplierEvent extends SuppliersEvent {}

class EditorDeleteSupplierEvent extends SuppliersEvent {}

class SuppliersMakeCallEvent extends SuppliersEvent {
  final Supplier supplier;
  SuppliersMakeCallEvent(this.supplier);
}
