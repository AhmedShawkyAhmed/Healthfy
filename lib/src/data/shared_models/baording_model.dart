import 'package:flutter/material.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';

import '../../constants/assets.dart';

class OnBoardingModel {
  final String title, body, imgPath;

  OnBoardingModel(this.title, this.body, this.imgPath);
}

List<OnBoardingModel> onBoardingData(BuildContext context) => [
      OnBoardingModel(
        context.onBoarding1Text1,
        context.onBoarding1Text2,
        AppAssets.imgOnBoarding1,
      ),
      OnBoardingModel(
        context.onBoarding2Text1,
        context.onBoarding2Text2,
        AppAssets.imgOnBoarding2,
      ),
      OnBoardingModel(
        context.onBoarding3Text1,
        context.onBoarding3Text2,
        AppAssets.imgOnBoarding3,
      ),
      OnBoardingModel(
        context.onBoarding4Text1,
        context.onBoarding4Text2,
        AppAssets.imgOnBoarding4,
      ),
    ];
