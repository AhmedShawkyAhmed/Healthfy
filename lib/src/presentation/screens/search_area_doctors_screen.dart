// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthify/src/business_logic/medicine_type_cubit/medicine_type_cubit.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/models/category_model.dart';
import 'package:healthify/src/data/models/medicine_type_doctors_model.dart';
import 'package:healthify/src/data/request/medicine_type_request.dart';
import 'package:healthify/src/data/shared_models/city_model.dart';
import 'package:healthify/src/data/shared_models/medicine_type_model.dart';
import 'package:healthify/src/data/shared_models/region_model.dart';
import 'package:healthify/src/data/shared_models/specialty_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/views/doctor_views/medicine_type_doctor_card_view.dart';
import 'package:healthify/src/presentation/views/home_views/favourite_views/favourite_item_view.dart';
import 'package:healthify/src/presentation/widgets/text_input_field.dart';
import 'package:sizer/sizer.dart';

import '../router/app_router_names.dart';
import '../widgets/default_app_text.dart';

class SearchAreaDoctorsScreen extends StatefulWidget {
  const SearchAreaDoctorsScreen({
    super.key,
    required this.category,
    required this.specialty,
    required this.city,
    required this.region,
  });

  final CategoryModel category;
  final SpecialtyModel? specialty;
  final CityModel? city;
  final RegionModel? region;

  @override
  State<SearchAreaDoctorsScreen> createState() =>
      _SearchAreaDoctorsScreenState();
}

class _SearchAreaDoctorsScreenState extends State<SearchAreaDoctorsScreen> {
  List<dynamic> _medicineTypes = [];

  _filter(BuildContext context) => <List<dynamic>>[
        [context.highestDiscount, AppAssets.icDiscount],
        [context.installmentFeature, AppAssets.icCashCoin],
        [context.nearToMe, AppAssets.icGisLocation],
        [context.highestRate, AppAssets.icStarFilled],
        [context.onlinePayment, AppAssets.icCashCoin],
      ];
  TextEditingController searchController = TextEditingController();

  final ValueNotifier<List<bool>> _filterStatus = ValueNotifier(
    [
      false,
      false,
      false,
      false,
      false,
    ],
  );

  late final ValueNotifier<String> _address;

