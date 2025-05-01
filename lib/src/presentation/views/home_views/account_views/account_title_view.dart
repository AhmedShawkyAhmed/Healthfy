import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';

class AccountTitleView extends StatelessWidget {
  const AccountTitleView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'Alexandria',
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
