import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/data/response/notification_response/notification_response.dart';
import 'package:healthify/src/data/response/single_notification_response/single_notification_response.dart';
import 'package:healthify/src/data/shared_models/notification_model.dart';
import '../../constants/end_points.dart';
import '../../services/dio_helper.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  static NotificationCubit get(context) => BlocProvider.of(context);

  final _notifications = <NotificationModel>[];

  List<NotificationModel> get notifications => _notifications;

  Future getAllNotifications() async {
    try {
      emit(GetAllNotificationInitial());
      final response = await DioHelper.getData(
        url: EndPoints.epGetAllNotification,
      );
      logSuccess("NotificationCubit getAllNotifications Response: $response");
      final model = NotificationResponse.fromJson(response.data);
      if (model.data?.massages != null) {
        _notifications.clear();
        _notifications.addAll(model.data!.massages!);
      }
      emit(GetAllNotificationSuccess());
    } on DioException catch (n) {
      emit(GetAllNotificationError());
      logError(n.toString());
    } catch (e) {
      emit(GetAllNotificationError());
      logError(e.toString());
    }
  }

  Future getOneNotifications({required num id}) async {
    try {
      emit(GetOneNotificationInitial());
      final response = await DioHelper.getData(
        url: "${EndPoints.epGetPhone}/id",
      );
      logSuccess("NotificationCubit getOneNotifications Response: $response");
      final model = SingleNotificationResponse.fromJson(response.data);
      if (model.data?.massages != null) {
        emit(GetOneNotificationSuccess(model.data!.massages!));
      } else {
        emit(GetOneNotificationError());
      }
    } on DioException catch (n) {
      emit(GetOneNotificationError());
      logError(n.toString());
    } catch (e) {
      emit(GetOneNotificationError());
      logError(e.toString());
    }
  }

  Future markAllAsRead() async {
    try {
      emit(MarkAllReadInitial());
      final response = await DioHelper.putData(
        url: EndPoints.epMarkAllAsRead,
      );
      logSuccess("NotificationCubit markAllAsRead Response: $response");
      emit(MarkAllReadSuccess());
    } on DioException catch (n) {
      emit(MarkAllReadError());
      logError(n.toString());
    } catch (e) {
      emit(MarkAllReadError());
      logError(e.toString());
    }
  }

  Future markAsRead(int id) async {
    try {
      emit(MarkAsReadInitial());
      final response = await DioHelper.putData(
        url: "${EndPoints.epMarkAsRead}/$id",
      );
      logSuccess("NotificationCubit markAsRead Response: $response");
      emit(MarkAsReadSuccess());
    } on DioException catch (n) {
      emit(MarkAsReadError());
      logError(n.toString());
    } catch (e) {
      emit(MarkAsReadError());
      logError(e.toString());
    }
  }

  Future updateFCM(String fcm) async {
    try {
      emit(UpdateFCMInitial());
      final response = await DioHelper.putData(
        url: EndPoints.epUpdateFcm,
        query: {
          "fcm": fcm,
        },
      );
      logSuccess("NotificationCubit updateFCM Response: $response");
      emit(UpdateFCMSuccess());
    } on DioException catch (n) {
      emit(UpdateFCMError());
      logError(n.toString());
    } catch (e) {
      emit(UpdateFCMError());
      logError(e.toString());
    }
  }
}
