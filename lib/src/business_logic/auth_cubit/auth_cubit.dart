import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/cache_keys.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/const_variables.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/constants/enums.dart';
import 'package:healthify/src/data/request/register_request.dart';
import 'package:healthify/src/data/request/update_profile_request.dart';
import 'package:healthify/src/data/request/verify_phone_request.dart';
import 'package:healthify/src/data/response/logout_response.dart';
import 'package:healthify/src/data/response/profile_response/profile_response.dart';
import 'package:healthify/src/data/response/register_response/register_response.dart';
import 'package:healthify/src/data/response/verify_otp_response/verify_otp_response.dart';
import 'package:healthify/src/data/response/verify_phone_response/verify_phone_response.dart';
import 'package:healthify/src/data/shared_models/user_model.dart';
import 'package:healthify/src/services/cache_helper.dart';
import 'package:healthify/src/services/dio_helper.dart';
import 'package:reve_chat_sdk/user_model.dart' as rev_user;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth;

  AuthCubit(
    this._auth,
  ) : super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  UserModel? _user;

  UserModel? get user => _user;

  String? _verId;
  UserCredential? _firebaseUser;

  Future verifyPhoneFirebase({
    required String phoneNumber,
  }) async {
    try {
      emit(AuthVerifyPhoneFirebaseLoadingState());
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(minutes: 2),
        verificationCompleted: (cred) {},
        verificationFailed: (e) {
          showToast('Phone Verification ${e.message}', ToastState.error);
          debugPrint('\x1B[31m verifyPhone error message: ${e.message}\x1B[0m');
          emit(AuthVerifyPhoneFirebaseFailureState());
        },
        codeSent: (verId, resCode) {
          _verId = verId;
          emit(AuthVerifyPhoneFirebaseSuccessState());
        },
        codeAutoRetrievalTimeout: (verID) {
          if (_user == null) {
            logError("Phone Verification Timeout");
          }
        },
      );
    } catch (e) {
      showToast('Phone Verification Failure', ToastState.error);
      emit(AuthVerifyPhoneFirebaseFailureState());
    }
  }

  Future verifyOTPFirebase({
    required String code,
  }) async {
    try {
      emit(AuthVerifyOTPFirebaseLoadingState());
      final cred = PhoneAuthProvider.credential(
        verificationId: _verId!,
        smsCode: code,
      );
      _firebaseUser = await _auth.signInWithCredential(cred);
      if (_firebaseUser?.user != null) {
        showToast('Phone Verification Success', ToastState.success);
        _firebaseUser?.user?.delete();
        emit(AuthVerifyOTPFirebaseSuccessState());
      } else {
        showToast('Invalid OTP', ToastState.error);
        emit(AuthVerifyOTPFirebaseFailureState());
      }
    } catch (e) {
      showToast('OTP Verification Failure', ToastState.error);
      debugPrint('\x1B[31m verifyOTp error: $e\x1B[0m');
      emit(AuthVerifyOTPFirebaseFailureState());
    }
  }

  Future verifyPhone({required VerifyPhoneRequest request}) async {
    try {
      emit(AuthVerifyPhoneLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epVerifyPhone,
        body: request.toJson(),
      );
      logSuccess("AuthCubit VerifyPhone Response: $response");
      final model = VerifyPhoneResponse.fromJson(response.data);
      if (model.message != null) {
        showToast(
          model.message!.replaceAll("api.", ""),
          ToastState.success,
        );
      }
      showToast(model.data!.otp.toString(), ToastState.success);
      CacheHelper.saveDataSharedPreference(
        key: CacheKeys.ckVerifyPhoneToken,
        value: model.data!.token,
      );
      emit(AuthVerifyPhoneSuccessState("${model.data?.otp}"));
    } on DioException catch (dioError) {
      logError("AuthCubit VerifyPhone Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(AuthVerifyPhoneFailureState());
    } catch (error) {
      logError("AuthCubit VerifyPhone Error: $error");
      "Unknown Error!".toToastError();
      emit(AuthVerifyPhoneFailureState());
    }
  }

  Future verifyOtp({required String otp}) async {
    try {
      emit(AuthVerifyOtpLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epVerifyOtp,
        body: {
          "otp": otp,
        },
        token: CacheHelper.getDataFromSharedPreference(
          key: CacheKeys.ckVerifyPhoneToken,
        ),
      );
      logSuccess("AuthCubit verifyOtp Response: $response");
      final model = VerifyOtpResponse.fromJson(response.data);
      if (model.message != null) {
        showToast(
          model.message!.replaceAll("api.", ""),
          ToastState.success,
        );
      }
      await reveChat.setReveChatVisitorInfo(
        rev_user.UserModel(
          name: "Magdsoft Testing",
          email: "magdsoft@test.com",
          phoneNumber: "+201234567891",
        ),
      );
      CacheHelper.saveDataSharedPreference(
        key: model.data?.user == true
            ? CacheKeys.ckApiToken
            : CacheKeys.ckVerifyOtpToken,
        value: model.data!.token,
      );
      emit(AuthVerifyOtpSuccessState(
        isUser: model.data!.user!,
      ));
    } on DioException catch (dioError) {
      logError("AuthCubit verifyOtp Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(AuthVerifyOtpFailureState());
    } catch (error) {
      logError("AuthCubit verifyOtp Error: $error");
      "Unknown Error!".toToastError();
      emit(AuthVerifyOtpFailureState());
    }
  }

  Future register({required RegisterRequest request}) async {
    try {
      emit(AuthRegisterLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epRegister,
        body: request.toJson(),
        token: CacheHelper.getDataFromSharedPreference(
          key: CacheKeys.ckVerifyOtpToken,
        ),
        isForm: true,
      );
      logSuccess("AuthCubit register Response: $response");
      final model = RegisterResponse.fromJson(response.data);
      if (model.message != null) {
        showToast(
          model.message!.replaceAll("api.", ""),
          ToastState.success,
        );
      }
      CacheHelper.saveDataSharedPreference(
        key: CacheKeys.ckApiToken,
        value: model.data!.token,
      );
      emit(AuthRegisterSuccessState());
    } on DioException catch (dioError) {
      logError("AuthCubit register Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(AuthRegisterFailureState());
    } catch (error) {
      logError("AuthCubit register Error: $error");
      "Unknown Error!".toToastError();
      emit(AuthRegisterFailureState());
    }
  }

  Future getProfile() async {
    try {
      emit(AuthGetProfileLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epGetProfile,
      );
      logSuccess("AuthCubit getProfile Response: $response");
      final model = ProfileResponse.fromJson(response.data);
      //TODO update user data here in chat support
      // FreshchatUser freshchatUser = FreshchatUser(null, null);
      // if (model.message != null) {
      //   showToast(
      //     model.message!.replaceAll("api.", ""),
      //     ToastState.success,
      //   );
      // }
      _user = model.data?.user;
      // freshchatUser.setFirstName(_user?.name ?? 'User');
      await reveChat.setReveChatVisitorInfo(
        rev_user.UserModel(
          name: model.data?.user?.name ?? "مستخدم صحتك تهمنا",
          email: model.data?.user?.email ?? "example@example.com",
          phoneNumber: model.data?.user?.phone ?? "+201234567891",
        ),
      );
      emit(AuthGetProfileSuccessState());
    } on DioException catch (dioError) {
      logError("AuthCubit getProfile Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(AuthGetProfileFailureState());
    } catch (error) {
      logError("AuthCubit getProfile Error: $error");
      "Unknown Error!".toToastError();
      emit(AuthGetProfileFailureState());
    }
  }

  Future updateProfile({required UpdateProfileRequest request}) async {
    try {
      emit(AuthUpdateProfileLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epUpdateProfile,
        body: request.toJson(),
        isForm: true,
      );
      logSuccess("AuthCubit updateProfile Response $response");
      final model = ProfileResponse.fromJson(response.data);
      if (model.message != null) {
        showToast(
          model.message!.replaceAll("api.", ""),
          ToastState.success,
        );
      }
      _user = model.data?.user;
      emit(AuthUpdateProfileSuccessState());
    } on DioException catch (dioError) {
      logError("AuthCubit updateProfile Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(AuthUpdateProfileFailureState());
    } catch (error) {
      logError("AuthCubit updateProfile Error: $error");
      "Unknown Error!".toToastError();
      emit(AuthUpdateProfileFailureState());
    }
  }

  Future logout() async {
    try {
      emit(AuthLogoutLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epLogout,
      );
      logSuccess("AuthCubit logout Response: $response");
      final model = LogoutResponse.fromJson(response.data);
      if (model.message != null) {
        showToast(
          model.message!.replaceAll("api.", ""),
          ToastState.success,
        );
      }
      _user = null;
      await reveChat.setReveChatVisitorInfo(
        rev_user.UserModel(
          name: "مستخدم صحتك تهمنا",
          email: "example@example.com",
          phoneNumber: "+201234567891",
        ),
      );
      final lang = CacheHelper.getDataFromSharedPreference(
        key: CacheKeys.ckAppLang,
      );
      final isDark = CacheHelper.getDataFromSharedPreference(
        key: CacheKeys.ckIsDarkTheme,
      );
      CacheHelper.saveDataSharedPreference(
        key: CacheKeys.ckAppLang,
        value: lang,
      );
      CacheHelper.saveDataSharedPreference(
        key: CacheKeys.ckIsDarkTheme,
        value: isDark,
      );
      await CacheHelper.clearData();
      emit(AuthLogoutSuccessState());
    } on DioException catch (dioError) {
      logError("AuthCubit logout Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(AuthLogoutFailureState());
    } catch (error) {
      logError("AuthCubit logout Error: $error");
      "Unknown Error!".toToastError();
      emit(AuthLogoutFailureState());
    }
  }
}
