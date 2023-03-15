part of 'editor_product_bloc.dart';

@immutable
abstract class EditorProductState {}

class EditorProductInitial extends EditorProductState {}

class EditorSetProductDataState extends EditorProductState {}

class EditorAddedProductState extends EditorProductState {}

class EditorDeletedProductState extends EditorProductState {}

class EditorEditedProductState extends EditorProductState {}

class EditorChangedImageProductState extends EditorProductState {}
