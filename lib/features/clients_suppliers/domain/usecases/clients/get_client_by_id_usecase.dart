import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';
import 'package:manager/features/clients_suppliers/domain/repository/clients_repository.dart';

class GetClientByIdUsecase {
  ClientsRepository clientsRepository;
  GetClientByIdUsecase(this.clientsRepository);
  Either<Failure, Client> call(String idClient) =>
      clientsRepository.getClientById(idClient);
}
