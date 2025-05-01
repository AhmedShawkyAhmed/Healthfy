import 'package:flutter/material.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/widgets/custom_button.dart';

class EmptyDeliveryLocationsView extends StatelessWidget {
  const EmptyDeliveryLocationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.imgEmptyLocations,
        ),
        SizedBox(
          height: context.responsiveHeight(32),
        ),
        Text(
          context.emptyLocations,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Alexandria',
            color: AppColors.grey1,
          ),
        ),
        SizedBox(
          height: context.responsiveHeight(32),
        ),
        Container(
          height: context.responsiveHeight(88),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: context.responsiveHeight(16),
          ),
          child: CustomButton(
            text: context.addNewLocation,
            onTap: () => Navigator.pushNamed(
              context,
              AppRouterNames.rLocationSelect,
            ),
          ),
        ),
      ],
    );
  }
}
