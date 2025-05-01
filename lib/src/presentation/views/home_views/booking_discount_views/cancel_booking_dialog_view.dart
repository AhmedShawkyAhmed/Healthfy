import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';

class CancelBookingDialogView extends StatelessWidget {
  const CancelBookingDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: context.responsiveHeight(139),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  color: AppColors.red,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              height: context.responsiveHeight(10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveWidth(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.cancelService,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Alexandria',
                      color: AppColors.grey1,
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveHeight(16),
                  ),
                  Text(
                    context.cancelServiceTime,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Alexandria',
                      color: AppColors.grey3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
