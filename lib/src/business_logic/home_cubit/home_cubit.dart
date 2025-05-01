import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/models/ad_model.dart';
import 'package:healthify/src/data/resonses/get_ads_response_model.dart';
import 'package:healthify/src/services/dio_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  int bottomIndex = 0;

  void changeBottomIndex(int index) {
    bottomIndex = index;
    emit(ChangeBottomIndexextends());
  }

  HomeCubit() : super(HomeInitial());

  final ads = <AdModel>[];

  Future getAds() async {
    try {
      emit(HomeGetAdsLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epGetAds,
      );
      logSuccess("HomeCubit getAds Response: $response");
      final model = GetAdsResponseModel.fromJson(response.data);
      ads.clear();
      ads.addAll(model.ads);
      emit(HomeGetAdsSuccessState());
    } on DioException catch (dioError) {
      logError("HomeCubit getAds Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(HomeGetAdsErrorState());
    } catch (error) {
      logError("HomeCubit getAds Error: $error");
      "Unknown Error!".toToastError();
      emit(HomeGetAdsErrorState());
    }
  }
}
