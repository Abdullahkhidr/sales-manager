// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'editor_product_bloc.dart';

@immutable
abstract class EditorProductEvent {}

class EditorSetProductDataEvent extends EditorProductEvent {
  final Product product;
  EditorSetProductDataEvent(this.product);
}

class EditorChangeImageProductEvent extends EditorProductEvent {}

class EditorAddProductEvent extends EditorProductEvent {}

class EditorDeleteProductEvent extends EditorProductEvent {
  final Product product;
  EditorDeleteProductEvent(this.product);
}

class EditorEditProductEvent extends EditorProductEvent {
  final Product product;
  EditorEditProductEvent(this.product);
}
