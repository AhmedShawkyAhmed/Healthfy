import 'package:flutter/material.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';

class InsuranceDoneScreen extends StatefulWidget {
  const InsuranceDoneScreen({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  final String startDate;
  final String endDate;

  @override
  State<InsuranceDoneScreen> createState() => _InsuranceDoneScreenState();
}

class _InsuranceDoneScreenState extends State<InsuranceDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60, bottom: 10),
                alignment: Alignment.bottomCenter,
                child: Image.asset(AppAssets.imgSubDone),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.congratsOnSubSuccess,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    context.cardIsDeliveredAfterAWeek,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    context.cardBenefits,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.defaultBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "يوفر لك كارت التامين السنوي خصومات تصل الي 60% مع كل الموسسات الطبية المتعاقدة معنا .",
                        style: TextStyle(
                          color: AppColors.defaultBlack,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "سهولة الاستفادة من الخصومات المقدمة  بدون اي اجراءات روتينية مع كل المؤسسات الطبية المتعاقدة معنا .",
                        style: TextStyle(
                          color: AppColors.defaultBlack,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    context.subStartDate,
                    // textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.defaultBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppColors.primaryOpacity,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      widget.startDate,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    context.subEndDate,
                    // textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.defaultBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppColors.primaryOpacity,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      widget.endDate,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(8)),
                  fixedSize: const Size(double.infinity, 56),
                  backgroundColor: AppColors.defaultWhite),
              child: Text(
                context.backHome,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.primary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
