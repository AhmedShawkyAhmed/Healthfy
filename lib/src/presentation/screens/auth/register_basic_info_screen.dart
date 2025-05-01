import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/data/request/register_request.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:intl/intl.dart';

import '../../router/app_router_names.dart';
import '../../widgets/text_input_field.dart';

class RegistrationBasic extends StatefulWidget {
  const RegistrationBasic({super.key});

  @override
  State<RegistrationBasic> createState() => _RegistrationBasicState();
}

class _RegistrationBasicState extends State<RegistrationBasic> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _dateController;

  final ValueNotifier<bool> _approved = ValueNotifier(false);
  final ValueNotifier<bool> _male = ValueNotifier(true);

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _dateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        context.happy,
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      FieldWithLabel(
                        label: 'الاسم',
                        controller: _nameController,
                      ),
                      const SizedBox(height: 15),
                      // FieldWithLabel(
                      //   label: 'البريد إلكتروني',
                      //   controller: _emailController,
                      //   keyboardType: TextInputType.emailAddress,
                      // ),
                      // const SizedBox(height: 15),
                      FieldWithLabel(
                        controller: _dateController,
                        label: 'تاريخ الميلاد',
                        readOnly: true,
                        onTap: () => showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1920),
                                lastDate: DateTime.now())
                            .then((value) => value != null
                                ? _dateController.text =
                                    DateFormat('yyyy/MM/dd').format(value)
                                : null),
                        suffix: const Icon(
                          Icons.date_range,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'ما هو جنسك ؟',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                        valueListenable: _male,
                        builder: (context, male, child) {
                          return Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () => _male.value = !male,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: male
                                          ? AppColors.grey6
                                          : AppColors.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'انثي',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: !male
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(Icons.female,
                                          color: !male
                                              ? Colors.white
                                              : Colors.black)
                                    ],
                                  ),
                                ),
                              )),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: InkWell(
                                onTap: () => _male.value = !male,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: !male
                                          ? AppColors.grey6
                                          : AppColors.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'ذكر',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: male
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        Icons.male,
                                        color:
                                            male ? Colors.white : Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        child: ValueListenableBuilder(
                          valueListenable: _approved,
                          builder: (context, approved, child) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () => _approved.value = !approved,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        color: approved
                                            ? AppColors.primaryGreen
                                            : AppColors.primaryGreen
                                                .withOpacity(.2),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'أوافق علي ',
                                        style: TextStyle(
                                            color: AppColors.grey1,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRouterNames.rTerms,
                                  ),
                                  child: const Text(
                                    'الشروط والأحكام',
                                    style: TextStyle(
                                        color: AppColors.primaryGreen,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * .03, horizontal: size.width * .05),
              child: SizedBox(
                width: double.infinity,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthRegisterSuccessState) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRouterNames.rRegisterDone,
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is AuthRegisterLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ValueListenableBuilder(
                            valueListenable: _nameController,
                            builder: (context, name, child) {
                              return ValueListenableBuilder(
                                  valueListenable: _dateController,
                                  builder: (context, date, child) {
                                    return ValueListenableBuilder(
                                        valueListenable: _approved,
                                        builder: (context, terms, child) {
                                          return ValueListenableBuilder(
                                              valueListenable: _emailController,
                                              builder: (context, email, child) {
                                                return ElevatedButton(
                                                  onPressed: terms &&
                                                          date.text
                                                              .isNotEmpty &&
                                                          name.text
                                                              .isNotEmpty
                                                      // &&
                                                      //     email.text.isNotEmpty
                                                      ? () {
                                                          final request =
                                                              RegisterRequest(
                                                            // email:
                                                            //     _emailController
                                                            //         .text,
                                                            name:
                                                                _nameController
                                                                    .text,
                                                            gender: _male.value
                                                                ? 1
                                                                : 0,
                                                            birthdate:
                                                                _dateController
                                                                    .text,
                                                          );
                                                          AuthCubit.get(context)
                                                              .register(
                                                            request: request,
                                                          );
                                                        }
                                                      : null,
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      fixedSize: const Size(
                                                          double.infinity, 60),
                                                      backgroundColor:
                                                          AppColors.primary),
                                                  child: Text(
                                                    context.follow,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                );
                                              });
                                        });
                                  });
                            });
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
