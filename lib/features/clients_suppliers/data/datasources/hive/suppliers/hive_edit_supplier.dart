import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/clients_suppliers/domain/entities/supplier.dart';

Future<Either<Failure, Supplier>> hiveEditSupplier(Supplier supplier) async {
  try {
    await Hive.box(HiveBoxes.suppliers).put(supplier.id, supplier);
    return Right(supplier);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
