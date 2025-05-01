import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';

class CostAfterDiscountView extends StatelessWidget {
  const CostAfterDiscountView({
    super.key,
    required this.oldCost,
    required this.newCost,
  });

  final String oldCost;
  final String newCost;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.responsiveHeight(70),
      decoration: BoxDecoration(
        color: AppColors.green1.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            oldCost,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Alexandria',
              fontWeight: FontWeight.w500,
              color: AppColors.grey3,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(
            width: context.responsiveWidth(10),
          ),
          Text(
            newCost,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Alexandria',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
