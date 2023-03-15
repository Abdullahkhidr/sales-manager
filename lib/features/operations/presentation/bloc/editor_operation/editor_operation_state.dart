part of 'editor_operation_bloc.dart';

@immutable
abstract class EditorOperationState {}

class EditorOperationInitial extends EditorOperationState {}

class EditorOperationAddedState extends EditorOperationState {}

class EditorOperationEditedState extends EditorOperationState {}

class EditorOperationDeletedState extends EditorOperationState {}

class EditorOperationInitializedState extends EditorOperationState {}

class EditorOperationChangedDateState extends EditorOperationState {}

class EditorOperationSelectedProductState extends EditorOperationState {}

class EditorOperationSelectedClientState extends EditorOperationState {}

class EditorOperationSelectedSupplierState extends EditorOperationState {}

class EditorOperationChangedTypeOperationState extends EditorOperationState {}
