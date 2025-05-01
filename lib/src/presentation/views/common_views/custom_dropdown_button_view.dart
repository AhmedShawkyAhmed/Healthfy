import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';

class CustomDropDownButtonView<T> extends StatelessWidget {
  const CustomDropDownButtonView({
    super.key,
    required this.title,
    this.hintText,
    this.titleHeight,
    this.titleFontSize,
    this.titleFontWeight,
    this.titleColor,
    required this.isLTR,
    this.margin,
    this.value,
    this.spaceBetween,
    required this.items,
    required this.onChanged,
  });

  final String title;
  final String? hintText;
  final double? titleHeight;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final Color? titleColor;
  final bool isLTR;
  final EdgeInsets? margin;
  final double? spaceBetween;
  final List<DropdownMenuItem<T>> items;
  final Function(T? nVal) onChanged;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Container(
              height: context.responsiveHeight(56),
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveHeight(16),
                vertical: context.responsiveHeight(16),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.grey4,
                  width: 2,
                ),
              ),
              child: DropdownButton<T>(
                isExpanded: true,
                value: value,
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                ),
                hint: hintText != null
                    ? Text(
                        hintText!,
                        style: const TextStyle(
                          fontFamily: 'Alexandria',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      )
                    : null,
                items: items,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
