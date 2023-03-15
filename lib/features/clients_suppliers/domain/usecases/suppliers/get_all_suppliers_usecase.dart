import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/features/clients_suppliers/domain/repository/suppliers_repository.dart';

class GetAllSuppliersUsecase {
  SuppliersRepository suppliersRepository;
  GetAllSuppliersUsecase(this.suppliersRepository);
  Either<Failure, List<Supplier>> call() =>
      suppliersRepository.getAllSuppliers();
}
