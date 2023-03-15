import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';

abstract class SuppliersRepository {
  Either<Failure, List<Supplier>> getAllSuppliers();
  Future<Either<Failure, Supplier>> addSupplier(Supplier supplier);
  Either<Failure, Supplier> getSupplierById(String idSupplier);
  Future<Either<Failure, Supplier>> editSupplier(Supplier supplier);
  Future<Either<Failure, Supplier>> deleteSupplier(Supplier supplier);
  Future<void> makeCall(String phone);
}
