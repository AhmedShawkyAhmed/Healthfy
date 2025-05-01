import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/request/add_rate_request.dart';
import 'package:healthify/src/data/response/add_rate_response.dart';
import 'package:healthify/src/data/response/get_my_rates_response/get_my_rates_response.dart';
import 'package:healthify/src/data/shared_models/rate_model.dart';
import 'package:healthify/src/services/dio_helper.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  RateCubit() : super(RateInitial());

  static RateCubit get(BuildContext context) => BlocProvider.of(context);

  final _rates = <RateModel>[];

  List<RateModel> get rates => _rates;

  Future getMyRates() async {
    try {
      emit(RateGetLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epGetMyRate,
      );
      logSuccess("RateCubit getMyRates Response: $response");
      final model = GetMyRatesResponse.fromJson(response.data);
      if (model.data?.rates != null) {
        _rates.clear();
        _rates.addAll(model.data!.rates!);
      }
      emit(RateGetSuccessState());
    } on DioException catch (dioError) {
      logError("RateCubit getMyRates Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(RateGetFailureState());
    } catch (error) {
      logError("RateCubit getMyRates Error: $error");
      "Unknown Error!".toToastError();
      emit(RateGetFailureState());
    }
  }

  Future addRate({required AddRateRequest request}) async {
    try {
      emit(RateAddLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epAddRate,
        body: request.toJson(),
      );
      logSuccess("RateCubit addRate Response: $response");
      final model = AddRateResponse.fromJson(response.data);
      if (model.message != null) {
        model.message!.replaceAll("api.", "").toToastSuccess();
      }
      emit(RateAddSuccessState());
    } on DioException catch (dioError) {
      logError("RateCubit addRate Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(RateAddFailureState());
    } catch (error) {
      logError("RateCubit addRate Error: $error");
      "Unknown Error!".toToastError();
      emit(RateAddFailureState());
    }
  }
}
