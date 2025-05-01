import 'package:flutter/material.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';

class BookingDoneScreen extends StatefulWidget {
  final String title;

  const BookingDoneScreen({
    required this.title,
    super.key,
  });

  @override
  State<BookingDoneScreen> createState() => _BookingDoneScreenState();
}

class _BookingDoneScreenState extends State<BookingDoneScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3)).then(
        (value) => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouterNames.rHome,
          (route) => false,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.imgBlueCheck,
              height: context.responsiveHeight(64),
              width: context.responsiveWidth(64),
            ),
            SizedBox(
              height: context.responsiveHeight(12),
            ),
            Text(
              widget.title,
              style: const TextStyle(
                fontFamily: 'Alexandria',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.defaultBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
