// ignore_for_file: use_build_context_synchronously

import 'dart:io';

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
import 'package:image_picker/image_picker.dart';

import '../../../constants/colors.dart';
import '../../widgets/pick_image_bottom_sheet.dart';
import '../../widgets/text_input_field.dart';

class IndividualInsuranceScreen extends StatefulWidget {
  final String? type;
  final int? index;

  const IndividualInsuranceScreen({super.key, this.type, this.index});

  @override
  State<IndividualInsuranceScreen> createState() =>
      _IndividualInsuranceScreenState();
}

class _IndividualInsuranceScreenState extends State<IndividualInsuranceScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  final ValueNotifier<PaymentMethod> _paymentMethod = ValueNotifier(
    PaymentMethod.visa,
  );

  XFile? personImage;

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
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 40),
                      margin: const EdgeInsets.only(bottom: 20),
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
                            child: Text(
                              widget.type == null
                                  ? context.individualInsurance
                                  : 'معلومات الشخص',
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
                    personImage == null
                        ? DottedBorder(
                            borderType: BorderType.Circle,
                            dashPattern: const [4, 3],
                            color: AppColors.primary,
                            child: const Center(
                              child: SizedBox(
                                height: 130,
                                width: 130,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: SizedBox(
                              height: 130,
                              width: 130,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  File(personImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 110),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(35),
                                topLeft: Radius.circular(35),
                              )),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              builder: (_) => PickImageBottomSheet(
                                selectImage: (image) {
                                  Navigator.pop(context);
                                  setState(() {
                                    personImage = image;
                                  });
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              fixedSize: const Size(double.infinity, 39),
                              backgroundColor: AppColors.primary),
                          child: Text(
                            context.addPhoto,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          FieldWithLabel(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'this field is required';
                              } else {
                                return null;
                              }
                            },
                            controller: fullNameController,
                            label: context.fullName,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              context.enterPhoneNumber,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Container(
                              height: 56,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.primary, width: 1.8)),
                              child: Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      alignment: Alignment.center,
                                      height: double.infinity,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: AppColors.primary,
                                                width: 1.8)),
                                        color: AppColors.defaultTransparent,
                                      ),
                                      child: RichText(
                                          text: const TextSpan(
                                              text: '🇪🇬',
                                              children: [
                                            TextSpan(
                                                text: ' +20',
                                                style: TextStyle(
                                                    color: Colors.black))
                                          ]))),
                                  Expanded(
                                      child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'this field is required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.phone,
                                    controller: phoneController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(
                                          '[0-9]',
                                        ),
                                      )
                                    ],
                                    maxLength: 10,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      isCollapsed: true,
                                      counter: null,
                                      counterText: '',
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: '1xx xxx xxxx',
                                    ),
                                  )),
                                ],
                              ),
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
                                                  activeColor:
                                                      AppColors.primary,
                                                  value: e,
                                                  groupValue:
                                                      paymentMethodValue,
                                                  onChanged: (nVal) {
                                                    _paymentMethod.value =
                                                        nVal!;
                                                  },
                                                ),
                                                DefaultAppText(
                                                  text: getPaymentMethods(
                                                      context)[e]!,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    // if (personImage != null) {
                    final myLocation = await getCurrentPosition(force: true);
                    if (myLocation == null) {
                      "يجب تفعيل الموقع لاكمال الخطوات!".toToastWarning();
                    }
                    if (widget.type == null && myLocation != null) {
                      PackageCubit.get(context).addUserToPackage(
                          subscriptionId: 1,
                          person: Person(
                              name: fullNameController.text,
                              imagePath: personImage?.path,
                              mobile: phoneController.text),
                          married: 0,
                          afterSuccess: () {
                            logSuccess('Succcesss add to subs');
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
                      //Navigator.pushNamed(context, AppRouterNames.rPayment);
                    } else {
                      switch (widget.type) {
                        case 'father':
                          PackageCubit.get(context).father = Person(
                              name: fullNameController.text,
                              imagePath: personImage?.path,
                              mobile: phoneController.text);
                          PackageCubit.get(context).fatherNameController.text =
                              fullNameController.text;
                          break;
                        case 'mother':
                          PackageCubit.get(context).mother = Person(
                              name: fullNameController.text,
                              imagePath: personImage?.path,
                              mobile: phoneController.text);
                          PackageCubit.get(context).motherNameController.text =
                              fullNameController.text;

                          break;
                        case 'siblings':
                          PackageCubit.get(context).siblings[widget.index!] =
                              Person(
                                  name: fullNameController.text,
                                  imagePath: personImage?.path,
                                  mobile: phoneController.text);
                          PackageCubit.get(context)
                              .broOrSisNameControllers[widget.index!]
                              .text = fullNameController.text;

                          break;
                        case 'children':
                          PackageCubit.get(context).children[widget.index!] =
                              Person(
                                  name: fullNameController.text,
                                  imagePath: personImage?.path,
                                  mobile: phoneController.text);
                          PackageCubit.get(context)
                              .sonOrDaughterNameControllers[widget.index!]
                              .text = fullNameController.text;

                          break;
                        case 'partner':
                          PackageCubit.get(context).partner = Person(
                              name: fullNameController.text,
                              imagePath: personImage?.path,
                              mobile: phoneController.text);
                          PackageCubit.get(context).partnerController.text =
                              fullNameController.text;

                          break;
                        case 'parents':
                          PackageCubit.get(context)
                                  .motherAndFather[widget.index!] =
                              Person(
                                  name: fullNameController.text,
                                  imagePath: personImage?.path,
                                  mobile: phoneController.text);
                          PackageCubit.get(context)
                              .fatherOrMotherNameControllers[widget.index!]
                              .text = fullNameController.text;
                          break;
                        default:
                      }

                      Navigator.pop(context);
                    }
                    // } else {
                    //   showToast('Image is required', ToastState.warning);
                    // }
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    fixedSize: const Size(double.infinity, 56),
                    backgroundColor: AppColors.primary),
                child: Text(
                  widget.type == null ? context.continueT : 'تأكيد',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