  @override
  void initState() {
    super.initState();
    _address = ValueNotifier(widget.city?.city == null
        ? "All"
        : "${widget.city!.city}, ${widget.region!.regions}");
    logWarning(widget.category.key!);
    final request = MedicineTypeRequest(
      paymentFeature: 0,
      type: widget.category.key!,
      rate: 0,
      discount: 0,
      nearest: 0,
      installmentFeature: 0,
      cityId: widget.city?.id,
      regionId: widget.region?.id,
      specialtyId: widget.specialty?.id,
    );
    MedicineTypeCubit.get(context).getMedicineType(request: request);
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
            padding: const EdgeInsets.only(top: 50),
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
                  child: Column(
                    children: [
                      DefaultAppText(
                        text: context.searchingIn,
                        textAlign: TextAlign.center,
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _address,
                            builder: (context, address, child) {
                              return DefaultAppText(
                                text: address,
                                textAlign: TextAlign.center,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.defaultWhite.withOpacity(0.7),
                              );
                            },
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.defaultWhite.withOpacity(0.7),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 3.w,
              right: 3.w,
            ),
            child: FieldWithLabel(
              fillColor: Colors.white,
              controller: searchController,
              filled: true,
              prefix: const Icon(
                Icons.search,
                color: AppColors.grey3,
              ),
              label: 'ابحث عن ${widget.category.nameAr} ...',
              hasLabel: false,
              cursorColor: AppColors.grey3,
              borderColor: AppColors.grey4,
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        List<bool> list = _filterStatus.value;
                        for (int i = 0; i < list.length; i++) {
                          if (i == index && !list[index]) {
                            list[i] = true;
                          } else {
                            list[i] = false;
                          }
                        }
                        _filterStatus.value = List.from(list);

                        late MedicineTypeRequest request;
                        if (index == 2) {
                          final position = await getCurrentPosition();

                          if (position != null) {
                            _address.value = "${position[1].locality}, "
                                "${position[1].subLocality}, "
                                "${position[1].street}";
                            request = MedicineTypeRequest(
                              lat: position[0].latitude,
                              lng: position[0].longitude,
                              type: widget.category.key!,
                              paymentFeature: _filterStatus.value[4] ? 1 : 0,
                              rate: _filterStatus.value[3] ? 1 : 0,
                              discount: _filterStatus.value[0] ? 1 : 0,
                              installmentFeature:
                                  _filterStatus.value[1] ? 1 : 0,
                              nearest: _filterStatus.value[2] ? 1 : 0,
                              specialtyId: widget.specialty?.id,
                            );
                          } else {
                            "You can't filter with location without allowing location permission"
                                .toToastWarning();
                            return;
                          }
                        } else {
                          _address.value = widget.city?.city == null
                              ? "All"
                              : "${widget.city!.city}, "
                                  "${widget.region!.regions}";
                          request = MedicineTypeRequest(
                            type: widget.category.key!,
                            paymentFeature: _filterStatus.value[4] ? 1 : 0,
                            rate: _filterStatus.value[3] ? 1 : 0,
                            discount: _filterStatus.value[0] ? 1 : 0,
                            installmentFeature: _filterStatus.value[1] ? 1 : 0,
                            nearest: _filterStatus.value[2] ? 1 : 0,
                            cityId: widget.city?.id,
                            regionId: widget.region?.id,
                            specialtyId: widget.specialty?.id,
                          );
                        }
                        MedicineTypeCubit.get(context)
                            .getMedicineType(request: request);
                      },
                      child: ValueListenableBuilder(
                          valueListenable: _filterStatus,
                          builder: (context, filterStatus, child) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: filterStatus[index]
                                    ? AppColors.primary
                                    : AppColors.defaultWhite,
                                border: Border.all(
                                  color: AppColors.primary,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    _filter(context)[index][1],
                                    color: filterStatus[index]
                                        ? AppColors.defaultWhite
                                        : AppColors.primary,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  DefaultAppText(
                                    text: _filter(context)[index][0],
                                    textAlign: TextAlign.center,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: filterStatus[index]
                                        ? AppColors.defaultWhite
                                        : AppColors.primary,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      width: 3.w,
                    ),
                itemCount: _filter(context).length),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.primaryOpacity,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
              child: BlocBuilder<MedicineTypeCubit, MedicineTypeState>(
                builder: (context, state) {
                  final data = [
                    ...MedicineTypeCubit.get(context).medicineTypes,
                    ...MedicineTypeCubit.get(context).medicineTypeDoctors,
                  ];
                  return state is MedicineTypeGetTypesLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ValueListenableBuilder(
                          valueListenable: searchController,
                          builder: (context, searchResult, child) {
                            if (searchResult.text.trim().isNotEmpty) {
                              _medicineTypes = data
                                  .where(
                                    (element) =>
                                        (element is MedicineTypeModel &&
                                            (element.name!.contains(
                                                  searchResult.text,
                                                ) ||
                                                element.doctor?.any(
                                                      (element) =>
                                                          element.name
                                                              ?.contains(
                                                            searchResult.text,
                                                          ) ==
                                                          true,
                                                    ) ==
                                                    true)) ||
                                        (element is MedicineTypeDoctorsModel &&
                                            element.doctorName!
                                                .contains(searchResult.text)),
                                  )
                                  .toList();
                            } else {
                              _medicineTypes = data;
                            }
                            return _medicineTypes.isEmpty
                                ? const Center(
                                    child: DefaultAppText(
                                      text: "Empty Result",
                                    ),
                                  )
                                : ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) =>
                                        _medicineTypes[index]
                                                is MedicineTypeModel
                                            ? FavouriteItemView(
                                                image: _medicineTypes[index]
                                                            .image !=
                                                        null
                                                    ? Image.network(
                                                        "${EndPoints.imageBaseUrlMedicineType}${_medicineTypes[index].image}",
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (c, o, s) =>
                                                                const Icon(
                                                          Icons.image,
                                                          size: 100,
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      )
                                                    : const Icon(
                                                        Icons.image,
                                                        size: 100,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                onTap: () {
                                                  if (widget.category.key ==
                                                          "Hospital" ||
                                                      widget.category.key ==
                                                          "Medical Center") {
                                                    Navigator.pushNamed(
                                                      context,
                                                      AppRouterNames
                                                          .rHospitalDetails,
                                                      arguments:
                                                          _medicineTypes[index],
                                                    );
                                                  } else {
                                                    Navigator.pushNamed(
                                                      context,
                                                      AppRouterNames
                                                          .rDoctorDetails,
                                                      arguments:
                                                          _medicineTypes[index],
                                                    );
                                                  }
                                                },
                                                name: _medicineTypes[index]
                                                        .name ??
                                                    "",
                                                rate: _medicineTypes[index]
                                                        .ratesAvg ??
                                                    "0.0",
                                                ratesCount:
                                                    "(${_medicineTypes[index].ratesCount})",
                                                location: (_medicineTypes[index]
                                                                    as MedicineTypeModel)
                                                                .doctor
                                                                ?.isNotEmpty ==
                                                            true &&
                                                        ((_medicineTypes[index]
                                                                        as MedicineTypeModel)
                                                                    .type !=
                                                                "مستشفى" &&
                                                            (_medicineTypes[index]
                                                                        as MedicineTypeModel)
                                                                    .type !=
                                                                "مركز تخصصي")
                                                    ? (_medicineTypes[index]
                                                                as MedicineTypeModel)
                                                            .doctor
                                                            ?.first
                                                            .title ??
                                                        ""
                                                    : "",
                                                discount: _medicineTypes[index]
                                                                .normalDiscount ==
                                                            null ||
                                                        _medicineTypes[index]
                                                                .normalDiscount ==
                                                            0
                                                    ? null
                                                    : "خصم مجاني ${_medicineTypes[index].normalDiscount} %",
                                                insuranceDiscount: _medicineTypes[
                                                                index]
                                                            .packageDiscount ==
                                                        null
                                                    ? null
                                                    : "خصم كارت التأمين السنوي ${_medicineTypes[index].packageDiscount} %",
                                                reward:
                                                    "${_medicineTypes[index].rewardPoints ?? 0} نقاط مكافئة",
                                              )
                                            : MedicineTypeDoctorCardView(
                                                doctor: (_medicineTypes[index]
                                                    as MedicineTypeDoctorsModel),
                                              ),
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height: 1.h,
                                      );
                                    },
                                    itemCount: _medicineTypes.length,
                                  );
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
