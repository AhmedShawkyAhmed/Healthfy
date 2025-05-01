import 'package:flutter/material.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';

class QrCodeDoneScreen extends StatefulWidget {
  const QrCodeDoneScreen({super.key});

  @override
  State<QrCodeDoneScreen> createState() => _QrCodeDoneScreenState();
}

class _QrCodeDoneScreenState extends State<QrCodeDoneScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.popUntil(context, (route) => route.isFirst),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.imgSignUpDone),
              SizedBox(
                height: context.responsiveHeight(9),
              ),
              Text(
                context.congrats,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Alexandria',
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: context.responsiveHeight(9),
              ),
              Text(
                context.discountAcquired(10),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Alexandria',
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
