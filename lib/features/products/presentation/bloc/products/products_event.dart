// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class ProductsGetAllEvent extends ProductsEvent {}

class ProductsSearchEvent extends ProductsEvent {
  final String search;
  ProductsSearchEvent(this.search);
}

class ProductsOpenSortFilterOptionsEvent extends ProductsEvent {}
