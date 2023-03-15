// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/operations/data/repository/operations_repository_impl.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/domain/repository/operations_repository.dart';
import 'package:manager/features/operations/domain/usecases/get_all_operations_usecase.dart';
import 'package:manager/features/products/data/repository/products_repository_impl.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/domain/repository/products_repository.dart';
import 'package:manager/features/products/domain/usecases/get_all_products_usecase.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  ProductsRepository productsRepository = ProductsRepositoryImpl();
  OperationsRepository operationsRepository = OperationsRepositoryImpl();
  StoreBloc() : super(StoreInitial()) {
    on<StoreGetAllProduct>((event, emit) {
      if (products == null) {
        products = [];
        Either<Failure, List<Product>> _resGetProducts =
            GetAllProductsUsecase(productsRepository).call();
        // Either<Failure, List<Operation>> _resGetOperations =
        //     GetAllOperationsUsecase(operationsRepository).call();
        // List<Product> _resProducts = [];
        // List<Operation> _resOperations = [];
        _resGetProducts.fold((failure) => debugPrint(failure.message),
            (_products) => products = _products);
        // products = OperationsServices.getRemainingFromProducts(
        //     _resProducts, _resOperations);
        _sort();
        emit(StoreLoadedProductsState());
      }
    });
    on<StoreGetOperationsOfProductEvent>((event, emit) {
      Either<Failure, List<Operation>> _resGetOperations =
          GetAllOperationsUsecase(operationsRepository).call();
      _resGetOperations.fold((failure) {}, (_operations) {
        emit(StoreLoadedOperationsOfProductState(_operations
            .where((element) => element.idProduct == event.product.id)
            .toList()));
      });
    });
    on<StoreSearchEvent>((event, emit) {
      if (event.text.trim().isEmpty) {
        emit(StoreLoadedProductsState());
      } else {
        List<Product> _searchProducts = products
                ?.where((element) =>
                    element.name!
                        .toLowerCase()
                        .trim()
                        .contains(event.text.trim().toLowerCase()) ||
                    element.description!
                        .toLowerCase()
                        .trim()
                        .contains(event.text.trim().toLowerCase()))
                .toList() ??
            [];
        emit(StoreResultSearchState(_searchProducts));
      }
    });
    on<StoreSortEvent>((event, emit) {
      sortType = event.typeSort;
      _sort();
      emit(StoreSortedState());
    });
  }

  _sort() {
    switch (sortType) {
      case SortTypeStoreProduct.mostQuantitative:
        products
            ?.sort((a, b) => (b.remaining ?? 0).compareTo(a.remaining ?? 0));
        break;
      default:
        products
            ?.sort((a, b) => (a.remaining ?? 0).compareTo(b.remaining ?? 0));
    }
  }

  List<Product>? products;

  SortTypeStoreProduct sortType = SortTypeStoreProduct.mostQuantitative;
}

enum SortTypeStoreProduct { mostQuantitative, leastQuantity }
