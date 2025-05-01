import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:sizer/sizer.dart';

class FieldWithLabel extends StatelessWidget {
  const FieldWithLabel({
    super.key,
    required this.label,
    this.onTap,
    this.readOnly = false,
    this.hasLabel = true,
    this.suffix,
    this.prefix,
    this.cursorColor = AppColors.primary,
    this.borderColor = AppColors.primary,
    this.controller,
    this.filled = false,
    this.fillColor,
    this.keyboardType,
    this.height,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.onChange,
    this.textInputAction,
    this.onEditingComplete,
    this.hintColor = Colors.grey,
    this.validator,
    this.style,
    this.contentPadding,
  });

  // : assert((hasLabel && label != null) || (!hasLabel && label == null),
  //           'should provide label if it has label');
  final String label;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool filled;
  final bool hasLabel;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final Color cursorColor;
  final Color? fillColor;
  final Color borderColor;
  final Color hintColor;
  final TextEditingController? controller;
  final double? height;
  final Function(PointerDownEvent event)? onTapOutside;
  final Function(String val)? onFieldSubmitted;
  final Function(String val)? onChange;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Function()? onEditingComplete;
  final TextStyle? style;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 1),
        if (hasLabel)
          DefaultAppText(
              text: label, fontSize: 12, fontWeight: FontWeight.w600),
        const SizedBox(height: 8),
        SizedBox(
          height: height ?? 6.h,
          child: TextFormField(
            onTapOutside: onTapOutside,
            readOnly: readOnly,
            onTap: onTap,
            validator: validator,
            controller: controller,
            cursorColor: cursorColor,
            keyboardType: keyboardType,
            onFieldSubmitted: onFieldSubmitted,
            textInputAction: textInputAction,
            onEditingComplete: onEditingComplete,
            onChanged: onChange,
            style: style,
            decoration: InputDecoration(
              contentPadding: contentPadding,
              fillColor: fillColor,
              filled: filled,
              prefixIcon: prefix,
              hintText: hasLabel ? '' : label,
              hintStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: hintColor,
              ),
              suffixIcon: suffix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor, width: 1.8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor, width: 1.8),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: AppColors.defaultRed, width: 1.8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: AppColors.defaultRed, width: 1.8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor, width: 1.8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
