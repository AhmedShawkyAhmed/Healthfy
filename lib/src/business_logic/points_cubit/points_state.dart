part of 'points_cubit.dart';

@immutable
abstract class PointsState {}

class PointsInitial extends PointsState {}

class GetPointsLoading extends PointsState {}
class GetPointsSuccess extends PointsState {}
class GetPointsError extends PointsState {}
