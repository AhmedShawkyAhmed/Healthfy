// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthify/src/business_logic/package_cubit/package_cubit.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/enums.dart';
import 'package:healthify/src/data/models/person.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../widgets/text_input_field.dart';
import 'individual_insurance_screen.dart';

class FamilySingleInsuranceScreen extends StatefulWidget {
  const FamilySingleInsuranceScreen({super.key});

  @override
  State<FamilySingleInsuranceScreen> createState() =>
      _FamilySingleInsuranceScreenState();
}

class _FamilySingleInsuranceScreenState
    extends State<FamilySingleInsuranceScreen> {
  // TextEditingController broOrSisNameController = TextEditingController();
  final ValueNotifier<PaymentMethod> _paymentMethod = ValueNotifier(
    PaymentMethod.visa,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    log('rebuild');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.only(top: 40),
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
                    context.single,
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  FieldWithLabel(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const IndividualInsuranceScreen(type: 'father'),
                          ));
                    },
                    readOnly: true,
                    controller: PackageCubit.get(context).fatherNameController,
                    label: context.fatherName,
                    borderColor: AppColors.grey3,
                  ),
                  FieldWithLabel(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const IndividualInsuranceScreen(
                              type: 'mother',
                            ),
                          ));
                    },
                    readOnly: true,
                    controller: PackageCubit.get(context).motherNameController,
                    label: context.motherName,
                    borderColor: AppColors.grey3,
                  ),
                  Column(
                    children: List.generate(
                      PackageCubit.get(context).broOrSisNameControllers.length,
                      (index) => FieldWithLabel(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      IndividualInsuranceScreen(
                                    type: 'siblings',
                                    index: index,
                                  ),
                                ));
                          },
                          readOnly: true,
                          controller: PackageCubit.get(context)
                              .broOrSisNameControllers[index],
                          label: context.brotherOrSisterName,
                          borderColor: AppColors.grey3,
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                PackageCubit.get(context)
                                    .broOrSisNameControllers
                                    .removeAt(index);
                                PackageCubit.get(context)
                                    .siblings
                                    .removeAt(index);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.defaultWhite,
                                  border:
                                      Border.all(color: AppColors.defaultRed),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Icon(
                                Icons.close_rounded,
                                color: AppColors.defaultRed,
                                size: 15.sp,
                              ),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ValueListenableBuilder(
                    valueListenable: _paymentMethod,
                    builder: (context, paymentMethodValue, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          children: PaymentMethod.values
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    _paymentMethod.value = e;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Radio(
                                          activeColor: AppColors.primary,
                                          value: e,
                                          groupValue: paymentMethodValue,
                                          onChanged: (nVal) {
                                            _paymentMethod.value = nVal!;
                                          },
                                        ),
                                        DefaultAppText(
                                          text: getPaymentMethods(context)[e]!,
                                          color: AppColors.defaultBlack,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (PackageCubit.get(context)
                              .broOrSisNameControllers
                              .length <
                          2) {
                        setState(() {
                          PackageCubit.get(context)
                              .broOrSisNameControllers
                              .add(TextEditingController());
                          PackageCubit.get(context).siblings.add(Person());
                        });
                        logWarning(PackageCubit.get(context)
                            .broOrSisNameControllers
                            .length
                            .toString());
                      }
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      color: AppColors.primary,
                      dashPattern: const [3, 2],
                      padding: const EdgeInsets.all(6),
                      child: SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              context.enterMoreBrotherOrSisterName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                ],
              ),
            ),
          ),
        ],
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
            onPressed: () async {
              final myLocation = await getCurrentPosition(force: true);
              if (myLocation == null) {
                "يجب تفعيل الموقع لاكمال الخطوات!".toToastWarning();
              }
              if (myLocation != null) {
                PackageCubit.get(context).addUserToPackage(
                    subscriptionId: 2,
                    person: Person(
                        name: PackageCubit.get(context).fullNameController.text,
                        imagePath: PackageCubit.get(context).personImage?.path,
                        mobile: PackageCubit.get(context).phoneController.text),
                    married: 0,
                    afterSuccess: () {
                      logSuccess('Succcesss add to subs');
                      // PackageCubit.get(context).idle();
                    });
                final location = myLocation[1] as Placemark;
                final address = "${location.locality}, "
                    "${location.subLocality}, "
                    "${location.street}";
                final lat = (myLocation[0] as Position).latitude;
                final lon = (myLocation[0] as Position).longitude;
                final data = (await PackageCubit.get(context).pay(
                  packageId: 2,
                  paymentType: _paymentMethod.value == PaymentMethod.visa
                      ? 1
                      : _paymentMethod.value == PaymentMethod.cash
                          ? 0
                          : 2,
                  deliveryAddress: address,
                  deliveryLatitude: lat,
                  deliveryLongitude: lon,
                  afterSuccess: () {},
                ))['data']['data'];
                final link = data['link'];
                if (_paymentMethod.value == PaymentMethod.visa ||
                    _paymentMethod.value == PaymentMethod.e_Wallet) {
                  logWarning(link ?? 'no link');
                  if (link != null && context.mounted) {
                    final result = await Navigator.pushNamed(
                      context,
                      AppRouterNames.rChargeBalance,
                      arguments: link,
                    ) as bool?;
                    if (context.mounted && result == true) {
                      setState(() {
                        PackageCubit.get(context).idle();
                      });
                      Navigator.pushNamed(
                        context,
                        AppRouterNames.rInsuranceDone,
                        arguments: [
                          data['start_date'] as String,
                          data['end_date'] as String,
                        ],
                      );
                    }
                  }
                } else {
                  setState(() {
                    PackageCubit.get(context).idle();
                  });
                  Navigator.pushNamed(
                    context,
                    AppRouterNames.rInsuranceDone,
                    arguments: [
                      data['start_date'] as String,
                      data['end_date'] as String,
                    ],
                  );
                  // Navigator.popUntil(context, (route) => route.isFirst);
                }
              }
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                fixedSize: const Size(double.infinity, 56),
                backgroundColor: AppColors.primary),
            child: Text(
              context.continueT,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
