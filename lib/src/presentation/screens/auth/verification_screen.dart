import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:healthify/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:healthify/src/constants/const_variables.dart';
import 'package:healthify/src/data/request/verify_phone_request.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.request});

  final VerifyPhoneRequest request;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late final TextEditingController _controller;
  late Timer? _timer;
  final ValueNotifier<int> secondsToResend = ValueNotifier<int>(120);
  final ValueNotifier<bool> _resend = ValueNotifier(false);
  final ValueNotifier<bool> _authEnable = ValueNotifier(false);
  final ValueNotifier<bool> _otp = ValueNotifier(true);

  @override
  void initState() {
    _controller = TextEditingController();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setCountDown();
    });
    super.initState();
  }

  void setCountDown() {
    secondsToResend.value -= 1;

    if (secondsToResend.value < 1) {
      _resend.value = true;
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                size.width * .05, size.height * .05, size.width * .05,size.height * .14),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * .05),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRouterNames.rLogin
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios),
                        Text(
                          context.back,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  context.code,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * .05),
                  child: Image.asset(AppAssets.imgLogin),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .0008),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      autoFocus: true,
                      length: 6,
                      textStyle: const TextStyle(color: AppColors.primary),
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        activeColor: AppColors.grey6,
                        fieldHeight: 60,
                        fieldWidth: size.width * .6 / 5,
                        activeFillColor: AppColors.blueTransparent,
                        selectedFillColor: Colors.white,
                        selectedColor: AppColors.primary,
                        borderWidth: 1,
                        inactiveFillColor: Colors.white,
                        inactiveColor: AppColors.grey6,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.white,
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      controller: _controller,
                      onCompleted: (v) {},
                      onChanged: (value) {
                        _authEnable.value = _otp.value && value.length == 6 ||
                            !_otp.value && value.length == 10;
                      },
                      beforeTextPaste: (text) {
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      appContext: context,
                    ),
                  ),
                ),
                Text(
                  context.enterCode,
                  style: const TextStyle(
                    color: AppColors.grey2,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * .03),
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthVerifyOTPFirebaseSuccessState) {
                          AuthCubit.get(context).verifyPhone(
                            request: widget.request,
                          );
                        } else if (state is AuthVerifyPhoneSuccessState) {
                          AuthCubit.get(context).verifyOtp(
                            otp: state.code,
                          );
                        } else if (state is AuthVerifyOtpSuccessState) {
                          if (state.isUser) {
                            if (fcmToken != null) {
                              NotificationCubit.get(context)
                                  .updateFCM(fcmToken!);
                            }
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRouterNames.rHome,
                              (r) => false,
                            );
                          } else {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRouterNames.rRegisterBasicInfo,
                            );
                          }
                        }
                      },
                      builder: (context, state) {
                        return ValueListenableBuilder(
                            valueListenable: _authEnable,
                            builder: (context, authEnable, child) {
                              return state
                                          is AuthVerifyOTPFirebaseLoadingState ||
                                      state is AuthVerifyPhoneLoadingState ||
                                      state is AuthVerifyOtpLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : ElevatedButton(
                                      onPressed: authEnable
                                          ? () {
                                              AuthCubit.get(context)
                                                  .verifyOTPFirebase(
                                                code: _controller.text,
                                              );
                                            }
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          fixedSize:
                                              const Size(double.infinity, 60),
                                          backgroundColor: AppColors.primary),
                                      child: Text(
                                        context.confirm,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    );
                            });
                      },
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: secondsToResend,
                  builder: (context, value, child) {
                    final min = value ~/ 60;
                    final sec = value % 60;
                    return Text(
                      "${min.toString().padLeft(2, '0')} : ${sec.toString().padLeft(2, '0')}",
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(color: AppColors.grey3),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.areYouReceived,
                      style: const TextStyle(color: AppColors.grey3),
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthVerifyPhoneFirebaseSuccessState) {
                          secondsToResend.value = 120;
                          _resend.value = false;
                          _timer = Timer.periodic(const Duration(seconds: 1),
                              (timer) {
                            setCountDown();
                          });
                        }
                      },
                      builder: (context, state) {
                        return ValueListenableBuilder(
                            valueListenable: _resend,
                            builder: (context, resend, child) {
                              return state
                                      is AuthVerifyPhoneFirebaseLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : InkWell(
                                      onTap: resend
                                          ? () {
                                              AuthCubit.get(context)
                                                  .verifyPhoneFirebase(
                                                phoneNumber:
                                                    "${widget.request.dialCode}"
                                                    "${widget.request.phoneNumber}",
                                              );
                                            }
                                          : null,
                                      child: Text(
                                        context.resend,
                                        style: TextStyle(
                                            color: resend
                                                ? AppColors.primary
                                                : AppColors.grey3,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    );
                            });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
