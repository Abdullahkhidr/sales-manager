import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manager/core/errors/failures.dart';

Future<Either<Failure, String>> phoneAuthentication(String phoneNumber) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';
  String verificationId = '';
  await auth.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      codeSent: (String _verificationId, int? forceResendingToken) {
        verificationId = _verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationFailed: (FirebaseAuthException error) {
        errorMessage = error.message ?? '';
      });

  if (errorMessage.isNotEmpty) return Left(UnexpectedFailure(errorMessage));
  return Right(verificationId);
}
