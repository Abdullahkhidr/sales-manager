import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';

Either<Failure, Client> hiveGetClientById(String id) {
  try {
    Client client = Hive.box(HiveBoxes.clients).get(id) as Client;
    return Right(client);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
