import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';

class AccountItemView extends StatelessWidget {
  const AccountItemView({
    super.key,
    this.isPoints = false,
    this.points,
    required this.icon,
    required this.title,
    required this.onTap,
    this.margin,
    this.backgroundColor,
    this.titleColor,
    this.isArrow = true,
    this.iconColor,
    this.iconBackgroundColor,
  });

  final bool isPoints;
  final String? points;
  final IconData icon;
  final String title;
  final EdgeInsets? margin;
  final Function() onTap;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool isArrow;
  final Color? iconColor;
  final Color? iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: context.responsiveHeight(74),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.defaultWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              height: context.responsiveHeight(48),
              width: context.responsiveHeight(48),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor ?? AppColors.blueTransparent,
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.primary,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Alexandria',
                  fontSize: 14,
                  color: titleColor ?? AppColors.primary,
                ),
              ),
            ),
            if (isPoints)
              Text(
                points!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  fontFamily: 'Alexandria',
                ),
              ),
            if (isPoints)
              const SizedBox(
                width: 12,
              ),
            if (isArrow)
              const Icon(
                Icons.chevron_right,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}
