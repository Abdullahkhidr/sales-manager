import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/core/services/hive_services.dart';
import 'package:manager/features/clients_suppliers/domain/entities/client.dart';

Either<Failure, List<Client>> hiveGetAllClients() {
  try {
    List<Client> clients =
        Hive.box(HiveBoxes.clients).toMap().values.cast<Client>().toList();
    return Right(clients);
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
