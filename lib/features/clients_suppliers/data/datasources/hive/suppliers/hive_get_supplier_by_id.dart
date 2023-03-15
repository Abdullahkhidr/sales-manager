import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';

Either<Failure, Supplier> hiveGetSupplierById(String id) {
  try {
    Supplier supplier = Hive.box(HiveBoxes.suppliers).get(id) as Supplier;
    return Right(supplier);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
