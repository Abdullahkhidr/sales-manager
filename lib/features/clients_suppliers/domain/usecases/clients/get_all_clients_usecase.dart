import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/repository/clients_repository.dart';

class GetAllClientsUsecase {
  ClientsRepository clientsRepository;
  GetAllClientsUsecase(this.clientsRepository);
  Either<Failure, List<Client>> call() => clientsRepository.getAllClients();
}
