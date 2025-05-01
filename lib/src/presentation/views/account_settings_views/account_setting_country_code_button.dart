import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';

class AccountSettingCountryCodeButton extends StatelessWidget {
  const AccountSettingCountryCodeButton({
    super.key,
    required this.country,
    required this.showCountryPicker,
  });

  final Country country;
  final Function() showCountryPicker;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 16,
      ),
      width: context.responsiveWidth(98),
      padding: EdgeInsets.fromLTRB(
        context.responsiveWidth(16),
        context.responsiveHeight(18),
        context.responsiveWidth(16),
        context.responsiveHeight(18),
      ),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: AppColors.grey5,
            width: 1,
          ),
        ),
      ),
      child: Material(
        color: AppColors.defaultTransparent,
        child: InkWell(
          onTap: showCountryPicker,
          child: FittedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image.asset(
                    CountryPickerUtils.getFlagImageAssetPath(
                      country.isoCode,
                    ),
                    height: context.responsiveHeight(20),
                    width: context.responsiveWidth(28),
                    fit: BoxFit.fill,
                    package: "country_pickers",
                  ),
                ),
                SizedBox(
                  width: context.responsiveWidth(12),
                ),
                Text(
                  "+${country.phoneCode}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Alexandria',
                    color: AppColors.defaultBlack,
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
