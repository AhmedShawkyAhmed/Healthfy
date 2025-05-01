import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthify/src/business_logic/medicine_type_cubit/medicine_type_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/const_variables.dart';
import 'package:healthify/src/data/request/search_medicine_type_request.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:sizer/sizer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.request});

  final SearchMedicineTypeRequest request;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late final ValueNotifier<bool> _discount;
  late final ValueNotifier<bool> _nearest;
  late final ValueNotifier<bool> _notCashe;
  late final ValueNotifier<bool> _paymentFeature;
  late List<ValueNotifier<bool>> _special;

  @override
  void initState() {
    super.initState();
    _nearest = ValueNotifier<bool>(widget.request.nearest == 1);
    _discount = ValueNotifier<bool>(widget.request.discount == 1);
    _notCashe = ValueNotifier<bool>(widget.request.notCashe == 1);
    _paymentFeature = ValueNotifier<bool>(widget.request.paymentFeature == 1);
    _special = [];
    if (MedicineTypeCubit.get(context).mostChosenSpecialities.isEmpty ||
        MedicineTypeCubit.get(context).otherSpecialties.isEmpty) {
      MedicineTypeCubit.get(context).getSpecialties();
    } else {
      _special = [
        ...MedicineTypeCubit.get(context)
            .mostChosenSpecialities
            .map((e) => ValueNotifier<bool>(false))
            .toList(),
        ...MedicineTypeCubit.get(context)
            .otherSpecialties
            .map((e) => ValueNotifier<bool>(false))
            .toList(),
      ];
    }
    final specialties = [
      ...MedicineTypeCubit.get(context).mostChosenSpecialities,
      ...MedicineTypeCubit.get(context).otherSpecialties,
    ];
    for (int i = 0; i < (widget.request.specialties?.length ?? 0); i++) {
      final index = specialties.indexWhere(
        (element) => element.id == widget.request.specialties![i],
      );
      _special[index].value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<MedicineTypeCubit, MedicineTypeState>(
      listener: (context, state) {
        if (state is MedicineTypeSearchTypesSuccessState) {
          _special = [
            ...MedicineTypeCubit.get(context)
                .mostChosenSpecialities
                .map((e) => ValueNotifier<bool>(false))
                .toList(),
            ...MedicineTypeCubit.get(context)
                .otherSpecialties
                .map((e) => ValueNotifier<bool>(false))
                .toList(),
          ];
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'حدد بحثك',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.grey,
                size: 30,
              )),
          actions: [
            TextButton(
                onPressed: () {
                  _nearest.value = false;
                  _discount.value = false;
                  _paymentFeature.value = false;
                  _notCashe.value = false;
                  for (var element in _special) {
                    element.value = false;
                  }
                },
                child: const Text(
                  'حذف الكل',
                  style: TextStyle(color: AppColors.red),
                ))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'تصفيات شائعة',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _discount,
                builder: (context, discount, child) {
                  return CheckboxListTile(
                    value: discount,
                    activeColor: AppColors.green,
                    onChanged: (value) {
                      _discount.value = value ?? !discount;
                    },
                    title: Text(
                      popularList[0],
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: _nearest,
                builder: (context, nearest, child) {
                  return CheckboxListTile(
                    value: nearest,
                    activeColor: AppColors.green,
                    onChanged: (value) async {
                      _nearest.value = value ?? !nearest;
                    },
                    title: Text(
                      popularList[1],
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: _notCashe,
                builder: (context, notCashe, child) {
                  return CheckboxListTile(
                    value: notCashe,
                    activeColor: AppColors.green,
                    onChanged: (value) async {
                      _notCashe.value = value ?? !notCashe;
                    },
                    title: Text(
                      popularList[2],
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: _paymentFeature,
                builder: (context, paymentFeature, child) {
                  return CheckboxListTile(
                    value: paymentFeature,
                    activeColor: AppColors.green,
                    onChanged: (value) async {
                      _paymentFeature.value = value ?? !paymentFeature;
                    },
                    title: Text(
                      popularList[3],
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'اختر التخصص',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: BlocBuilder<MedicineTypeCubit, MedicineTypeState>(
                  builder: (context, state) {
                    final cubit = MedicineTypeCubit.get(context);
                    final spec = [
                      ...cubit.mostChosenSpecialities,
                      ...cubit.otherSpecialties,
                    ];
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return index == 0
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.w,
                                ),
                                alignment: AlignmentDirectional.centerStart,
                                child: const DefaultAppText(
                                  text: "الاكثر اختيارا",
                                  textAlign: TextAlign.center,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : index ==
                                    MedicineTypeCubit.get(context)
                                            .mostChosenSpecialities
                                            .length +
                                        1
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                    ),
                                    alignment: AlignmentDirectional.centerStart,
                                    child: const DefaultAppText(
                                      text: "اخرى",
                                      textAlign: TextAlign.center,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : ValueListenableBuilder(
                                    valueListenable: index > 0 &&
                                            index <=
                                                cubit.mostChosenSpecialities
                                                    .length
                                        ? _special[index - 1]
                                        : _special[index - 2],
                                    builder: (context, value, child) {
                                      return CheckboxListTile(
                                        value: value,
                                        activeColor: AppColors.green,
                                        onChanged: (value) {
                                          (index > 0 &&
                                                          index <=
                                                              cubit
                                                                  .mostChosenSpecialities
                                                                  .length
                                                      ? _special[index - 1]
                                                      : _special[index - 2])
                                                  .value =
                                              value ??
                                                  !(index > 0 &&
                                                              index <=
                                                                  cubit
                                                                      .mostChosenSpecialities
                                                                      .length
                                                          ? _special[index - 1]
                                                          : _special[index - 2])
                                                      .value;
                                        },
                                        title: Text(
                                          (index > 0 &&
                                                          index <=
                                                              cubit
                                                                  .mostChosenSpecialities
                                                                  .length
                                                      ? spec[index - 1]
                                                      : spec[index - 2])
                                                  .title ??
                                              "Unknown Specialty",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                      },
                      itemCount: spec.length + 2,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * .03),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final sp = <num>[];
                      final specialties = [
                        ...MedicineTypeCubit.get(context)
                            .mostChosenSpecialities,
                        ...MedicineTypeCubit.get(context).otherSpecialties,
                      ];
                      for (int i = 0; i < _special.length; i++) {
                        if (_special[i].value) {
                          sp.add(
                            specialties[i].id!,
                          );
                        }
                      }
                      if (myLocation == null) {
                        "Unknown location, enable you location and scan again."
                            .toToastError();
                        try {
                          myLocation = await Geolocator.getCurrentPosition();
                        } catch (e) {
                          e.toString().toToastError();
                        }
                        return;
                      }
                      final request = SearchMedicineTypeRequest(
                        notCashe: _notCashe.value ? 1 : 0,
                        page: 1,
                        specialties: sp.isEmpty ? null : sp,
                        discount: _discount.value ? 1 : 0,
                        nearest: _nearest.value ? 1 : 0,
                        paymentFeature: _paymentFeature.value ? 1 : 0,
                        lat: myLocation!.latitude,
                        lng: myLocation!.longitude,
                      );
                      Navigator.pop(context, request);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: const Size(double.infinity, 60),
                        backgroundColor: AppColors.primary),
                    child: const Text(
                      'عرض النتائج',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const popularList = [
  'اعلي الخصومات',
  'قريب مني',
  'يقبل خدمة التقسيط',
  'يقبل الدفع الالكترونى',
];
