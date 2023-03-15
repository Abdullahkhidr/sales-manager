import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/features/clients_suppliers/data/repository/clients_repository_impl.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/repository/clients_repository.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/clients/add_client_usecase.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/clients/delete_client_usecase.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/clients/edit_client_usecase.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/clients/get_all_clients_usecase.dart';
import 'package:manager/features/clients_suppliers/domain/usecases/clients/make_call_usecase.dart';
import 'package:manager/features/navigation/navigation_pages.dart';
import 'package:manager/features/operations/data/repository/operations_repository_impl.dart';
import 'package:manager/features/operations/domain/entities/operation.dart';
import 'package:manager/features/operations/domain/repository/operations_repository.dart';
import 'package:manager/features/operations/domain/usecases/get_all_operations_usecase.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  ClientsRepository clientsRepository = ClientsRepositoryImpl();
  OperationsRepository operationsRepository = OperationsRepositoryImpl();
  ClientsBloc() : super(ClientsInitial()) {
    on<ClientsGetAllEvent>((event, emit) {
      if (clients == null) {
        _getAllClients;
        emit(ClientsLoadedState());
      }
    });
    on<EditorAddClientEvent>((event, emit) async {
      Either<Failure, Client> result =
          await AddClientUsecase(clientsRepository).call(createModel);
      result.fold((failure) {}, (success) {
        Nav.replaceAll(const NavigationPages(pageNumber: 2));
        resetDate;
        _getAllClients;
        emit(ClientsLoadedState());
      });
    });
    on<EditorEditClientEvent>((event, emit) async {
      Either<Failure, Client> result =
          await EditClientUsecase(clientsRepository).call(createModel);
      result.fold((failure) {}, (success) {
        Nav.replaceAll(const NavigationPages(pageNumber: 2));

        resetDate;
        _getAllClients;
        emit(ClientsLoadedState());
      });
    });
    on<EditorDeleteClientEvent>((event, emit) async {
      Either<Failure, Client> result =
          await DeleteClientUsecase(clientsRepository).call(createModel);
      result.fold((failure) {}, (success) {
        Nav.replaceAll(const NavigationPages(pageNumber: 2));

        resetDate;
        _getAllClients;
        emit(ClientsLoadedState());
      });
    });
    on<ClientsSearchEvent>((event, emit) {
      if (clients != null) {
        if (event.textSearch.trim().isEmpty) {
          resultSearch.clear();
          emit(ClientsLoadedState());
        }
        resultSearch = clients!
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
        emit(ClientsResultSearchState());
      }
    });
    on<ClientsGetOperationsOfClient>((event, emit) {
      Either<Failure, List<Operation>> operations =
          GetAllOperationsUsecase(operationsRepository).call();
      operations.fold(
          (l) => null,
          (r) => operationsOfClient = r
              .where((element) => element.idClient == event.client.id)
              .toList());
    });
    on<ClientsMakeCallEvent>((event, emit) async {
      await MakeCallClientUsecase(clientsRepository)
          .call(event.client.phone ?? '');
    });
  }

  void setDate(Client client) {
    id = client.id;
    salesAmount = client.salesAmount ?? 0;
    nameController.text = client.name!;
    phoneController.text = client.phone!;
    companyController.text = client.company!;
    notesController.text = client.notes!;
  }

  void get _getAllClients => {
        GetAllClientsUsecase(clientsRepository).call().fold((failure) {
          debugPrint(failure.message);
        }, (resultClients) {
          clients = resultClients;
          clients!.sort((a, b) => b.salesAmount!.compareTo(a.salesAmount!));
        })
      };

  Client get createModel => Client(
      id: id,
      salesAmount: salesAmount,
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      company: companyController.text.trim(),
      notes: notesController.text.trim());

  void get resetDate => {
        id = null,
        salesAmount = 0,
        nameController.text = '',
        phoneController.text = '',
        companyController.text = '',
        notesController.text = ''
      };

  List<Client>? clients;
  List<Client> resultSearch = [];

  List<Operation> operationsOfClient = [];

  String? id;
  double salesAmount = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController notesController = TextEditingController();
}
