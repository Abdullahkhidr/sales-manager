import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/message.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/features/clients_suppliers/data/repository/clients_repository_impl.dart';
import 'package:manager/features/clients_suppliers/data/repository/suppliers_repository_impl.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/clients_suppliers/domain/repository/clients_repository.dart';
import 'package:manager/features/clients_suppliers/domain/repository/suppliers_repository.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/clients/get_all_clients_usecase.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/suppliers/get_all_suppliers_usecase.dart';
import 'package:manager/features/navigation/navigation_pages.dart';
import 'package:manager/features/operations/data/datasources/select_date.dart';
import 'package:manager/features/operations/data/repository/operations_repository_impl.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/domain/repository/operations_repository.dart';
import 'package:manager/features/operations/domain/usecases/add_operation_usecase.dart';
import 'package:manager/features/operations/domain/usecases/delete_operation_usecase.dart';
import 'package:manager/features/operations/domain/usecases/edit_operation_usecase.dart';
import 'package:manager/features/products/data/repository/products_repository_impl.dart';
import 'package:manager/features/products/domain/entities/product.dart';
import 'package:manager/features/products/domain/usecases/get_all_products_usecase.dart';

import '../../../../products/domain/repository/products_repository.dart';

part 'editor_operation_event.dart';
part 'editor_operation_state.dart';

class EditorOperationBloc
    extends Bloc<EditorOperationEvent, EditorOperationState> {
  OperationsRepository operationsRepository = OperationsRepositoryImpl();
  ProductsRepository productsRepository = ProductsRepositoryImpl();
  ClientsRepository clientsRepository = ClientsRepositoryImpl();
  SuppliersRepository suppliersRepository = SuppliersRepositoryImpl();

  EditorOperationBloc() : super(EditorOperationInitial()) {
    on<EditorOperationChangeProductEvent>((event, emit) {
      product = event.product;
      emit(EditorOperationSelectedProductState());
    });
    on<EditorOperationChangeClientEvent>((event, emit) {
      client = event.client;
      emit(EditorOperationSelectedClientState());
    });
    on<EditorOperationChangeSupplierEvent>((event, emit) {
      supplier = event.supplier;
      emit(EditorOperationSelectedSupplierState());
    });
    on<EditorOperationChangeTypeOperationEvent>((event, emit) {
      if (idOperation == null) {
        typeOperation = event.typeOperation;
      }
      emit(EditorOperationChangedTypeOperationState());
    });
    on<EditorOperationPickDateEvent>((event, emit) async {
      _setDate(await pickDate(date));
      emit(EditorOperationChangedDateState());
    });
    on<EditorOperationInitEvent>((event, emit) {
      _init();
      emit(EditorOperationInitializedState());
    });

    on<EditorOperationSetOperationDateEvent>((event, emit) {
      _setDate(event.operation.date!);
      //  product = event.operation.idProduct,
      client = event.client;
      supplier = event.supplier;
      product = event.product;
      idOperation = event.operation.id;
      typeOperation = event.operation.typeOperation!;
      quantityController.text = event.operation.quantity.toString();
      amountController.text = event.operation.amount.toString();
      notesController.text = event.operation.notes ?? '';
      emit(EditorOperationInitializedState());
    });
  }

  _init() {
    Either<Failure, List<Product>> resultGetProducts =
        GetAllProductsUsecase(productsRepository).call();
    resultGetProducts.fold((l) {
      showMsg(l.message.toString());
    }, (resultProducts) {
      products.clear();
      products.addAll(resultProducts);
    });
    Either<Failure, List<Client>> resultGetClients =
        GetAllClientsUsecase(clientsRepository).call();
    resultGetClients.fold((l) => null, (resultClients) {
      clients = resultClients;
    });
    Either<Failure, List<Supplier>> resultGetSuppliers =
        GetAllSuppliersUsecase(suppliersRepository).call();
    resultGetSuppliers.fold((l) => null, (resultSuppliers) {
      suppliers = resultSuppliers;
    });
    on<EditorOperationAddEvent>((event, emit) async {
      if (event.operation.idProduct == null) {
        showMsg('msg_select_product'.tr());
      } else if (event.operation.amount == null) {
        showMsg('msg_type_amount'.tr());
      } else if (event.operation.quantity == null) {
        showMsg('msg_type_quantity'.tr());
      } else {
        Either<Failure, Operation> result =
            await AddOperationUsecase(operationsRepository)
                .call(event.operation);

        result.fold((l) {}, (resultOperation) {
          Nav.replaceAll(const NavigationPages(pageNumber: 0));
          showMsg('msg_success_add'.tr(args: ['operation'.tr()]));
        });
        // _getAllOperations(emit);
        emit(EditorOperationAddedState());
      }
    });
    on<EditorOperationEditEvent>((event, emit) async {
      if (operation.idProduct == null) {
        showMsg('msg_select_product'.tr());
      } else if (operation.amount == null) {
        showMsg('msg_type_amount'.tr());
      } else if (operation.quantity == null) {
        showMsg('msg_type_quantity'.tr());
      } else {
        Either<Failure, Operation> result =
            await EditOperationUsecase(operationsRepository).call(operation);
        result.fold((l) {}, (resultOperation) {
          Nav.replaceAll(const NavigationPages(pageNumber: 0));
          showMsg('msg_success_edit'.tr(args: ['operation'.tr()]));
        });
      }
    });
    on<EditorOperationDeleteEvent>((event, emit) async {
      Either<Failure, Operation> result =
          await DeleteOperationUsecase(operationsRepository)
              .call(event.operation);
      result.fold((l) {}, (resultOperation) {
        Nav.replaceAll(const NavigationPages(pageNumber: 0));
        showMsg('msg_success_delete'.tr(args: ['operation'.tr()]));
      });
      // _getAllOperations(emit);
      emit(EditorOperationDeletedState());
    });
  }

  _setDate(DateTime dateTime) => {
        date = dateTime,
        dateController.text = DateFormat.yMMMd().format(dateTime)
      };

  void get resetEditorData => {
        idOperation = null,
        _setDate(DateTime.now()),
        product = null,
        client = null,
        typeOperation = TypeOperation.Sale,
        quantityController.clear(),
        amountController.clear(),
        notesController.clear(),
      };

  Operation get operation {
    double amount = double.tryParse(amountController.text.trim()) ?? 0;
    if (amount >= 0 &&
        (typeOperation == TypeOperation.Buy ||
            typeOperation == TypeOperation.Refund)) {
      amount *= -1;
    }

    return Operation(
        id: idOperation,
        idProduct: product?.id,
        idSupplier: typeOperation == TypeOperation.Buy ? supplier?.id : null,
        idClient: typeOperation == TypeOperation.Buy ? null : client?.id,
        date: date,
        quantity: double.tryParse(quantityController.text.trim()) ?? 0,
        typeOperation: typeOperation,
        notes: notesController.text.trim(),
        amount: amount);
  }

  DateTime date = DateTime.now();

  Product? product;
  Client? client;
  Supplier? supplier;

  List<Product> products = [];
  List<Client> clients = [];
  List<Supplier> suppliers = [];

  String? idOperation;

  TypeOperation typeOperation = TypeOperation.Sale;

  TextEditingController dateController =
      TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));
  TextEditingController quantityController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();
}
