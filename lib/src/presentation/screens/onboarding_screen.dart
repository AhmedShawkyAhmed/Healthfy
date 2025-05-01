import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../data/shared_models/baording_model.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late final PageController _pageController;
  late final Timer _timer;

  @override
  void initState() {
    _pageController = PageController();
    int page = 0;
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      page++;
      if (page <= 3) {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: PageView.builder(
                itemCount: onBoardingData(context).length,
                controller: _pageController,
                itemBuilder: (context, index) => OnBoardingContent(
                      model: onBoardingData(context)[index],
                    )),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .07, vertical: size.height * .03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.login,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * .03),
                    Text(context.phoneNumber),
                    SizedBox(height: size.height * .01),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(
                        height: 50,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  border: Border(
                                      right: BorderSide(color: Colors.black)),
                                  color: AppColors.defaultTransparent,
                                ),
                                child: RichText(
                                    text: const TextSpan(
                                        text: '🇪🇬',
                                        children: [
                                      TextSpan(
                                          text: ' +20',
                                          style: TextStyle(color: Colors.black))
                                    ]))),
                            Expanded(
                                child: TextFormField(
                              onChanged: (value) {
                                // BlocProvider.of<AuthCubit>(context)
                                //     .toggleAuthEnable(value.length);
                              },
                              keyboardType: TextInputType.phone,
                              //   controller: controller,
                              maxLength: 10,
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, AppRouterNames.rLogin),
                              // onTap: () => Navigator.pushReplacementNamed(
                              //     context, AppRouterNames.rHome),
                              readOnly: true,
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
                    SizedBox(height: size.height * .03),
                    FittedBox(
                      child: Row(
                        children: [
                          Text(
                            context.privacy1,
                            style: const TextStyle(
                                color: AppColors.grey3,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRouterNames.rTerms,
                            ),
                            child: Text(' ${context.privacy2}',
                                style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xffF0F4F7),
      child: Stack(
        children: [
          Positioned(
            top: 90,
            left: -100,
            child: Image.asset(AppAssets.aboutApp, width: 100.w),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(model.imgPath),
              const SizedBox(height: 40),
              Text(
                model.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .08),
                child: Text(
                  model.body,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    height: 1.5,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
