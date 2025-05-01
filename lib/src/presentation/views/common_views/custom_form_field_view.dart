import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';

class CustomFormFieldView extends StatelessWidget {
  const CustomFormFieldView({
    super.key,
    required this.title,
    required this.controller,
    required this.keyboardType,
    this.margin,
    this.isLTR = false,
    this.prefix,
    this.suffix,
    this.titleHeight,
    this.titleFontSize,
    this.titleFontWeight,
    this.titleColor,
    this.hintText,
    this.spaceBetween,
    this.enableBorder = true,
    this.backgroundColor,
    this.border,
    this.onChanged,
    this.onTap,
    this.validator,
    this.readOnly = false, this.enabled,
  });

  final String title;
  final String? hintText;
  final double? titleHeight;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final Color? titleColor;
  final Color? backgroundColor;
  final TextEditingController controller;
  final bool isLTR;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType keyboardType;
  final EdgeInsets? margin;
  final double? spaceBetween;
  final bool enableBorder;
  final InputBorder? border;
  final Function(String nVal)? onChanged;
  final Function()? onTap;
  final bool readOnly;
  final bool? enabled;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: titleHeight == 0
                ? null
                : titleHeight ?? context.responsiveHeight(32),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: titleFontWeight ?? FontWeight.w500,
                fontSize: titleFontSize ?? 12,
                fontFamily: 'Alexandria',
                color: titleColor ?? AppColors.defaultBlack,
              ),
            ),
          ),
          if (spaceBetween != null)
            SizedBox(
              height: context.responsiveHeight(spaceBetween!),
            ),
          Directionality(
            textDirection: isLTR ? TextDirection.ltr : TextDirection.rtl,
            child: SizedBox(
              height: context.responsiveHeight(56),
              child: TextFormField(
                enabled: enabled,
                readOnly: readOnly,
                onTap: onTap,
                onChanged: onChanged,
                controller: controller,
                validator: validator,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Alexandria',
                  fontWeight: FontWeight.w400,
                  color: AppColors.defaultBlack,
                ),
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  filled: backgroundColor != null,
                  fillColor: backgroundColor,
                  prefixIcon: prefix,
                  suffixIcon: suffix,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Alexandria',
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey4,
                  ),
                  border: enableBorder
                      ? border ??
                          OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.grey4,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          )
                      : InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
