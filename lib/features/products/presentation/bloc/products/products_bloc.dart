// ignore_for_file: constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/products/data/repository/products_repository_impl.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/domain/repository/products_repository.dart';
import 'package:manager/features/products/domain/usecases/get_all_products_usecase.dart';
import 'package:manager/features/products/presentation/widgets/filter_sort_widget.dart';
import 'package:manager/main.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsRepository productsRepository = ProductsRepositoryImpl();
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsGetAllEvent>((event, emit) {
      if (allProducts == null) {
        Either<Failure, List<Product>> result =
            GetAllProductsUsecase(productsRepository).call();
        result.fold((l) {}, (resultProducts) {
          allProducts = resultProducts;
          _sort(allProducts!);
          emit(ProductsLoadedAllState());
        });
      }
    });
    on<ProductsSearchEvent>((event, emit) {
      if (allProducts?.isNotEmpty ?? false) {
        List<Product> searchResult = allProducts!
            .where((element) =>
                element.name!
                    .toLowerCase()
                    .contains(event.search.toLowerCase()) ||
                element.description!
                    .toLowerCase()
                    .contains(event.search.toLowerCase()))
            .toList();
        _sort(searchResult);
        searchedProducts = searchResult;
        emit(ProductsResultSearchState(searchResult));
      } else {
        searchedProducts = [];
        emit(ProductsLoadedAllState());
      }
    });

    on<ProductsOpenSortFilterOptionsEvent>((event, emit) async {
      await showModalBottomSheet(
          context: navigatorKey.currentContext!,
          backgroundColor: colorScheme.background,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Sizes.borderRadius.topLeft,
                  topRight: Sizes.borderRadius.topRight)),
          builder: (context) => FilterSortWidget(
                currentTypeSort: sortBy,
                onChange: (v) {
                  sortBy = v;
                  Nav.back;
                  _sort(searchedProducts.isEmpty
                      ? allProducts ?? []
                      : searchedProducts);
                  emit(searchedProducts.isEmpty
                      ? ProductsLoadedAllState()
                      : ProductsResultSearchState(searchedProducts));
                },
              ));
    });
  }

  _sort(List<Product> list) {
    if (sortBy == SortBy.Newest) {
      list.sort((a, b) => b.addedDate!.compareTo(a.addedDate!));
    }
    if (sortBy == SortBy.Older) {
      list.sort((a, b) => a.addedDate!.compareTo(b.addedDate!));
    }
  }

  List<Product>? allProducts;
  List<Product> searchedProducts = [];

  SortBy sortBy = SortBy.Newest;
}

enum SortBy { Newest, Older }
