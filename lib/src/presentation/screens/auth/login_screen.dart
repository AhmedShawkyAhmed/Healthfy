import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/data/request/verify_phone_request.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';

import '../../../constants/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * .14, horizontal: size.width * .05),
            child: Column(
              children: [
                Text(
                  context.login,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * .05),
                  child: Image.asset(AppAssets.imgLogin),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Container(
                    height: 60,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: AppColors.primaryOpacity,
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: AppColors.primary, width: 1.6)),
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: AppColors.primary, width: 1.6)),
                              color: AppColors.defaultTransparent,
                            ),
                            child: RichText(
                                text: const TextSpan(text: '🇪🇬', children: [
                              TextSpan(
                                  text: ' +20',
                                  style: TextStyle(color: Colors.black))
                            ]))),
                        Expanded(
                            child: TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.phone,
                          controller: _controller,
                          maxLength: 11,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            isDense: true,
                            isCollapsed: true,
                            counter: null,
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: '01xx xxx xxxx',
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * .03),
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthVerifyPhoneFirebaseSuccessState) {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRouterNames.rVerification,
                            arguments: VerifyPhoneRequest(
                              phoneNumber: _controller.text.substring(1),
                              dialCode: "+20",
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case AuthVerifyPhoneFirebaseLoadingState:
                            return const Center(
                                child: CircularProgressIndicator());
                          default:
                            return ElevatedButton(
                              onPressed: () {
                                AuthCubit.get(context).verifyPhoneFirebase(
                                  phoneNumber: "+20${_controller.text.substring(1)}",
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fixedSize: const Size(double.infinity, 60),
                                  backgroundColor: AppColors.primary),
                              child: Text(
                                context.follow,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
