import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/medical_history_cubit/medical_history_cubit.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/router/history_arguments.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  @override
  void initState() {
    super.initState();
    MedicalHistoryCubit.get(context).getAllMedicalHistory();
  }

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
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
              bottom: 10,
            ),
            color: AppColors.primary,
            margin: const EdgeInsets.only(),
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
                    text: context.medicalRecord,
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.primaryOpacity,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10, top: 10),
              child: BlocBuilder<MedicalHistoryCubit, MedicalHistoryState>(
                builder: (context, state) {
                  final history = MedicalHistoryCubit.get(context).history;
                  return state is MedicalHistoryGetAllLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : history.isEmpty
                          ? Center(
                              child: DefaultAppText(
                                text: "Empty MedicalHistory",
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                              ),
                            )
                          : ListView.builder(
                              itemCount: history.length,
                              itemBuilder: (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: AppColors.blueTransparent,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(8),
                                      ),
                                    ),
                                    child: DefaultAppText(
                                      text:
                                          history[index].name ?? "Unknown Type",
                                      color: AppColors.blue1,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRouterNames.rXRayDetails,
                                        arguments: HistoryArguments(
                                          type: "view",
                                          medicalHistoryModel: history[index],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.only(bottom: 12),
                                      decoration: const BoxDecoration(
                                          color: AppColors.defaultWhite,
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(8))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              DefaultAppText(
                                                text: history[index]
                                                        .medicineType
                                                        ?.name ??
                                                    "Unknown OrganizationName",
                                                color: AppColors.primary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.primaryOpacity,
                                                  borderRadius:
                                                      BorderRadius.circular(80),
                                                ),
                                                child: Row(
                                                  children: [
                                                    DefaultAppText(
                                                      text: history[index]
                                                                  .medias!
                                                                  .isEmpty ||
                                                              history[index]
                                                                      .medias?[
                                                                          0]
                                                                      .createdAt ==
                                                                  null
                                                          ? "Unknown Time"
                                                          : DateFormat(
                                                                  "MMM dd, yyyy")
                                                              .format(
                                                              DateTime.parse(
                                                                history[index]
                                                                    .medias![0]
                                                                    .createdAt!,
                                                              ),
                                                            ),
                                                      color: AppColors.primary,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    DefaultAppText(
                                                      text: history[index]
                                                                  .medias!
                                                                  .isEmpty ||
                                                              history[index]
                                                                      .medias![
                                                                          0]
                                                                      .createdAt ==
                                                                  null
                                                          ? "Unknown Time"
                                                          : DateFormat(
                                                                  "hh:mm a")
                                                              .format(
                                                              DateTime.parse(
                                                                history[index]
                                                                    .medias![0]
                                                                    .createdAt!,
                                                              ),
                                                            ),
                                                      color: AppColors.primary,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRouterNames.rEndedReservation,
          );
        },
        backgroundColor: AppColors.primary,
        child: Icon(
          Icons.add,
          size: 8.w,
        ),
      ),
    );
  }
}
