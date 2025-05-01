import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.padding,
    this.height,
    this.borderRadius,
    required this.onTap,
    this.backgroundColor,
    this.border,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final EdgeInsets? padding;
  final double? height;
  final double? borderRadius;
  final Function()? onTap;
  final Color? backgroundColor;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? context.responsiveHeight(56),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        border: border,
        color: backgroundColor ?? AppColors.primary,
      ),
      child: Material(
        color: AppColors.defaultTransparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: padding ??
                  EdgeInsets.symmetric(
                    horizontal: context.responsiveWidth(10),
                    vertical: context.responsiveHeight(16),
                  ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize ?? 14,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  fontFamily: 'Alexandria',
                  color: textColor ?? AppColors.defaultWhite,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
