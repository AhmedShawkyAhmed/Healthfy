import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthify/src/business_logic/medicine_type_cubit/medicine_type_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/models/category_model.dart';
import 'package:healthify/src/data/shared_models/specialty_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/widgets/text_input_field.dart';
import 'package:sizer/sizer.dart';

import '../../router/app_router_names.dart';
import '../../widgets/default_app_text.dart';

class ClinicsScreen extends StatefulWidget {
  const ClinicsScreen({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  State<ClinicsScreen> createState() => _ClinicsScreenState();
}

class _ClinicsScreenState extends State<ClinicsScreen> {
  List<SpecialtyModel> mostChosenSpecialities = [];
  List<SpecialtyModel> otherSpecialities = [];
  TextEditingController searchController = TextEditingController();
  bool search = false;

  @override
  void initState() {
    super.initState();
    if (MedicineTypeCubit.get(context).otherSpecialties.isEmpty ||
        MedicineTypeCubit.get(context).mostChosenSpecialities.isEmpty) {
      MedicineTypeCubit.get(context).getSpecialties();
    }
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
      backgroundColor: AppColors.defaultWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.only(top: 40, bottom: 10),
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
                    text: widget.category.nameAr!,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      search = !search;
                    });
                  },
                  icon: Icon(
                    search ? Icons.close : Icons.search_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (search) ...[
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 1.h),
              child: FieldWithLabel(
                fillColor: Colors.white,
                controller: searchController,
                filled: true,
                prefix: const Icon(
                  Icons.search,
                  color: AppColors.grey3,
                ),
                label: 'ابحث عن تخصص ...',
                hasLabel: false,
                cursorColor: AppColors.grey3,
                borderColor: AppColors.grey4,
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.all(5.w),
            child: DefaultAppText(
              text: context.specializations,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.primaryOpacity,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
              child: BlocBuilder<MedicineTypeCubit, MedicineTypeState>(
                builder: (context, state) {
                  final cubit = MedicineTypeCubit.get(context);
                  final mostChosenSpecialtyList = cubit.mostChosenSpecialities;
                  final otherSpecialtyList = cubit.otherSpecialties;
                  return state is MedicineTypeGetSpecialtiesLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ValueListenableBuilder(
                          valueListenable: searchController,
                          builder: (context, text, child) {
                            if (text.text.trim().isNotEmpty) {
                              mostChosenSpecialities = mostChosenSpecialtyList
                                  .where(
                                    (element) =>
                                        element.title!.contains(text.text),
                                  )
                                  .toList();
                              otherSpecialities = otherSpecialtyList
                                  .where(
                                    (element) =>
                                        element.title!.contains(text.text),
                                  )
                                  .toList();
                            } else {
                              mostChosenSpecialities = mostChosenSpecialtyList;
                              otherSpecialities = otherSpecialtyList;
                            }
                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => index == 1
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 3.w,
                                      ),
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: const DefaultAppText(
                                        text: "الاكثر اختيارا",
                                        textAlign: TextAlign.center,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : index == mostChosenSpecialities.length + 2
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 3.w,
                                          ),
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: const DefaultAppText(
                                            text: "اخرى",
                                            textAlign: TextAlign.center,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.underline,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            if (index != 0) {
                                              MedicineTypeCubit.get(context)
                                                  .increaseSpecialityFrequency(
                                                specialtyId: (index > 1 &&
                                                            index <=
                                                                mostChosenSpecialities
                                                                        .length +
                                                                    1
                                                        ? mostChosenSpecialities[
                                                            index - 2]
                                                        : otherSpecialities[index -
                                                            (mostChosenSpecialities
                                                                    .length +
                                                                3)])
                                                    .id!,
                                              );
                                            }
                                            Navigator.pushNamed(
                                              context,
                                              AppRouterNames.rLocationRegions,
                                              arguments: [
                                                widget.category,
                                                index == 0
                                                    ? null
                                                    : index > 1 &&
                                                            index <=
                                                                mostChosenSpecialities
                                                                        .length +
                                                                    1
                                                        ? mostChosenSpecialities[
                                                            index - 2]
                                                        : otherSpecialities[index -
                                                            (mostChosenSpecialities
                                                                    .length +
                                                                3)],
                                              ],
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                                vertical: 0.5.h),
                                            decoration: BoxDecoration(
                                              color: AppColors.defaultWhite,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment
                                              //         .spaceBetween,
                                              children: [
                                                if (index != 0 &&
                                                    (index > 1 &&
                                                                    index <=
                                                                        mostChosenSpecialities.length +
                                                                            1
                                                                ? mostChosenSpecialities[
                                                                    index - 2]
                                                                : otherSpecialities[index -
                                                                    (mostChosenSpecialities
                                                                            .length +
                                                                        3)])
                                                            .icon !=
                                                        null)
                                                  SvgPicture.network(
                                                    EndPoints
                                                            .imageBaseUrlGlobal +
                                                        (index > 1 &&
                                                                    index <=
                                                                        mostChosenSpecialities.length +
                                                                            1
                                                                ? mostChosenSpecialities[
                                                                    index - 2]
                                                                : otherSpecialities[index -
                                                                    (mostChosenSpecialities
                                                                            .length +
                                                                        3)])
                                                            .icon!,
                                                    placeholderBuilder: (_) =>
                                                        const Icon(
                                                      Icons.image,
                                                      color: AppColors.primary,
                                                    ),
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart,
                                                    child: DefaultAppText(
                                                      text: index == 0
                                                          ? "جميع التخصصات"
                                                          : (index > 1 &&
                                                                          index <=
                                                                              mostChosenSpecialities.length +
                                                                                  1
                                                                      ? mostChosenSpecialities[
                                                                          index -
                                                                              2]
                                                                      : otherSpecialities[index -
                                                                          (mostChosenSpecialities.length +
                                                                              3)])
                                                                  .title ??
                                                              "Unknown",
                                                      textAlign:
                                                          TextAlign.center,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 1.h,
                                );
                              },
                              itemCount: mostChosenSpecialities.length +
                                  otherSpecialities.length +
                                  3,
                            );
                          },
                        );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
