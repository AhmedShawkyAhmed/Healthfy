import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthify/src/business_logic/package_cubit/package_cubit.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/enums.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';

import '../../../constants/colors.dart';
import '../../router/app_router_names.dart';
import '../../widgets/pick_image_bottom_sheet.dart';
import '../../widgets/text_input_field.dart';

class FamilyInsuranceScreen extends StatefulWidget {
  const FamilyInsuranceScreen({super.key});

  @override
  State<FamilyInsuranceScreen> createState() => _FamilyInsuranceScreenState();
}

class _FamilyInsuranceScreenState extends State<FamilyInsuranceScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  List<bool> selectedStatus = [false, false];
  String _radioValue = ''; //Initial definition of radio button value
  String? choice = '';

  void radioButtonChanges(String? value) {
    setState(() {
      _radioValue = value!;
      switch (value) {
        case 'single':
          choice = value;
          selectedStatus[0] = true;
          selectedStatus[1] = false;
          break;
        case 'married':
          choice = value;
          selectedStatus[1] = true;
          selectedStatus[0] = false;
          break;
        default:
          choice = null;
      }
    });
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
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
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
                              context.fillFamilyInfo,
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
                    PackageCubit.get(context).personImage == null
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
                                  File(PackageCubit.get(context)
                                      .personImage!
                                      .path),
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
                                    PackageCubit.get(context).personImage =
                                        image;
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
                            controller:
                                PackageCubit.get(context).fullNameController,
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
                                    controller: PackageCubit.get(context)
                                        .phoneController,
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
                            height: 16,
                          ),
                          Text(
                            context.maritalStatus,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: 'single',
                                      groupValue: _radioValue,
                                      onChanged: radioButtonChanges,
                                    ),
                                    Text(
                                      context.single,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 'married',
                                      groupValue: _radioValue,
                                      onChanged: radioButtonChanges,
                                    ),
                                    Text(
                                      context.married,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // if (PackageCubit.get(context).personImage != null) {
                    if (selectedStatus[0]) {
                      PackageCubit.get(context).married = false;
                      Navigator.pushNamed(
                          context, AppRouterNames.rFamilyInsuranceSingle);
                    } else if (selectedStatus[1]) {
                      PackageCubit.get(context).married = true;
                      Navigator.pushNamed(
                          context, AppRouterNames.rFamilyInsuranceMarried);
                    } else {
                      showToast(
                        "الحالة الاجتماعية مطلوبة",
                        ToastState.warning,
                      );
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
                  context.continueT,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
