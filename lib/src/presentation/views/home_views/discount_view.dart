import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/medicine_type_cubit/medicine_type_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/request/search_medicine_type_request.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/views/home_views/favourite_views/favourite_item_view.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:healthify/src/presentation/widgets/text_input_field.dart';
import 'package:sizer/sizer.dart';

class DiscountView extends StatefulWidget {
  const DiscountView({super.key});

  @override
  State<DiscountView> createState() => _DiscountViewState();
}

class _DiscountViewState extends State<DiscountView> {
  bool _endFetching = false;
  late final ScrollController _scrollController;
  late SearchMedicineTypeRequest _request;
  final ValueNotifier<bool> _focus = ValueNotifier(false);
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (MedicineTypeCubit.get(context).mostChosenSpecialities.isEmpty ||
        MedicineTypeCubit.get(context).otherSpecialties.isEmpty) {
      MedicineTypeCubit.get(context).getSpecialties();
    }
    _request = const SearchMedicineTypeRequest(
      page: 1,
    );
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels > 0 &&
          !_endFetching) {
        _request = _request.copyWith(
          page: _request.page + 1,
        );
        MedicineTypeCubit.get(context).searchMedicineType(
          request: _request,
        );
      }
    });
    MedicineTypeCubit.get(context).searchMedicineType(
      request: _request,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          context.bestDiscount,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ValueListenableBuilder(
                valueListenable: _focus,
                builder: (context, focus, child) {
                  return IntrinsicHeight(
                    child: Row(
                      key: const ValueKey(1),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!focus)
                          Expanded(
                            child: FieldWithLabel(
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRouterNames.rFilter,
                                arguments: _request,
                              ).then((value) {
                                if (value != null) {
                                  _request = value as SearchMedicineTypeRequest;
                                  MedicineTypeCubit.get(context)
                                      .searchMedicineType(
                                    request: _request,
                                  );
                                }
                              }),
                              hintColor: Colors.white,
                              fillColor: AppColors.primary,
                              label: 'فلاتر',
                              readOnly: true,
                              filled: true,
                              hasLabel: false,
                              prefix: const Icon(
                                Icons.tune,
                                color: AppColors.defaultWhite,
                              ),
                            ),
                          ),
                        if (!focus) const SizedBox(width: 10),
                        AnimatedSize(
                          curve: Curves.bounceInOut,
                          duration: const Duration(milliseconds: 500),
                          child: SizedBox(
                            width: focus ? 85.w : 60.w,
                            child: Focus(
                              onFocusChange: (value) {
                                _focus.value = value;
                              },
                              child: FieldWithLabel(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.defaultBlack,
                                ),
                                onChange: (nVal) {
                                  final value = _search.text;
                                  if (value.isEmpty) {
                                    _request = const SearchMedicineTypeRequest(
                                      page: 1,
                                    );

                                    MedicineTypeCubit.get(context)
                                        .searchMedicineType(
                                      request: _request,
                                    );
                                  } else if (value.isNotEmpty) {
                                    _request = SearchMedicineTypeRequest(
                                      page: 1,
                                      name: value,
                                    );

                                    MedicineTypeCubit.get(context)
                                        .searchMedicineType(
                                      request: _request,
                                    );
                                  }
                                },
                                textInputAction: TextInputAction.search,
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                controller: _search,
                                fillColor: AppColors.primaryOpacity,
                                label: 'ابحث عن صيدلية, عيادة, مستشفي ...',
                                filled: true,
                                borderColor: AppColors.primaryOpacity,
                                hasLabel: false,
                                suffix: InkWell(
                                  onTap: () {
                                    final value = _search.text;
                                    if (value.isEmpty) {
                                      _request =
                                          const SearchMedicineTypeRequest(
                                        page: 1,
                                      );

                                      MedicineTypeCubit.get(context)
                                          .searchMedicineType(
                                        request: _request,
                                      );
                                    } else if (value.isNotEmpty) {
                                      _request = SearchMedicineTypeRequest(
                                        page: 1,
                                        name: value,
                                      );

                                      MedicineTypeCubit.get(context)
                                          .searchMedicineType(
                                        request: _request,
                                      );
                                    }
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              color: AppColors.primaryOpacity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: BlocConsumer<MedicineTypeCubit, MedicineTypeState>(
                listener: (context, state) {
                  if (state is MedicineTypeSearchTypesSuccessState) {
                    _endFetching = state.end;
                  }
                },
                builder: (context, state) {
                  final medicineTypes =
                      MedicineTypeCubit.get(context).medicineTypes;

                  return state is MedicineTypeSearchTypesLoadingState &&
                          medicineTypes.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : medicineTypes.isEmpty
                          ? Center(
                              child: DefaultAppText(
                                text: "Empty Search Result",
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                            )
                          : ListView.separated(
                              controller: _scrollController,
                              itemBuilder: (context, index) => index ==
                                      medicineTypes.length
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : FavouriteItemView(
                                      onTap: () {
                                        if (medicineTypes[index].type ==
                                                "مستشفى" ||
                                            medicineTypes[index].type ==
                                                "مركز تخصصي") {
                                          Navigator.pushNamed(
                                            context,
                                            AppRouterNames.rHospitalDetails,
                                            arguments: medicineTypes[index],
                                          );
                                        } else {
                                          Navigator.pushNamed(
                                            context,
                                            AppRouterNames.rDoctorDetails,
                                            arguments: medicineTypes[index],
                                          );
                                        }
                                      },
                                      image: medicineTypes[index].image != null
                                          ? Image.network(
                                              "${EndPoints.imageBaseUrlMedicineType}${medicineTypes[index].image}",
                                              fit: BoxFit.cover,
                                              loadingBuilder: (c, w, i) =>
                                                  i != null
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : w,
                                              errorBuilder: (c, o, s) =>
                                                  const Icon(
                                                Icons.image,
                                                size: 100,
                                                color: AppColors.primary,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.image,
                                              size: 100,
                                              color: AppColors.primary,
                                            ),
                                      name: medicineTypes[index].name ??
                                          "Unknown Name",
                                      rate: medicineTypes[index].ratesAvg ??
                                          "0.0",
                                      ratesCount:
                                          "(${medicineTypes[index].ratesCount})",
                                      location: medicineTypes[index]
                                                      .doctor
                                                      ?.isNotEmpty ==
                                                  true &&
                                              medicineTypes[index].type !=
                                                  "مستشفى" &&
                                              medicineTypes[index].type ==
                                                  "مركز تخصصي"
                                          ? medicineTypes[index]
                                                  .doctor
                                                  ?.first
                                                  .title ??
                                              ""
                                          : "",
                                      discount: medicineTypes[index]
                                                      .normalDiscount !=
                                                  null &&
                                              medicineTypes[index]
                                                      .normalDiscount !=
                                                  0
                                          ? "خصم مجاني ${medicineTypes[index].normalDiscount} %"
                                          : null,
                                      insuranceDiscount: medicineTypes[index]
                                                  .packageDiscount !=
                                              null
                                          ? "خصم كارت التأمين السنوي ${medicineTypes[index].packageDiscount} %"
                                          : null,
                                      reward:
                                          "${medicineTypes[index].rewardPoints ?? 0} نقاط مكافئة",
                                    ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount:
                                  state is MedicineTypeSearchTypesLoadingState &&
                                          medicineTypes.isNotEmpty
                                      ? medicineTypes.length + 1
                                      : medicineTypes.length,
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
