part of 'store_bloc.dart';

@immutable
abstract class StoreEvent {}

class StoreGetAllProduct extends StoreEvent {}

class StoreGetOperationsOfProductEvent extends StoreEvent {
  final Product product;
  StoreGetOperationsOfProductEvent(this.product);
}

class StoreSearchEvent extends StoreEvent {
  final String text;
  StoreSearchEvent(this.text);
}

class StoreSortEvent extends StoreEvent {
  final SortTypeStoreProduct typeSort;
  StoreSortEvent(this.typeSort);
}
