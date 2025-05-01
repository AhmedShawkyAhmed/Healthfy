// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';

class InsuranceDetailsScreen extends StatefulWidget {
  const InsuranceDetailsScreen({super.key});

  @override
  State<InsuranceDetailsScreen> createState() => _InsuranceDetailsScreenState();
}

class _InsuranceDetailsScreenState extends State<InsuranceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
              top: 40,
            ),
            margin: const EdgeInsets.only(bottom: 20),
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Text(
                    context.requestDetails,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.primaryOpacity,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        color: AppColors.defaultWhite,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.requestCode,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              ' JVP-1234#',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.copy,
                              color: AppColors.primary,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.defaultWhite,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: SvgPicture.asset(
                                AppAssets.icDone,
                                color: AppColors.defaultWhite,
                              ),
                            ),
                            Column(
                              children: List.generate(
                                  6,
                                  (index) => Column(
                                        children: [
                                          Container(
                                            height: 3,
                                            width: 1,
                                            color: AppColors.primary,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          )
                                        ],
                                      )),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primaryOpacity,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: SvgPicture.asset(
                                AppAssets.icShipping,
                                color: AppColors.primary,
                              ),
                            ),
                            Column(
                              children: List.generate(
                                  6,
                                  (index) => Column(
                                        children: [
                                          Container(
                                            height: 3,
                                            width: 1,
                                            color: AppColors.primary,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          )
                                        ],
                                      )),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primaryOpacity,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: SvgPicture.asset(
                                AppAssets.icDelivery,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        context.revisionStep,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        context.revisionDone,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryOpacity,
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: const Text(
                                      '1-5-2023 - 2:30 PM',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 36,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        context.shippingStep,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        context.yourRequestIsBeingPacked,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryOpacity,
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: Text(
                                      context.underProcessing,
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 36,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        context.deliveryStep,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        context.yourRequestIsBeingDelivered,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryOpacity,
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: Text(
                                      context.underProcessing,
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 80,
          left: 100,
          right: 100,
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Navigator.popUntil(context, ModalRoute.withName('/home'));
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                fixedSize: const Size(double.infinity, 56),
                backgroundColor: AppColors.defaultWhite),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.call,
                  color: AppColors.primary,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  context.communicateWithCustomerService,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
