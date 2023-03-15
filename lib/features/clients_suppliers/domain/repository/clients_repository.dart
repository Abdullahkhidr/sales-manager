import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';

abstract class ClientsRepository {
  Either<Failure, List<Client>> getAllClients();
  Future<Either<Failure, Client>> addClient(Client client);
  Either<Failure, Client> getClientById(String idClient);
  Future<Either<Failure, Client>> editClient(Client client);
  Future<Either<Failure, Client>> deleteClient(Client client);
  Future<void> makeCall(String phone);
}
