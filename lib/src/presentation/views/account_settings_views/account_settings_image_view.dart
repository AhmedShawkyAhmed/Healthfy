import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';

class AccountSettingImageView extends StatelessWidget {
  const AccountSettingImageView({
    super.key,
    this.image,
    required this.changeImage,
    required this.userId,
  });

  final Widget? image;
  final Function() changeImage;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.responsiveHeight(240),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background1,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: image ??
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: FittedBox(
                    child: Icon(
                      Icons.person,
                      color: AppColors.defaultWhite,
                    ),
                  ),
                ),
          ),
          Container(
            margin: EdgeInsets.only(top: context.responsiveHeight(10)),
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              border: Border.all(
                width: 1,
                color: AppColors.primary,
              ),
            ),
            child: Material(
              color: AppColors.defaultTransparent,
              borderRadius: BorderRadius.circular(45),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                onTap: changeImage,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    context.responsiveWidth(12),
                    context.responsiveHeight(8),
                    context.responsiveWidth(12),
                    context.responsiveHeight(8),
                  ),
                  child: FittedBox(
                    child: Text(
                      context.updateImage,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontFamily: 'Alexandria',
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: context.responsiveHeight(12)),
            width: 92,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.blueTransparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "id : $userId".toUpperCase(),
              style: const TextStyle(
                fontFamily: 'Alexandria',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
