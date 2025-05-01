import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/models/my_reservation_model.dart';
import 'package:healthify/src/data/request/reservation_confirmation_request.dart';
import 'package:healthify/src/data/request/reserve_request.dart';
import 'package:healthify/src/data/request/store_additional_services_request.dart';
import 'package:healthify/src/data/resonses/my_reservation_response.dart';
import 'package:healthify/src/data/response/reservation_response.dart';
import 'package:healthify/src/data/response/services_with_discount_response/services_with_discount_response.dart';
import 'package:healthify/src/data/shared_models/service_model.dart';
import 'package:healthify/src/services/dio_helper.dart';

part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  ReservationCubit() : super(ReservationInitial());

  static ReservationCubit get(BuildContext context) => BlocProvider.of(context);

  final _services = <ServiceModel>[];

  List<ServiceModel> get services => _services;

  Future getServicesWithDiscount({required num medicineTypeId}) async {
    try {
      emit(ReservationGetServicesWithDiscountLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epGetServicesWithDiscount,
        query: {
          "medicine_type_id": medicineTypeId,
        },
      );
      logSuccess(
          "ReservationCubit getServicesWithDiscount Response: $response");
      final model = ServicesWithDiscountResponse.fromJson(response.data);
      if (model.data?.services != null) {
        _services.clear();
        _services.addAll(model.data!.services!);
      }
      emit(ReservationGetServicesWithDiscountSuccessState());
    } on DioException catch (dioError) {
      logError(
          "ReservationCubit getServicesWithDiscount Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(ReservationGetServicesWithDiscountFailureState());
    } catch (error) {
      logError("ReservationCubit getServicesWithDiscount Error: $error");
      "Unknown Error!".toToastError();
      emit(ReservationGetServicesWithDiscountFailureState());
    }
  }

  Future reserve({required ReserveRequest request}) async {
    try {
      emit(ReservationLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epReserve,
        query: request.toJson(),
      );
      logSuccess("ReservationCubit reserve Response: $response");
      final model = ReservationResponse.fromJson(response.data);
      model.message!.replaceAll("api.", "").toToastSuccess();
      getWaitingMyReservation();
      emit(ReservationSuccessState());
    } on DioException catch (dioError) {
      logError("ReservationCubit reserve Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(ReservationFailureState());
    } catch (error) {
      logError("ReservationCubit reserve Error: $error");
      "Unknown Error!".toToastError();
      emit(ReservationFailureState());
    }
  }

  final _myReservations = <MyReservationModel>[];

  List<MyReservationModel> get myReservations => _myReservations;
  List<MyReservationModel> myWaitingReservations = [];
  List<MyReservationModel> myEndedReservations = [];

  Future getMyReservation() async {
    try {
      emit(ReservationGetMyReservationLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epMyReservation,
      );
      logSuccess("ReservationCubit getMyReservation Response: $response");
      final model = MyReservationResponse.fromJson(response.data);
      if (model.data?.myReservation != null) {
        _myReservations.clear();
        _myReservations.addAll(model.data!.myReservation!);
      }
      emit(ReservationGetMyReservationSuccessState());
    } on DioException catch (dioError) {
      logError(
          "ReservationCubit getMyReservation Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(ReservationGetMyReservationFailureState());
    } catch (error) {
      logError("ReservationCubit getMyReservation Error: $error");
      "Unknown Error!".toToastError();
      emit(ReservationGetMyReservationFailureState());
    }
  }

  Future getEndedMyReservation() async {
    try {
      emit(ReservationGetEndedMyReservationLoadingState());
      final response =
          await DioHelper.getData(url: EndPoints.epMyReservation, query: {
        "status": 'end',
      });
      logSuccess("ReservationCubit getEndedMyReservation Response: $response");
      final model = MyReservationResponse.fromJson(response.data);
      if (model.data?.myReservation != null) {
        myEndedReservations.clear();
        myEndedReservations.addAll(model.data!.myReservation!);
      }
      emit(ReservationGetEndedMyReservationSuccessState());
    } on DioException catch (dioError) {
      logError(
          "ReservationCubit getEndedMyReservation Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(ReservationGetEndedMyReservationFailureState());
    } catch (error) {
      logError("ReservationCubit getEndedMyReservation Error: $error");
      "Unknown Error!".toToastError();
      emit(ReservationGetEndedMyReservationFailureState());
    }
  }

  Future getWaitingMyReservation() async {
    try {
      emit(ReservationGetWaitingMyReservationLoadingState());
      final response =
          await DioHelper.getData(url: EndPoints.epMyReservation, query: {
        "status": 'waiting',
      });
      logSuccess(
          "ReservationCubit getWaitingMyReservation Response: $response");
      final model = MyReservationResponse.fromJson(response.data);
      if (model.data?.myReservation != null) {
        myWaitingReservations.clear();
        myWaitingReservations.addAll(model.data!.myReservation!);
      }
      emit(ReservationGetWaitingMyReservationSuccessState());
    } on DioException catch (dioError) {
      logError(
          "ReservationCubit getWaitingMyReservation Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(ReservationGetWaitingMyReservationFailureState());
    } catch (error) {
      logError("ReservationCubit getWaitingMyReservation Error: $error");
      "Unknown Error!".toToastError();
      emit(ReservationGetWaitingMyReservationFailureState());
    }
  }

  void updateReservationAfterConfirmation(int reservationId) {
    final index1 = _myReservations.indexWhere(
      (element) => element.id == reservationId,
    );
    if (index1 != -1) {
      _myReservations[index1].status = "end";
    }
    final index2 = myWaitingReservations.indexWhere(
      (element) => element.id == reservationId,
    );
    if (index2 != -1) {
      myWaitingReservations.removeAt(index2);
    }
    getEndedMyReservation();
    emit(ReservationConfirmReservationSuccessState());
  }

  Future confirmReservation({
    required ReservationConfirmationRequest request,
  }) async {
    try {
      emit(ReservationConfirmReservationLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epReservationsConfirmation,
        body: request.toJson(),
      );
      logSuccess("ReservationCubit confirmReservation Response: $response");
      if (response.data is! String && request.reservationId != null) {
        updateReservationAfterConfirmation(
          request.reservationId!.toInt(),
        );
      } else if (response.data is String) {
        if ((response.data as String).isNotEmpty) {
          emit(
            ReservationConfirmReservationSuccessState(
              paymentUrl: response.data,
            ),
          );
        } else {
          "Empty Payment Url".toToastError();
          emit(ReservationConfirmReservationFailureState());
        }
      } else {
        emit(ReservationConfirmReservationSuccessState());
      }
    } on DioException catch (dioError) {
      logError(
          "ReservationCubit confirmReservation Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(ReservationConfirmReservationFailureState());
    } catch (error) {
      logError("ReservationCubit confirmReservation Error: $error");
      "Unknown Error!".toToastError();
      emit(ReservationConfirmReservationFailureState());
    }
  }

  Future cancelReservation({
    required num reservationId,
  }) async {
    try {
      emit(ReservationCancelReservationLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epCancelReservation,
        body: {
          "reservation_id": reservationId,
        },
      );
      logSuccess("ReservationCubit cancelReservation Response: $response");
      final index1 = _myReservations.indexWhere(
        (element) => element.id == reservationId.toInt(),
      );
      if (index1 != -1) {
        _myReservations[index1].status = "cancel";
      }
      final index2 = myWaitingReservations.indexWhere(
        (element) => element.id == reservationId.toInt(),
      );
      if (index2 != -1) {
        myWaitingReservations.removeAt(index2);
      }
      final index3 = myEndedReservations.indexWhere(
        (element) => element.id == reservationId.toInt(),
      );
      if (index3 != -1) {
        myEndedReservations.removeAt(index3);
      }
      emit(ReservationCancelReservationSuccessState());
    } on DioException catch (dioError) {
      logError(
          "ReservationCubit cancelReservation Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(ReservationCancelReservationFailureState());
    } catch (error) {
      logError("ReservationCubit cancelReservation Error: $error");
      "Unknown Error!".toToastError();
      emit(ReservationCancelReservationFailureState());
    }
  }

  Future storeAdditionalServices({
    required StoreAdditionalServicesRequest request,
  }) async {
    try {
      logSuccess("StoreAdditionalServicesRequest: ${request.toJson()}");
      emit(ReservationStoreAdditionalServicesLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epStoreAdditionalServices,
        body: request.toJson(),
      );
      logSuccess(
          "ReservationCubit storeAdditionalServices Response: $response");
      emit(ReservationStoreAdditionalServicesSuccessState());
    } on DioException catch (dioError) {
      logError(
          "ReservationCubit storeAdditionalServices Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(ReservationStoreAdditionalServicesFailureState());
    } catch (error) {
      logError("ReservationCubit storeAdditionalServices Error: $error");
      "Unknown Error!".toToastError();
      emit(ReservationStoreAdditionalServicesFailureState());
    }
  }
}
