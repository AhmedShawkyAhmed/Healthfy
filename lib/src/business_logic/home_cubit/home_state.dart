part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeBottomIndexextends extends HomeState {}

class HomeGetAdsLoadingState extends HomeState {}
class HomeGetAdsSuccessState extends HomeState {}
class HomeGetAdsErrorState extends HomeState {}
