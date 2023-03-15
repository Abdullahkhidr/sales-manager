import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/features/clients_suppliers/data/repository/suppliers_repository_impl.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/clients_suppliers/domain/repository/suppliers_repository.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/suppliers/add_supplier_usecase.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/suppliers/delete_supplier_usecase.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/suppliers/edit_supplier_usecase.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/suppliers/get_all_suppliers_usecase.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/suppliers/make_call_usecase.dart';
import 'package:manager/features/navigation/navigation_pages.dart';
import 'package:manager/features/operations/data/repository/operations_repository_impl.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/domain/repository/operations_repository.dart';
import 'package:manager/features/operations/domain/usecases/get_all_operations_usecase.dart';

part 'suppliers_event.dart';
part 'suppliers_state.dart';

class SuppliersBloc extends Bloc<SuppliersEvent, SuppliersState> {
  SuppliersRepository suppliersRepository = SuppliersRepositoryImpl();
  OperationsRepository operationsRepository = OperationsRepositoryImpl();

  SuppliersBloc() : super(SuppliersInitial()) {
    on<SuppliersGetAllEvent>((event, emit) {
      if (suppliers == null) {
        _getAllSuppliers;
        emit(SuppliersLoadedState());
      }
    });
    on<EditorAddSupplierEvent>((event, emit) async {
      Either<Failure, Supplier> result =
          await AddSupplierUsecase(suppliersRepository).call(createModel);
      result.fold((failure) {}, (success) {
        Nav.replaceAll(const NavigationPages(pageNumber: 2));
        resetDate;
        _getAllSuppliers;
        emit(SuppliersLoadedState());
      });
    });
    on<EditorEditSupplierEvent>((event, emit) async {
      Either<Failure, Supplier> result =
          await EditSupplierUsecase(suppliersRepository).call(createModel);
      result.fold((failure) {}, (success) {
        Nav.replaceAll(const NavigationPages(pageNumber: 3));

        resetDate;
        _getAllSuppliers;
        emit(SuppliersLoadedState());
      });
    });
    on<EditorDeleteSupplierEvent>((event, emit) async {
      Either<Failure, Supplier> result =
          await DeleteSupplierUsecase(suppliersRepository).call(createModel);
      result.fold((failure) {}, (success) {
        Nav.replaceAll(const NavigationPages(pageNumber: 2));

        resetDate;
        _getAllSuppliers;
        emit(SuppliersLoadedState());
      });
    });
    on<SuppliersSearchEvent>((event, emit) {
      if (suppliers != null) {
        if (event.textSearch.trim().isEmpty) {
          resultSearch.clear();
          emit(SuppliersLoadedState());
        }
        resultSearch = suppliers!
            .where((element) =>
                element.name!
                    .toLowerCase()
                    .contains(event.textSearch.toLowerCase()) ||
                element.phone!
                    .toLowerCase()
                    .contains(event.textSearch.toLowerCase()) ||
                element.company!
                    .toLowerCase()
                    .contains(event.textSearch.toLowerCase()) ||
                element.notes!
                    .toLowerCase()
                    .contains(event.textSearch.toLowerCase()))
            .toList();
        emit(SuppliersResultSearchState());
      }
    });

    on<EditorGetOperationsOfSupplier>((event, emit) {
      if (operationsOfSupplier == null) {
        operationsOfSupplier = [];
        Either<Failure, List<Operation>> operations =
            GetAllOperationsUsecase(operationsRepository).call();
        operations.fold(
            (l) => null,
            (r) => operationsOfSupplier = r
                .where((element) => element.idSupplier == event.supplier.id)
                .toList());
        emit(SuppliersLoadedDetailsDataState());
      }
    });
    on<SuppliersMakeCallEvent>((event, emit) async {
      await MakeCallSupplierUsecase(suppliersRepository)
          .call(event.supplier.phone ?? '');
    });
  }
  void setDate(Supplier supplier) {
    id = supplier.id;
    purchasesAmount = supplier.purchasesAmount ?? 0;
    nameController.text = supplier.name!;
    phoneController.text = supplier.phone!;
    companyController.text = supplier.company!;
    notesController.text = supplier.notes!;
  }

  void get _getAllSuppliers => {
        GetAllSuppliersUsecase(suppliersRepository).call().fold((failure) {
          debugPrint(failure.message);
        }, (resultSuppliers) {
          suppliers = resultSuppliers;
          suppliers!
              .sort((a, b) => a.purchasesAmount!.compareTo(b.purchasesAmount!));
        })
      };

  Supplier get createModel => Supplier(
      id: id,
      purchasesAmount: purchasesAmount,
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      company: companyController.text.trim(),
      notes: notesController.text.trim());

  void get resetDate => {
        id = null,
        purchasesAmount = 0,
        nameController.text = '',
        phoneController.text = '',
        companyController.text = '',
        notesController.text = '',
        operationsOfSupplier = null
      };

  List<Supplier>? suppliers;
  List<Supplier> resultSearch = [];

  List<Operation>? operationsOfSupplier;

  String? id;
  double purchasesAmount = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController notesController = TextEditingController();
}
