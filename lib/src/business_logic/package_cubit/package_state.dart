part of 'package_cubit.dart';

@immutable
abstract class PackageState {}

class PackageInitial extends PackageState {}

class GetPackageLoading extends PackageState {}
class GetPackageSuccess extends PackageState {}
class GetPackageError extends PackageState {}

class GetMyPackageLoading extends PackageState {}
class GetMyPackageSuccess extends PackageState {}
class GetMyPackageError extends PackageState {}

class SubscribePackageLoading extends PackageState {}
class SubscribePackageSuccess extends PackageState {}
class SubscribePackageError extends PackageState {}

class RenewSubscribeLoading extends PackageState {}
class RenewSubscribeSuccess extends PackageState {}
class RenewSubscribeError extends PackageState {}

class UpgradeSubscriptionLoading extends PackageState {}
class UpgradeSubscriptionSuccess extends PackageState {}
class UpgradeSubscriptionError extends PackageState {}
