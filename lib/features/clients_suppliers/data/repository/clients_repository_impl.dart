import 'package:manager/core/services/url_launcher_services.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/clients/hive_add_client.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/clients/hive_delete_client.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/clients/hive_edit_client.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/clients/hive_get_all_clients.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/clients/hive_get_client_by_id.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:manager/features/clients_suppliers/domain/repository/clients_repository.dart';

class ClientsRepositoryImpl implements ClientsRepository {
  @override
  Future<Either<Failure, Client>> addClient(Client client) {
    return hiveAddClient(client);
  }

  @override
  Future<Either<Failure, Client>> deleteClient(Client client) {
    return hiveDeleteClient(client);
  }

  @override
  Future<Either<Failure, Client>> editClient(Client client) {
    return hiveEditClient(client);
  }

  @override
  Either<Failure, List<Client>> getAllClients() {
    return hiveGetAllClients();
  }

  @override
  Either<Failure, Client> getClientById(String idClient) {
    return hiveGetClientById(idClient);
  }

  @override
  Future<void> makeCall(String phone) {
    return UrlLauncherServices().makeCall(phone);
  }
}
