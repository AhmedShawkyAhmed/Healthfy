import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';

class CustomCountryPickerDialog extends StatelessWidget {
  const CustomCountryPickerDialog({
    Key? key,
    required this.onCountryPicked,
  }) : super(key: key);

  final Function(Country country) onCountryPicked;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.pink,
        ),
        child: CountryPickerDialog(
          titlePadding: const EdgeInsets.all(8.0),
          searchCursorColor: Colors.pinkAccent,
          searchInputDecoration: InputDecoration(
            hintText: context.search,
          ),
          isSearchable: true,
          title: Text(
            context.phoneCodeSelect,
            style: const TextStyle(
              fontFamily: 'Alexandria',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.defaultBlack,
            ),
          ),
          onValuePicked: onCountryPicked,
          itemBuilder: (country) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                CountryPickerUtils.getFlagImageAssetPath(
                  country.isoCode,
                ),
                height: 15.0,
                width: 25.0,
                fit: BoxFit.fill,
                package: "country_pickers",
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Text(
                  country.name,
                  style: const TextStyle(
                    fontFamily: 'Alexandria',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.defaultBlack,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "+${country.phoneCode}",
                style: const TextStyle(
                  fontFamily: 'Alexandria',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.defaultBlack,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
