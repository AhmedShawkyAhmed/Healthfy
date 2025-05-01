part of 'app_content_cubit.dart';

@immutable
abstract class AppContentState {}

class AppContentInitial extends AppContentState {}

class GetPrivacyLoading extends AppContentState {}
class GetPrivacySuccess extends AppContentState {}
class GetPrivacyError extends AppContentState {}

class GetPhoneLoading extends AppContentState {}
class GetPhoneSuccess extends AppContentState {}
class GetPhoneError extends AppContentState {}

class GetContactUsLoading extends AppContentState {}
class GetContactUsSuccess extends AppContentState {}
class GetContactUsError extends AppContentState {}
