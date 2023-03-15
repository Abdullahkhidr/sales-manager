import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';

Future<Either<Failure, Client>> hiveEditClient(Client client) async {
  try {
    await Hive.box(HiveBoxes.clients).put(client.id, client);
    return Right(client);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
