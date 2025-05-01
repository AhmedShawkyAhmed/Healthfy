import 'package:flutter/material.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/constants/cache_keys.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/services/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        final token = CacheHelper.getDataFromSharedPreference(
          key: CacheKeys.ckApiToken,
        );
        if (token != null) {
          logSuccess("ApiToken: $token");
          Navigator.pushReplacementNamed(context, AppRouterNames.rHome);
        } else {
          Navigator.pushReplacementNamed(context, AppRouterNames.rOnBoarding);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhite,
      body: Center(
        child: Image.asset(AppAssets.imgAboutApp),
      ),
    );
  }
}
