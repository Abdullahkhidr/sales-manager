import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/clients_suppliers/data/repository/clients_repository_impl.dart';
import 'package:manager/features/clients_suppliers/data/repository/suppliers_repository_impl.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/clients_suppliers/domain/repository/clients_repository.dart';
import 'package:manager/features/clients_suppliers/domain/repository/suppliers_repository.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/clients/get_client_by_id_usecase.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/suppliers/get_supplier_by_id_usecase.dart';
import 'package:manager/features/operations/data/repository/operations_repository_impl.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/domain/repository/operations_repository.dart';
import 'package:manager/features/operations/domain/usecases/get_all_operations_usecase.dart';
import 'package:manager/features/operations/presentation/widgets/filter_sort_widget.dart';
import 'package:manager/features/products/data/repository/products_repository_impl.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/domain/repository/products_repository.dart';
import 'package:manager/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:manager/main.dart';

part 'operations_event.dart';
part 'operations_state.dart';

class OperationsBloc extends Bloc<OperationsEvent, OperationsState> {
  OperationsRepository operationsRepository = OperationsRepositoryImpl();
  ClientsRepository clientsRepository = ClientsRepositoryImpl();
  SuppliersRepository suppliersRepository = SuppliersRepositoryImpl();
  ProductsRepository productsRepository = ProductsRepositoryImpl();

  OperationsBloc() : super(OperationsInitial()) {
    on<OperationsGetAllEvent>((event, emit) {
      if (operations == null) {
        _getAllOperations(emit);
        emit(OperationsLoadedAllState());
      }
    });

    on<OperationsGetClientOrSupplierEvent>((event, emit) {
      if (event.operation.idClient != null) {
        GetClientByIdUsecase(clientsRepository)
            .call(event.operation.idClient!)
            .fold((l) => null, (resultClient) => client = resultClient);
      } else if (event.operation.idSupplier != null) {
        GetSupplierByIdUsecase(suppliersRepository)
            .call(event.operation.idSupplier!)
            .fold((l) => null, (resultSupplier) => supplier = resultSupplier);
      }
      emit(OperationsLoadedClientOrSupplierOfOperationState());
    });
    on<OperationsGetProductEvent>((event, emit) {
      if (event.operation.idProduct != null) {
        GetProductByIdUsecase(productsRepository)
            .call(event.operation.idProduct!)
            .fold((l) => null, (resultProduct) => product = resultProduct);
      }
      emit(OperationsLoadedProductOfOperationState());
    });

    on<OperationsOpenSortFilterOptionsEvent>((event, emit) async {
      await showModalBottomSheet(
          context: navigatorKey.currentContext!,
          backgroundColor: colorScheme.background,
          builder: (context) => FilterSortOperationsWidget(
              currentTypeSort: typeSortOperations,
              onChange: (t) {
                typeSortOperations = t;
                Nav.back;
                _sort(emit);
                emit(OperationsChangeSortTypeState());
              }));
    });
    on<OperationsSearchEvent>((event, emit) {
      if (operations != null) {
        emit(OperationsResultSearchState(operations!
            .where((element) =>
                (element.notes ?? '')
                    .toLowerCase()
                    .contains(event.text.trim().toLowerCase()) ||
                element.amount
                    .toString()
                    .contains(event.text.trim().toLowerCase()) ||
                element.quantity
                    .toString()
                    .contains(event.text.trim().toLowerCase()))
            .toList()));
      }
    });
  }

  void _getAllOperations(Emitter emit) {
    Either<Failure, List<Operation>> result =
        GetAllOperationsUsecase(operationsRepository).call();
    result.fold((failure) {}, (resultOperations) {
      operations = resultOperations;
      _sort;
    });
  }

  void _sort(Emitter emit) {
    switch (typeSortOperations) {
      case TypeSortOperations.MostAmount:
        operations!.sort((a, b) => (a.amount ?? 0).compareTo(b.amount ?? 0));
        break;
      case TypeSortOperations.LeastAmount:
        operations!.sort((a, b) => (b.amount ?? 0).compareTo(b.amount ?? 0));
        break;
      case TypeSortOperations.Older:
        operations!.sort((a, b) => (a.date!).compareTo(b.date!));
        break;
      default:
        operations!.sort((a, b) => (b.date!).compareTo(a.date!));
    }
  }

  // Variables

  List<Operation>? operations;

  TypeSortOperations typeSortOperations = TypeSortOperations.Newest;

  Client? client;
  Supplier? supplier;
  Product? product;
}

// ignore: constant_identifier_names
enum TypeSortOperations { MostAmount, LeastAmount, Newest, Older }
