import 'package:flutter/material.dart';
import 'package:healthify/src/business_logic/app_cubit/app_cubit.dart';

import '../../constants/colors.dart';

class DefaultAppText extends StatelessWidget {
  const DefaultAppText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textDirection,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.overflow,
    this.letterSpacing,
    this.backgroundColor,
    this.wordSpacing,
    this.softWrap,
    this.lineHeight,
    this.maxLines,
    this.decoration,
    this.decorationThickness,
    this.onTap,
  }) : super(key: key);

  final String text;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final Color? backgroundColor;
  final double? wordSpacing;
  final double? lineHeight;
  final double? decorationThickness;
  final int? maxLines;
  final bool? softWrap;
  final TextDecoration? decoration;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        textAlign: textAlign,
        textDirection: textDirection,
        overflow: overflow,
        maxLines: maxLines,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: 'Alexandria',
          color: color ??
              (AppCubit.get(context).isDark
                  ? AppColors.defaultWhite
                  : AppColors.defaultBlack),
          height: lineHeight,
          letterSpacing: letterSpacing,
          backgroundColor: backgroundColor,
          wordSpacing: wordSpacing,
          decorationThickness: decorationThickness,
          decoration: decoration ?? TextDecoration.none,
        ),
        softWrap: softWrap,
      ),
    );
  }
}
