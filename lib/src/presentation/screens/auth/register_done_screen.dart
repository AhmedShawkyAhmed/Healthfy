import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';

class Done extends StatefulWidget {
  const Done({super.key});

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRouterNames.rHome, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(AppAssets.imgSignUpDone),
          const Text(
            'تهانينا',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const Text(
            'حسابك جاهز للإستخدام',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.grey2),
          ),
        ]),
      ),
    );
  }
}
