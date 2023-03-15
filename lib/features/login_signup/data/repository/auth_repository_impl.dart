import 'package:manager/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:manager/features/login_signup/data/datasources/auth_methods/phone_auth.dart';
import 'package:manager/features/login_signup/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, String>> phoneAuth(String phoneNumber) {
    return phoneAuthentication(phoneNumber);
  }
}
