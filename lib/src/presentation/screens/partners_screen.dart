import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';

import '../../constants/colors.dart';

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({super.key});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(top: 40),
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: DefaultAppText(
                    text: context.partners,
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
          ),
          Expanded(
            child: Container(
              color: AppColors.primaryOpacity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: DefaultAppText(
                        text: context.youCanUsePointsWithPartners,
                        color: AppColors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            1,
                            (index) => Container(
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                  color: AppColors.defaultWhite,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const DefaultAppText(
                                            text: 'صيدلية العزبي',
                                            color: AppColors.primary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SvgPicture.asset(AppAssets.icVerified)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      DefaultAppText(
                                        text: context.usable,
                                        color: AppColors.green,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DefaultAppText(
                                        text: context.point('100'),
                                        color: AppColors.primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      SizedBox(
                                          height: 32,
                                          width: 32,
                                          child: Image.asset(AppAssets.imgCoin))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: AppColors.defaultWhite,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(8))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DefaultAppText(
                              text: context.totalPoints,
                              color: AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            DefaultAppText(
                              text: context.point('100'),
                              color: AppColors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  fixedSize: const Size(double.infinity, 56),
                                  backgroundColor: AppColors.primary),
                              child: DefaultAppText(
                                text: context.usePoints,
                                fontWeight: FontWeight.w600,
                                color: AppColors.defaultWhite,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
