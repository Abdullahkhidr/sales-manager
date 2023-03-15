import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/clients_suppliers/domain/repository/suppliers_repository.dart';

class GetSupplierByIdUsecase {
  SuppliersRepository suppliersRepository;
  GetSupplierByIdUsecase(this.suppliersRepository);
  Either<Failure, Supplier> call(String idSupplier) =>
      suppliersRepository.getSupplierById(idSupplier);
}
