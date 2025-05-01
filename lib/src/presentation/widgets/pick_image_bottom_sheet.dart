import 'package:flutter/material.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/const_methods.dart';
import 'default_app_text.dart';

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet({
    Key? key,
    required this.selectImage,
  }) : super(key: key);

  final Function(XFile image) selectImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              pickImage(
                source: ImageSource.gallery,
                onImageSelect: selectImage,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image,
                    color: AppColors.primary,
                  ),
                  const Spacer(),
                  DefaultAppText(
                    text: context.gallery,
                    color: AppColors.primary,
                    fontSize: 15.sp,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          InkWell(
            onTap: () {
              pickImage(
                source: ImageSource.camera,
                onImageSelect: selectImage,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.primary,
                  ),
                  const Spacer(),
                  DefaultAppText(
                    text: context.camera,
                    color: AppColors.primary,
                    fontSize: 15.sp,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
