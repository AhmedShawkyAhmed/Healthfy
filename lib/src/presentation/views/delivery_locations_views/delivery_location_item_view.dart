import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';

class DeliveryLocationItemView extends StatelessWidget {
  const DeliveryLocationItemView({
    super.key,
    required this.title,
    required this.description,
    required this.isCurrentLocation,
    required this.delete,
  });

  final String title;
  final String description;
  final bool isCurrentLocation;
  final Function() delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveHeight(16),
        horizontal: context.responsiveWidth(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Alexandria',
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: context.responsiveHeight(12),
          ),
          Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Alexandria',
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: context.responsiveHeight(24),
          ),
          Row(
            children: [
              if (isCurrentLocation)
                Container(
                  height: context.responsiveHeight(28),
                  width: context.responsiveWidth(150),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: AppColors.blue1.withOpacity(0.07),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: context.responsiveWidth(8),
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      SizedBox(
                        width: context.responsiveWidth(12),
                      ),
                      const Text(
                        "عنواني الحالي",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Alexandria',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              const Spacer(),
              InkWell(
                onTap: delete,
                child: const Icon(
                  Icons.delete,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
