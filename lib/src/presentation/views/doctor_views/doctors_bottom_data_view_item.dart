import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:sizer/sizer.dart';

class DoctorsBottomDataViewItem extends StatelessWidget {
  const DoctorsBottomDataViewItem({
    super.key,
    this.subtitle,
    this.subtitleColor,
    required this.title,
    this.leading,
    this.trailing,
    this.expansions,
    this.onTap,
    this.backgroundColor,
    this.padding,
  });

  final String? subtitle;
  final Color? subtitleColor;
  final Color? backgroundColor;
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget>? expansions;
  final Function()? onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 0.5.h,
          ),
      child: InkWell(
        onTap: onTap,
        child: IgnorePointer(
          ignoring: onTap != null,
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: backgroundColor ?? AppColors.defaultWhite,
            collapsedBackgroundColor: backgroundColor ?? AppColors.defaultWhite,
            leading: leading != null
                ? Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppColors.primaryOpacity,
                        borderRadius: BorderRadius.circular(100)),
                    child: leading,
                  )
                : null,
            title: Row(
              children: [
                FittedBox(
                  child: DefaultAppText(
                    text: title,
                    textAlign: TextAlign.center,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                if (subtitle != null)
                  Expanded(
                    child: DefaultAppText(
                      text: subtitle!,
                      fontSize: 10,
                      color: subtitleColor ?? AppColors.grey2,
                      fontWeight: FontWeight.w500,
                    ),
                  )
              ],
            ),
            trailing: trailing,
            children: expansions ?? [],
          ),
        ),
      ),
    );
  }
}
