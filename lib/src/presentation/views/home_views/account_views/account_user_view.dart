import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';

class AccountUserView extends StatelessWidget {
  const AccountUserView({
    super.key,
    this.image,
    required this.username,
    required this.onTap,
  });

  final String? image;
  final String username;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.responsiveHeight(80),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.blueTransparent,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background2,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: image != null
                  ? Image.network(
                      image!,
                      fit: BoxFit.cover,
                    )
                  : const Padding(
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        child: Icon(
                          Icons.person,
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              width: 20,
            ),
            FittedBox(
              fit: BoxFit.fitHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: AppColors.primary,
                      fontFamily: 'Alexandria',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.settings,
                        color: AppColors.primary,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        context.accountSettings,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          fontFamily: 'Alexandria',
                        ),
                      )
                    ],
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
