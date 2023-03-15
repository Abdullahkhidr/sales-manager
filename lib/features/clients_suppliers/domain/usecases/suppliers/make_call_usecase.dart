import 'package:manager/features/clients_suppliers/domain/repository/suppliers_repository.dart';

class MakeCallSupplierUsecase {
  SuppliersRepository suppliersRepository;
  MakeCallSupplierUsecase(this.suppliersRepository);
  Future<void> call(String phone) => suppliersRepository.makeCall(phone);
}
