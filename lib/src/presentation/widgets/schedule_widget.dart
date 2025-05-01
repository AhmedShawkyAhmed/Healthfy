import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/data/shared_models/schedule_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:sizer/sizer.dart';

import 'default_app_text.dart';

class ScheduleWidget extends StatelessWidget {
  final ScheduleModel scheduleModel;
  final Function({int? i})? onTap;
  final bool book;
  final bool loading;

  const ScheduleWidget({
    required this.scheduleModel,
    super.key,
    this.onTap,
    this.book = false,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18.h,
      width: (scheduleModel.period?.length ?? 1) * 28.w,
      margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
      decoration: BoxDecoration(
        color: AppColors.grey6,
        border: Border.all(color: AppColors.bGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primary,
            alignment: AlignmentDirectional.center,
            height: 4.h,
            child: DefaultAppText(
              text: scheduleModel.day ?? "",
              color: AppColors.defaultWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: scheduleModel.period?.length ?? 0,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: onTap != null ? () => onTap!(i: index) : null,
                  child: Container(
                    width: 25.w,
                    height: 7.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultAppText(
                              text:
                                  "من  ${scheduleModel.period![index].from?.trim()}",
                              color: AppColors.defaultBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DefaultAppText(
                              text:
                                  "إلى  ${scheduleModel.period![index].to?.trim()}",
                              color: AppColors.defaultBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (book)
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: AppColors.primary,
                    ),
                    alignment: AlignmentDirectional.center,
                    height: 4.h,
                    child: InkWell(
                      onTap: onTap != null ? () => onTap!() : null,
                      child: Center(
                        child: DefaultAppText(
                          text: context.book,
                          color: AppColors.defaultWhite,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
        ],
      ),
    );
  }
}
