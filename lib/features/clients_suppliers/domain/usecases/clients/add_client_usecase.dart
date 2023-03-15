import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/repository/clients_repository.dart';

class AddClientUsecase {
  ClientsRepository clientsRepository;
  AddClientUsecase(this.clientsRepository);
  Future<Either<Failure, Client>> call(Client client) async =>
      await clientsRepository.addClient(client);
}
