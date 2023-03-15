import 'package:dartz/dartz.dart';
import 'package:manager/core/errors/failures.dart';
import 'package:manager/features/login_signup/domain/repository/auth_repository.dart';

class PhoneAuthUsecase {
  AuthRepository authRepository;
  PhoneAuthUsecase(this.authRepository);

  Future<Either<Failure, String>> call(String phoneNumber) =>
      authRepository.phoneAuth(phoneNumber);
}
