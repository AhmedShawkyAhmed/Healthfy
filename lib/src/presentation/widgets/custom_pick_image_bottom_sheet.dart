import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:image_picker/image_picker.dart';

class CustomPickImageBottomSheet extends StatelessWidget {
  const CustomPickImageBottomSheet({
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
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveWidth(20),
                vertical: context.responsiveHeight(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image,
                    color: AppColors.primary,
                  ),
                  const Spacer(),
                  Text(
                    context.gallery,
                    style: const TextStyle(
                      fontFamily: 'Alexandria',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              pickImage(
                source: ImageSource.camera,
                onImageSelect: selectImage,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveWidth(20),
                vertical: context.responsiveHeight(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.primary,
                  ),
                  const Spacer(),
                  Text(
                    context.camera,
                    style: const TextStyle(
                      fontFamily: 'Alexandria',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
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
