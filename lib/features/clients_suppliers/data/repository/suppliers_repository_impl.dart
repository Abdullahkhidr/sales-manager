import 'package:manager/core/services/url_launcher_services.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/suppliers/hive_add_supplier.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/suppliers/hive_delete_supplier.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/suppliers/hive_edit_supplier.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/suppliers/hive_get_all_supplier.dart';
import 'package:manager/features/clients_suppliers/data/datasources/hive/suppliers/hive_get_supplier_by_id.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:manager/features/clients_suppliers/domain/repository/suppliers_repository.dart';

class SuppliersRepositoryImpl implements SuppliersRepository {
  @override
  Future<Either<Failure, Supplier>> addSupplier(Supplier supplier) {
    return hiveAddSupplier(supplier);
  }

  @override
  Future<Either<Failure, Supplier>> deleteSupplier(Supplier supplier) {
    return hiveDeleteSupplier(supplier);
  }

  @override
  Future<Either<Failure, Supplier>> editSupplier(Supplier supplier) {
    return hiveEditSupplier(supplier);
  }

  @override
  Either<Failure, List<Supplier>> getAllSuppliers() {
    return hiveGetAllSuppliers();
  }

  @override
  Either<Failure, Supplier> getSupplierById(String idSupplier) {
    return hiveGetSupplierById(idSupplier);
  }

  @override
  Future<void> makeCall(String phone) {
    return UrlLauncherServices().makeCall(phone);
  }
}
