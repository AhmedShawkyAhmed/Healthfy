import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/data/shared_models/service_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/views/common_views/custom_dropdown_button_view.dart';
import 'package:healthify/src/presentation/views/common_views/custom_form_field_view.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:sizer/sizer.dart';

class AdditionalServiceItemView extends StatelessWidget {
  const AdditionalServiceItemView({
    super.key,
    required this.index,
    required this.count,
    required this.serviceCostControllers,
    required this.servicesCount,
    required this.services,
    required this.serviceList,
    required this.discounts,
  });

  final int index;
  final int count;
  final List<TextEditingController> serviceCostControllers;
  final ValueNotifier<int> servicesCount;
  final List<ValueNotifier<ServiceModel?>> services;
  final List<ServiceModel> serviceList;
  final List<ValueNotifier<num?>> discounts;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: services[index],
              builder: (BuildContext context, value, Widget? child) {
                return CustomDropDownButtonView<ServiceModel>(
                  spaceBetween: 12,
                  titleHeight: 0,
                  value: value,
                  title: context.services,
                  hintText: context.servicesHint,
                  isLTR: false,
                  items: serviceList
                      .where(
                        (e) => !services.any(
                          (element) =>
                              element.value?.id == e.id &&
                              element.value?.id != services[index].value?.id,
                        ),
                      )
                      .map(
                        (e) => DropdownMenuItem<ServiceModel>(
                          value: e,
                          child: Text(
                            e.name ?? "Unknown service",
                            style: const TextStyle(
                              fontFamily: 'Alexandria',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (ServiceModel? nVal) {
                    services[index].value = nVal;
                    discounts[index].value = num.parse(nVal!.discount!);
                  },
                );
              },
            ),
            if ((index == 0 && count != 1) || count > 1)
              PositionedDirectional(
                end: 2.w,
                top: -0.3.h,
                child: InkWell(
                  onTap: () {
                    servicesCount.value--;
                    services.removeAt(index);
                    serviceCostControllers.removeAt(index);
                    discounts.removeAt(index);
                  },
                  child: const Icon(
                    Icons.close,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: context.responsiveHeight(12),
        ),
        CustomFormFieldView(
          spaceBetween: 12,
          titleHeight: 0,
          title: context.serviceCost,
          hintText: context.serviceCostHint,
          controller: serviceCostControllers[index],
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: context.responsiveHeight(24),
        ),
        Container(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            context.costAfterDiscount,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              fontFamily: 'Alexandria',
              color: AppColors.defaultBlack,
            ),
          ),
        ),
        SizedBox(
          height: context.responsiveHeight(12),
        ),
        ValueListenableBuilder(
          valueListenable: discounts[index],
          builder: (context, discount, child) {
            return ValueListenableBuilder(
              valueListenable: serviceCostControllers[index],
              builder: (context, cost, child) {
                final costNum = num.tryParse(cost.text);
                final finalCost = costNum == null
                    ? 0
                    : costNum - (costNum * (discount! / 100)).toInt();
                return Container(
                  height: context.responsiveHeight(56),
                  decoration: BoxDecoration(
                    color: AppColors.green1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: DefaultAppText(
                              text: costNum == null
                                  ? "0 جنية"
                                  : "$finalCost جنية",
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (costNum != null)
                            const WidgetSpan(
                              child: SizedBox(
                                width: 10,
                              ),
                            ),
                          if (costNum != null)
                            WidgetSpan(
                              child: DefaultAppText(
                                text: "$costNum جنية",
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppColors.grey3,
                                lineHeight: 2,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 3,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
