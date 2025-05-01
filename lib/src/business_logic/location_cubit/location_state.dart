part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationGetCountriesLoadingState extends LocationState{}
class LocationGetCountriesSuccessState extends LocationState{}
class LocationGetCountriesFailureState extends LocationState{}

class LocationGetCitiesLoadingState extends LocationState{}
class LocationGetCitiesSuccessState extends LocationState{}
class LocationGetCitiesFailureState extends LocationState{}

class LocationGetRegionsLoadingState extends LocationState{}
class LocationGetRegionsSuccessState extends LocationState{}
class LocationGetRegionsFailureState extends LocationState{}

class LocationGetAllLoadingState extends LocationState{}
class LocationGetAllSuccessState extends LocationState{}
class LocationGetAllFailureState extends LocationState{}

class LocationDeleteLocationLoadingState extends LocationState{}
class LocationDeleteLocationSuccessState extends LocationState{}
class LocationDeleteLocationFailureState extends LocationState{}

class LocationCreateLocationLoadingState extends LocationState{}
class LocationCreateLocationSuccessState extends LocationState{}
class LocationCreateLocationFailureState extends LocationState{}

class LocationUpdateLocationLoadingState extends LocationState{}
class LocationUpdateLocationSuccessState extends LocationState{}
class LocationUpdateLocationFailureState extends LocationState{}

class LocationCurrentLocationUpdateState extends LocationState{}
