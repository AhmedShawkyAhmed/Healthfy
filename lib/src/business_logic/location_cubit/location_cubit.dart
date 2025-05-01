import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/request/create_location_request.dart';
import 'package:healthify/src/data/request/update_location_request.dart';
import 'package:healthify/src/data/response/cities_reponse/cities_response.dart';
import 'package:healthify/src/data/response/countries_response/countries_response.dart';
import 'package:healthify/src/data/response/create_location_response.dart';
import 'package:healthify/src/data/response/delete_location_response.dart';
import 'package:healthify/src/data/response/get_all_location_response/get_all_location_response.dart';
import 'package:healthify/src/data/response/regions_response/regions_response.dart';
import 'package:healthify/src/data/response/update_location_response.dart';
import 'package:healthify/src/data/shared_models/city_model.dart';
import 'package:healthify/src/data/shared_models/country_model.dart';
import 'package:healthify/src/data/shared_models/location_model.dart';
import 'package:healthify/src/data/shared_models/region_model.dart';
import 'package:healthify/src/services/dio_helper.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  static LocationCubit get(BuildContext context) => BlocProvider.of(context);

  final _countries = <CountryModel>[];

  List<CountryModel> get countries => _countries;

  Future getCountries() async {
    try {
      emit(LocationGetCountriesLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epGetCities,
      );
      logSuccess("LocationCubit getCountries Response: $response");
      final model = CountriesResponse.fromJson(response.data);
      if (model.data?.countries != null) {
        _countries.clear();
        _countries.addAll(model.data!.countries!);
      }
      emit(LocationGetCountriesSuccessState());
    } on DioException catch (dioError) {
      logError(
          "MedicineTypeCubit getCountries Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(LocationGetCountriesFailureState());
    } catch (error) {
      logError("LocationCubit getCountries Error: $error");
      "Unknown Error!".toToastError();
      emit(LocationGetCountriesFailureState());
    }
  }

  final _cities = <CityModel>[];

  List<CityModel> get cities => _cities;

  Future getCities() async {
    try {
      emit(LocationGetCitiesLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epGetCities,
      );
      logSuccess("LocationCubit getCities Response: $response");
      final model = CitiesResponse.fromJson(response.data);
      if (model.data?.cities != null) {
        _cities.clear();
        _cities.addAll(model.data!.cities!);
      }
      emit(LocationGetCitiesSuccessState());
    } on DioException catch (dioError) {
      logError("LocationCubit getCities Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(LocationGetCitiesFailureState());
    } catch (error) {
      logError("LocationCubit getCities Error: $error");
      "Unknown Error!".toToastError();
      emit(LocationGetCitiesFailureState());
    }
  }

  final _regions = <RegionModel>[];

  List<RegionModel> get regions => _regions;

  Future getRegions(num cityId) async {
    try {
      emit(LocationGetRegionsLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epGetRegions,
        query: {
          "city_id": cityId,
        },
      );
      logSuccess("LocationCubit getRegions Response: $response");
      final model = RegionsResponse.fromJson(response.data);
      if (model.data?.regions != null) {
        _regions.clear();
        _regions.addAll(model.data!.regions!);
      }
      emit(LocationGetRegionsSuccessState());
    } on DioException catch (dioError) {
      logError("LocationCubit getRegions Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(LocationGetRegionsFailureState());
    } catch (error) {
      logError("LocationCubit getRegions Error: $error");
      "Unknown Error!".toToastError();
      emit(LocationGetRegionsFailureState());
    }
  }

  final _locations = <LocationModel>[];

  List<LocationModel> get locations => _locations;

  LocationModel? _currentLocation;

  LocationModel? get currentLocation => _currentLocation;

  void updateCurrentLocation(LocationModel model) {
    _currentLocation = model;
    emit(LocationCurrentLocationUpdateState());
  }

  Future getAllLocations() async {
    try {
      emit(LocationGetAllLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epLocations,
      );
      logSuccess("LocationCubit getAllLocations Response: $response");
      final model = GetAllLocationResponse.fromJson(response.data);
      if (model.data?.locations != null) {
        _locations.clear();
        _locations.addAll(model.data!.locations!);
        _currentLocation = _locations.isNotEmpty
            ? _locations.first
            : LocationModel(
                address: "Empty Location",
              );
      }
      emit(LocationGetAllSuccessState());
    } on DioException catch (dioError) {
      logError(
          "LocationCubit getAllLocations Response Error: ${dioError.response}");
      // (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
      //         "Server Error!")
      //     .toToastError();
      emit(LocationGetAllFailureState());
    } catch (error) {
      logError("LocationCubit getAllLocations Error: $error");
      "Unknown Error!".toToastError();
      emit(LocationGetAllFailureState());
    }
  }

  Future deleteLocation({required num id}) async {
    try {
      emit(LocationDeleteLocationLoadingState());
      final response = await DioHelper.deleteData(
        url: "${EndPoints.epLocations}/$id",
      );
      logSuccess("LocationCubit deleteLocation Response: $response");
      final model = DeleteLocationResponse.fromJson(response.data);
      if (model.message != null) {
        _locations.removeWhere((element) => element.id == id);
        model.message!.replaceAll("api.", "").toToastSuccess();
      }
      if (_currentLocation != null &&
          !_locations.any(
            (element) => element.id == _currentLocation!.id,
          )) {
        _currentLocation = null;
      }
      emit(LocationDeleteLocationSuccessState());
    } on DioException catch (dioError) {
      logError(
          "LocationCubit deleteLocation Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(LocationDeleteLocationFailureState());
    } catch (error) {
      logError("LocationCubit deleteLocation Error: $error");
      "Unknown Error!".toToastError();
      emit(LocationDeleteLocationFailureState());
    }
  }

  Future createLocation({required CreateLocationRequest request}) async {
    try {
      logSuccess(request.toJson().toString());
      emit(LocationCreateLocationLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epLocations,
        body: request.toJson(),
      );
      logSuccess("LocationCubit createLocation Response: $response");
      final model = CreateLocationResponse.fromJson(response.data);
      if (model.message != null) {
        final locationModel = LocationModel(
          id: _locations.isNotEmpty ? ((_locations.last.id ?? 0) + 1) : 1,
          address: request.address,
          address1: request.addressModel,
          latitude: request.lat,
          longitude: request.lon,
          type: request.type,
          createdAt: DateTime.timestamp().millisecondsSinceEpoch,
          createdAtStr: DateTime.timestamp().toString(),
        );
        _locations.add(locationModel);
        if (_currentLocation == null && _locations.length == 1) {
          _currentLocation = _locations.first;
        }
        model.message!.replaceAll("api.", "").toToastSuccess();
      }
      emit(LocationCreateLocationSuccessState());
    } on DioException catch (dioError) {
      logError(
          "LocationCubit createLocation Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(LocationCreateLocationFailureState());
    } catch (error) {
      logError("LocationCubit createLocation Error: $error");
      "Unknown Error!".toToastError();
      emit(LocationCreateLocationFailureState());
    }
  }

  Future updateLocation({required UpdateLocationRequest request}) async {
    try {
      emit(LocationUpdateLocationLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epLocations,
        body: request.toJson(),
      );
      logSuccess("LocationCubit updateLocation Response: $response");
      final model = UpdateLocationResponse.fromJson(response.data);
      if (model.message != null) {
        final index = _locations.indexWhere(
          (element) => element.id == request.id,
        );
        _locations[index] = LocationModel(
          id: request.id,
          address: request.address,
          address1: request.addressModel,
          latitude: request.lat,
          longitude: request.lon,
          type: request.type,
          createdAt: DateTime.timestamp().millisecondsSinceEpoch,
          createdAtStr: DateTime.timestamp().toString(),
        );
        if (_currentLocation != null) {
          _currentLocation = _locations.firstWhere(
            (element) => element.id == _currentLocation!.id,
          );
        }
        model.message!.replaceAll("api.", "").toToastSuccess();
      }
      emit(LocationUpdateLocationSuccessState());
    } on DioException catch (dioError) {
      logError(
          "LocationCubit updateLocation Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(LocationUpdateLocationFailureState());
    } catch (error) {
      logError("LocationCubit updateLocation Error: $error");
      "Unknown Error!".toToastError();
      emit(LocationUpdateLocationFailureState());
    }
  }
}
