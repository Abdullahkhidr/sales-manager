// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoadedAllState extends ProductsState {}

class ProductsResultSearchState extends ProductsState {
  final List<Product> resultSearch;
  ProductsResultSearchState(this.resultSearch);
}

class ProductsChangeTypeFilterSortState extends ProductsState {}
