part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthVerifyPhoneFirebaseLoadingState extends AuthState{}
class AuthVerifyPhoneFirebaseSuccessState extends AuthState{}
class AuthVerifyPhoneFirebaseFailureState extends AuthState{}

class AuthVerifyOTPFirebaseLoadingState extends AuthState{}
class AuthVerifyOTPFirebaseSuccessState extends AuthState{}
class AuthVerifyOTPFirebaseFailureState extends AuthState{}

class AuthVerifyPhoneLoadingState extends AuthState{}
class AuthVerifyPhoneSuccessState extends AuthState{
  final String code;

  AuthVerifyPhoneSuccessState(this.code);
}
class AuthVerifyPhoneFailureState extends AuthState{}

class AuthVerifyOtpLoadingState extends AuthState{}
class AuthVerifyOtpSuccessState extends AuthState{
  final bool isUser;

  AuthVerifyOtpSuccessState({required this.isUser});
}
class AuthVerifyOtpFailureState extends AuthState{}

class AuthRegisterLoadingState extends AuthState{}
class AuthRegisterSuccessState extends AuthState{}
class AuthRegisterFailureState extends AuthState{}

class AuthGetProfileLoadingState extends AuthState{}
class AuthGetProfileSuccessState extends AuthState{}
class AuthGetProfileFailureState extends AuthState{}

class AuthUpdateProfileLoadingState extends AuthState{}
class AuthUpdateProfileSuccessState extends AuthState{}
class AuthUpdateProfileFailureState extends AuthState{}

class AuthLogoutLoadingState extends AuthState{}
class AuthLogoutSuccessState extends AuthState{}
class AuthLogoutFailureState extends AuthState{}

class AuthGetUserByIdLoadingState extends AuthState{}
class AuthGetUserByIdSuccessState extends AuthState{}
class AuthGetUserByIdFailureState extends AuthState{}

class AuthMoveToTrashLoadingState extends AuthState{}
class AuthMoveToTrashSuccessState extends AuthState{}
class AuthMoveToTrashFailureState extends AuthState{}