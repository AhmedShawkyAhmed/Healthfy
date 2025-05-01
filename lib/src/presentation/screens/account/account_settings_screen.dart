import 'dart:io';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/data/request/update_profile_request.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/views/account_settings_views/account_setting_country_code_button.dart';
import 'package:healthify/src/presentation/views/account_settings_views/account_settings_image_view.dart';
import 'package:healthify/src/presentation/views/account_settings_views/delete_account_confirm_dialog.dart';
import 'package:healthify/src/presentation/views/common_views/custom_form_field_view.dart';
import 'package:healthify/src/presentation/widgets/custom_button.dart';
import 'package:healthify/src/presentation/widgets/custom_country_picker_dialog.dart';
import 'package:healthify/src/presentation/widgets/custom_pick_image_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthdateController = TextEditingController();

  late Country _country;

  late ValueNotifier<XFile?> _image;
  late final String? _userImage;

  @override
  void initState() {
    super.initState();
    final user = AuthCubit.get(context).user;
    _country = CountryPickerUtils.getCountryByPhoneCode('20');
    _image = ValueNotifier(null);
    _phoneController.text = user!.phone ?? "";
    _nameController.text = user.name ?? "";
    _emailController.text = user.email ?? "";
    _birthdateController.text = user.birth ?? "";
    _userImage = user.image != null && user.image?.isNotEmpty == true
        ? "${EndPoints.imageBaseUrlGlobal}${user.image}"
        : null;
  }

  void _showCountryPicker() => showDialog(
        context: context,
        builder: (context) => CustomCountryPickerDialog(
          onCountryPicked: (Country country) =>
              setState(() => _country = country),
        ),
      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.defaultWhite,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          context.accountSettings,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultWhite,
            fontWeight: FontWeight.w500,
            fontFamily: "Alexandria",
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          context.responsiveWidth(16),
          10,
          context.responsiveWidth(16),
          10,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: _image,
                builder: (BuildContext context, XFile? value, Widget? child) {
                  return Stack(
                    children: [
                      AccountSettingImageView(
                        image: value != null
                            ? Image.file(
                                File(value.path),
                                fit: BoxFit.cover,
                              )
                            : _userImage != null
                                ? Image.network(
                                    _userImage!,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                        changeImage: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            builder: (_) => CustomPickImageBottomSheet(
                              selectImage: (image) {
                                _image.value = image;
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                        userId: "${AuthCubit.get(context).user?.id}",
                      ),
                      if (value != null)
                        Positioned(
                          top: 2.h,
                          right: 33.w,
                          child: Material(
                            type: MaterialType.circle,
                            color: AppColors.red,
                            child: InkWell(
                              onTap: () => _image.value = null,
                              child: const Icon(
                                Icons.close,
                                color: AppColors.defaultWhite,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              IgnorePointer(
                ignoring: true,
                child: CustomFormFieldView(
                  keyboardType: TextInputType.phone,
                  prefix: AccountSettingCountryCodeButton(
                    country: _country,
                    showCountryPicker: _showCountryPicker,
                  ),
                  isLTR: true,
                  readOnly: false,
                  controller: _phoneController,
                  title: context.enterPhoneNumber,
                  margin: EdgeInsets.only(
                    bottom: context.responsiveHeight(12),
                  ),
                ),
              ),
              CustomFormFieldView(
                keyboardType: TextInputType.name,
                controller: _nameController,
                title: context.name,
                margin: EdgeInsets.only(
                  bottom: context.responsiveHeight(12),
                ),
              ),
              CustomFormFieldView(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                title: context.emailAddress,
                margin: EdgeInsets.only(
                  bottom: context.responsiveHeight(12),
                ),
              ),
              CustomFormFieldView(
                keyboardType: TextInputType.datetime,
                suffix: const Icon(
                  Icons.date_range,
                  color: AppColors.primary,
                ),
                onTap: () => showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1920),
                        lastDate: DateTime.now())
                    .then((value) => value != null
                        ? _birthdateController.text =
                            DateFormat('yyyy/MM/dd').format(value)
                        : null),
                readOnly: true,
                controller: _birthdateController,
                title: context.birthdate,
                margin: EdgeInsets.only(
                  bottom: context.responsiveHeight(24),
                ),
              ),
              SizedBox(
                height: context.responsiveHeight(24),
              ),
              Container(
                height: context.responsiveHeight(104),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: context.responsiveHeight(24),
                ),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthUpdateProfileSuccessState) {
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return state is AuthUpdateProfileLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ValueListenableBuilder(
                            valueListenable: _nameController,
                            builder: (context, name, child) {
                              return ValueListenableBuilder(
                                valueListenable: _emailController,
                                builder: (context, email, child) {
                                  return ValueListenableBuilder(
                                    valueListenable: _birthdateController,
                                    builder: (context, birthdate, child) {
                                      final enabled = name.text.isNotEmpty &&
                                          email.text.isNotEmpty &&
                                          birthdate.text.isNotEmpty;
                                      return CustomButton(
                                        backgroundColor:
                                            enabled ? null : AppColors.grey4,
                                        text: context.saveChanges,
                                        onTap: enabled
                                            ? () {
                                                final request =
                                                    UpdateProfileRequest(
                                                  email: _emailController.text,
                                                  name: _nameController.text,
                                                  birthdate:
                                                      _birthdateController.text,
                                                  image: _image.value?.path,
                                                );
                                                AuthCubit.get(context)
                                                    .updateProfile(
                                                  request: request,
                                                );
                                              }
                                            : null,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                  },
                ),
              ),
              CustomButton(
                backgroundColor: AppColors.defaultRed,
                text: context.delete(context.account),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => const DeleteAccountConfirmDialog(),
                  );
                },
              ),
              SizedBox(
                height: context.responsiveHeight(8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
