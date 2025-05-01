import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/request/add_medical_history_request.dart';
import 'package:healthify/src/data/request/update_medical_history_request.dart';
import 'package:healthify/src/data/response/add_medical_history_response.dart';
import 'package:healthify/src/data/response/medical_history_response/medical_history_response.dart';
import 'package:healthify/src/data/shared_models/medical_history_model.dart';
import 'package:healthify/src/services/dio_helper.dart';

part 'medical_history_state.dart';

class MedicalHistoryCubit extends Cubit<MedicalHistoryState> {
  MedicalHistoryCubit() : super(MedicalHistoryInitial());

  static MedicalHistoryCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final _history = <MedicalHistoryModel>[];

  List<MedicalHistoryModel> get history => _history;

  Future getAllMedicalHistory() async {
    try {
      emit(MedicalHistoryGetAllLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epGetMyMedicalHistory,
      );
      log(response.toString());
      logSuccess(
          "MedicalHistoryCubit getAllMedicalHistory Response: $response");
      final model = MedicalHistoryResponse.fromJson(response.data);
      if (model.data?.medicalHistory != null) {
        _history.clear();
        _history.addAll(model.data!.medicalHistory!);
      }
      emit(MedicalHistoryGetAllSuccessState());
    } on DioException catch (dioError) {
      logError(
          "MedicalHistoryCubit getAllMedicalHistory Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(MedicalHistoryGetAllFailureState());
    } catch (error) {
      logError("MedicalHistoryCubit getAllMedicalHistory Error: $error");
      "Unknown Error!".toToastError();
      emit(MedicalHistoryGetAllFailureState());
    }
  }

  Future addMedicalHistory({required AddMedicalHistoryRequest request}) async {
    logSuccess(request.toJson().toString());
    try {
      emit(MedicalHistoryCreateLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epAddMedicalHistory,
        body: request.toJson(),
        isForm: true,
      );
      logSuccess("MedicalHistoryCubit addMedicalHistory Response: $response");
      final model = AddMedicalHistoryResponse.fromJson(response.data);
      if (model.message != null) {
        model.message!.replaceAll("api.", "").toToastSuccess();
      }
      emit(MedicalHistoryCreateSuccessState());
    } on DioException catch (dioError) {
      logError(
          "MedicalHistoryCubit addMedicalHistory Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(MedicalHistoryCreateFailureState());
    } catch (error) {
      logError("MedicalHistoryCubit addMedicalHistory Error: $error");
      "Unknown Error!".toToastError();
      emit(MedicalHistoryCreateFailureState());
    }
  }

  Future updateMedicalHistory({
    required UpdateMedicalHistoryRequest request,
  }) async {
    try {
      emit(MedicalHistoryUpdateLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epUpdateMyMedicalHistory,
        body: request.toJson(),
        isForm: true,
      );
      logSuccess(
          "MedicalHistoryCubit updateMedicalHistory Response: $response");
      response.data["message"]?.toString().toToastSuccess();
      emit(MedicalHistoryUpdateSuccessState());
    } on DioException catch (dioError) {
      logError(
          "MedicalHistoryCubit updateMedicalHistory Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(MedicalHistoryUpdateFailureState());
    } catch (error) {
      logError("MedicalHistoryCubit updateMedicalHistory Error: $error");
      "Unknown Error!".toToastError();
      emit(MedicalHistoryUpdateFailureState());
    }
  }
}
