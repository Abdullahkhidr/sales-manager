import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> phoneAuth(String phoneNumber);
}
