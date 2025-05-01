import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/request/add_favourite_request.dart';
import 'package:healthify/src/data/response/add_favourite_response.dart';
import 'package:healthify/src/data/response/get_my_favourites_response/get_my_favourites_response.dart';
import 'package:healthify/src/data/shared_models/favourite_model.dart';
import 'package:healthify/src/services/dio_helper.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  static FavouriteCubit get(BuildContext context) => BlocProvider.of(context);

  final _favourites = <FavouriteModel>[];

  List<FavouriteModel> get favourites => _favourites;

  Future getMyFavourites() async {
    try {
      emit(FavouriteGetLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epGetMyFav,
      );
      logSuccess("FavouriteCubit getMyFavourites Response: $response");
      final model = GetMyFavouritesResponse.fromJson(response.data);
      if (model.data?.favs != null) {
        _favourites.clear();
        _favourites.addAll(model.data!.favs!);
      }
      emit(FavouriteGetSuccessState());
    } on DioException catch (dioError) {
      logError(
          "FavouriteCubit getMyFavourites Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(FavouriteGetFailureState());
    } catch (error) {
      logError("FavouriteCubit getMyFavourites Error: $error");
      "Unknown Error!".toToastError();
      emit(FavouriteGetFailureState());
    }
  }

  Future addFavourite({required AddFavouriteRequest request}) async {
    try {
      emit(FavouriteAddLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epAddFav,
        body: request.toJson(),
      );
      logSuccess("FavouriteCubit addFavourite Response: $response");
      final model = AddOrRemoveFavouriteResponse.fromJson(response.data);
      if (model.message != null) {
        model.message!.replaceAll("api.", "").toToastSuccess();
      }
      getMyFavourites();
      emit(FavouriteAddSuccessState());
    } on DioException catch (dioError) {
      logError(
          "FavouriteCubit addFavourite Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(FavouriteAddFailureState());
    } catch (error) {
      logError("FavouriteCubit addFavourite Error: $error");
      "Unknown Error!".toToastError();
      emit(FavouriteAddFailureState());
    }
  }

  Future removeFavourite({required num id}) async {
    try {
      emit(FavouriteRemoveLoadingState());
      final response = await DioHelper.getData(
        url:
            "${EndPoints.epDeleteFav}/${_favourites.firstWhere((element) => element.favableId == id).id}",
      );
      logSuccess("FavouriteCubit removeFavourite Response: $response");
      final model = AddOrRemoveFavouriteResponse.fromJson(response.data);
      if (model.message != null) {
        model.message!.replaceAll("api.", "").toToastSuccess();
      }
      _favourites.removeWhere((element) => element.favableId == id);
      emit(FavouriteRemoveSuccessState());
    } on DioException catch (dioError) {
      logError(
          "FavouriteCubit removeFavourite Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(FavouriteRemoveFailureState());
    } catch (error) {
      logError("FavouriteCubit removeFavourite Error: $error");
      "Unknown Error!".toToastError();
      emit(FavouriteRemoveFailureState());
    }
  }
}
