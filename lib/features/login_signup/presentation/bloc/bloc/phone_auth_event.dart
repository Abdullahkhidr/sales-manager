part of 'phone_auth_bloc.dart';

@immutable
abstract class PhoneAuthEvent {}

class PhoneAuthSendVerificationCodeEvent extends PhoneAuthEvent {
  final String phoneNumber;

  PhoneAuthSendVerificationCodeEvent(this.phoneNumber);
}
