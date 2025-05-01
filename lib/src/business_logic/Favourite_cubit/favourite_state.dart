part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteGetLoadingState extends FavouriteState {}
class FavouriteGetSuccessState extends FavouriteState {}
class FavouriteGetFailureState extends FavouriteState {}

class FavouriteAddLoadingState extends FavouriteState {}
class FavouriteAddSuccessState extends FavouriteState {}
class FavouriteAddFailureState extends FavouriteState {}

class FavouriteRemoveLoadingState extends FavouriteState {}
class FavouriteRemoveSuccessState extends FavouriteState {}
class FavouriteRemoveFailureState extends FavouriteState {}
