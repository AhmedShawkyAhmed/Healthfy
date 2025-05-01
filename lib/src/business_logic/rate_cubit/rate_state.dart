part of 'rate_cubit.dart';

@immutable
abstract class RateState {}

class RateInitial extends RateState {}

class RateGetLoadingState extends RateState {}
class RateGetSuccessState extends RateState {}
class RateGetFailureState extends RateState {}

class RateAddLoadingState extends RateState {}
class RateAddSuccessState extends RateState {}
class RateAddFailureState extends RateState {}
