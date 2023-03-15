import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';

Either<Failure, List<Supplier>> hiveGetAllSuppliers() {
  try {
    List<Supplier> suppliers =
        Hive.box(HiveBoxes.suppliers).toMap().values.cast<Supplier>().toList();
    return Right(suppliers);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
