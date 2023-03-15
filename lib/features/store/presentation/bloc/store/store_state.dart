part of 'store_bloc.dart';

@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoadedProductsState extends StoreState {}

class StoreLoadedOperationsOfProductState extends StoreState {
  final List<Operation> operations;
  StoreLoadedOperationsOfProductState(this.operations);
}

class StoreResultSearchState extends StoreState {
  final List<Product> products;
  StoreResultSearchState(this.products);
}

class StoreSortedState extends StoreState {}
