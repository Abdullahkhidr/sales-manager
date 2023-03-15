import 'package:manager/features/clients_suppliers/domain/repository/clients_repository.dart';

class MakeCallClientUsecase {
  ClientsRepository clientsRepository;
  MakeCallClientUsecase(this.clientsRepository);
  Future<void> call(String phone) => clientsRepository.makeCall(phone);
}
