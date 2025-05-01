import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:sizer/sizer.dart';

class HospitalDoctorView extends StatelessWidget {
  final String image;
  final String name;
  final String department;

  const HospitalDoctorView({
    Key? key,
    required this.image,
    required this.name,
    required this.department,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28.w,
      height: 15.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              color: AppColors.defaultTransparent,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (c, o, s) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Icon(
                        Icons.image,
                        size: 100,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DefaultAppText(
              text: name,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 3,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DefaultAppText(
              text: department,
              textAlign: TextAlign.center,
              fontSize: 8,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
