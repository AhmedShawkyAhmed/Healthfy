import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:sizer/sizer.dart';

class DoctorsTopDataViewItem extends StatelessWidget {
  const DoctorsTopDataViewItem({
    super.key,
    required this.icon,
    required this.text1,
    required this.text2,
  });

  final Widget icon;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 1.2.h, bottom: 1.6.h,),
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        //width: 92,
        decoration: BoxDecoration(
          color: AppColors.primaryOpacity,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 2.5.h,
              width: 9.w,
              //padding: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                color: AppColors.defaultWhite,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: icon),
            ),
            DefaultAppText(
              text: text1,
              textAlign: TextAlign.center,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            DefaultAppText(
              text: text2,
              textAlign: TextAlign.center,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.grey2,
            ),
          ],
        ),
      ),
    );
  }
}