import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthify/src/business_logic/points_cubit/points_cubit.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:sizer/sizer.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
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
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
              top: 40,
            ),
            color: AppColors.primary,
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
                  child: DefaultAppText(
                    text: context.points,
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Container(
              color: AppColors.primaryOpacity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultAppText(
                                    text: context.myBalance,
                                    color: AppColors.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  BlocBuilder<PointsCubit, PointsState>(
                                    builder: (context, state) {
                                      final points =
                                          PointsCubit.get(context).pointsModel;
                                      return DefaultAppText(
                                        text: context.point(
                                          "${num.tryParse("${points?.points}") ?? 0.0}",
                                        ),
                                        color: AppColors.primary,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.icError),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      DefaultAppText(
                                        text: context.validityPeriod('شهر'),
                                        color: AppColors.orange,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 95,
                                width: 95,
                                child: Image.asset(AppAssets.imgPoints),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: AppColors.defaultWhite,
                              border: Border.all(color: AppColors.grey6),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryOpacity,
                                    borderRadius: BorderRadius.circular(50)),
                                child: SvgPicture.asset(AppAssets.icQRReader),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultAppText(
                                    text: context.howToGetPoints,
                                    color: AppColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  DefaultAppText(
                                    text: context.getPointsWhenScanQR,
                                    color: AppColors.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultAppText(
                            text: context.transactions,
                            color: AppColors.defaultBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: BlocBuilder<PointsCubit, PointsState>(
                              builder: (context, state) {
                                final points =
                                    PointsCubit.get(context).pointsModel;
                                return points?.transaction?.isNotEmpty == true
                                    ? ListView.builder(
                                        itemCount:
                                            points?.transaction?.length ?? 0,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          padding: const EdgeInsets.all(20),
                                          margin:
                                              const EdgeInsets.only(bottom: 12),
                                          decoration: BoxDecoration(
                                              color: AppColors.defaultWhite,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: 56,
                                                  width: 56,
                                                  child: Image.asset(AppAssets
                                                      .imgClinicCheck)),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        DefaultAppText(
                                                          text: context
                                                              .clinicCheck,
                                                          color:
                                                              AppColors.primary,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .primaryOpacity,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        80),
                                                          ),
                                                          child:
                                                              const DefaultAppText(
                                                            text: '12-3-2023',
                                                            color: AppColors
                                                                .primary,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        DefaultAppText(
                                                          text: context
                                                              .point('100'),
                                                          color:
                                                              AppColors.primary,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        DefaultAppText(
                                                          text: index == 0
                                                              ? context.earned
                                                              : context
                                                                  .outOfDate,
                                                          color: index == 0
                                                              ? AppColors.green
                                                              : AppColors
                                                                  .defaultRed,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: DefaultAppText(
                                          text: "Empty Transactions",
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                              },
                            ),
                          )
                        ],
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
                            BlocBuilder<PointsCubit, PointsState>(
                              builder: (context, state) {
                                final points =
                                    PointsCubit.get(context).pointsModel;
                                return DefaultAppText(
                                  text:
                                      context.point("${points?.points ?? 0.0}"),
                                  color: AppColors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                );
                              },
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
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRouterNames.rPartners);
                              },
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
