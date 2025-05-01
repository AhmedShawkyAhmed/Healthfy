import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/data/resonses/phone_response.dart';

import '../../constants/end_points.dart';
import '../../services/dio_helper.dart';

part 'app_content_state.dart';

class AppContentCubit extends Cubit<AppContentState> {
  AppContentCubit() : super(AppContentInitial());

  static AppContentCubit get(context) => BlocProvider.of(context);

  PhoneResponse? phoneResponse;

  Future getPhone() async {
    try {
      emit(GetPhoneLoading());
      final response = await DioHelper.getData(
        url: EndPoints.epGetPhone,
        query: {
          "api":1,
        }
      );
      logSuccess("AppContentCubit getPhone Response: $response");
      phoneResponse = PhoneResponse.fromJson(response.data);
      emit(GetPhoneSuccess());
    } on DioException catch (n) {
      emit(GetPhoneError());
      logError(n.toString());
    } catch (e) {
      emit(GetPhoneError());
      logError(e.toString());
    }
  }

  Future getPrivacy() async {
    try {
      emit(GetPrivacyLoading());
      final response = await DioHelper.getData(
        url: EndPoints.epGetPrivacy,
      );
      logSuccess("AppContentCubit getPrivacy Response: $response");
      emit(GetPrivacySuccess());
    } on DioException catch (n) {
      emit(GetPrivacyError());
      logError(n.toString());
    } catch (e) {
      emit(GetPrivacyError());
      logError(e.toString());
    }
  }

  Future getContactUs() async {
    try {
      emit(GetContactUsLoading());
      final response = await DioHelper.getData(
        url: EndPoints.epGetContacts,
      );
      logSuccess("AppContentCubit getContactUs Response: $response");
      emit(GetContactUsSuccess());
    } on DioException catch (n) {
      emit(GetContactUsError());
      logError(n.toString());
    } catch (e) {
      emit(GetContactUsError());
      logError(e.toString());
    }
  }
}
