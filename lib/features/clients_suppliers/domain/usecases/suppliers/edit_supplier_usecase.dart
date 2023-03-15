import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/clients_suppliers/domain/repository/suppliers_repository.dart';

class EditSupplierUsecase {
  SuppliersRepository suppliersRepository;
  EditSupplierUsecase(this.suppliersRepository);
  Future<Either<Failure, Supplier>> call(Supplier supplier) async =>
      await suppliersRepository.editSupplier(supplier);
}
