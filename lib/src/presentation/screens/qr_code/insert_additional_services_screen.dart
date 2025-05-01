import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/reservation_cubit/reservation_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/enums.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/data/models/my_reservation_model.dart';
import 'package:healthify/src/data/request/store_additional_services_request.dart';
import 'package:healthify/src/data/shared_models/medicine_type_model.dart';
import 'package:healthify/src/data/shared_models/service_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/router/reservation_argumentd.dart';
import 'package:healthify/src/presentation/views/addional_services_views/addional_service_item_view.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:sizer/sizer.dart';

class InsertAdditionalServicesScreen extends StatefulWidget {
  const InsertAdditionalServicesScreen(
      {super.key, required this.myReservation});

  final MyReservationModel myReservation;

  @override
  State<InsertAdditionalServicesScreen> createState() =>
      _InsertAdditionalServicesScreenState();
}

class _InsertAdditionalServicesScreenState
    extends State<InsertAdditionalServicesScreen> {
  late final List<ServiceModel> _serviceList;
  late final ValueNotifier<int> _servicesCount;
  late final List<ValueNotifier<ServiceModel?>> _services;
  late final List<TextEditingController> _serviceCostControllers;
  late final List<ValueNotifier<num?>> _discounts;
  late final ValueNotifier<PaymentMethod> _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _serviceList = [];
    _discounts = [ValueNotifier(0)];
    _serviceCostControllers = [TextEditingController()];
    _services = [ValueNotifier(null)];
    _servicesCount = ValueNotifier(1);
    _selectedPaymentMethod = ValueNotifier(PaymentMethod.visa);
    ReservationCubit.get(context).getServicesWithDiscount(
      medicineTypeId: widget.myReservation.medicineTypeModel!.id!,
    );
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
          context.services,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultWhite,
            fontWeight: FontWeight.w500,
            fontFamily: "Alexandria",
          ),
        ),
      ),
      body: Container(
        color: AppColors.background2,
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveWidth(16),
          vertical: context.responsiveHeight(8),
        ),
        child: BlocConsumer<ReservationCubit, ReservationState>(
          listener: (context, state) {
            if (state is ReservationGetServicesWithDiscountSuccessState) {
              _serviceList.addAll(ReservationCubit.get(context).services);
            }
          },
          builder: (context, state) {
            return state is ReservationGetServicesWithDiscountLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                            valueListenable: _servicesCount,
                            builder: (context, count, child) {
                              return ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: count,
                                itemBuilder: (BuildContext context, int index) {
                                  return AdditionalServiceItemView(
                                    index: index,
                                    count: count,
                                    serviceCostControllers:
                                        _serviceCostControllers,
                                    servicesCount: _servicesCount,
                                    services: _services,
                                    serviceList: _serviceList,
                                    discounts: _discounts,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(
                                  height: 5.h,
                                  thickness: 5,
                                ),
                              );
                            }),
                        SizedBox(
                          height: context.responsiveHeight(12),
                        ),
                        ValueListenableBuilder(
                          valueListenable: _selectedPaymentMethod,
                          builder: (context, paymentMethod, child) {
                            return Column(
                              children: getPaymentMethods(context)
                                  .map<PaymentMethod, Widget>(
                                    (key, value) => MapEntry(
                                      key,
                                      InkWell(
                                        onTap: () =>
                                            _selectedPaymentMethod.value = key,
                                        child: Row(
                                          children: [
                                            Radio(
                                              activeColor: Colors.black,
                                              value: key,
                                              groupValue: paymentMethod,
                                              onChanged: (method) =>
                                                  _selectedPaymentMethod.value =
                                                      method!,
                                            ),
                                            DefaultAppText(
                                              text: value,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.grey1,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .values
                                  .toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: BlocConsumer<ReservationCubit, ReservationState>(
        listener: (context, state) {
          if (state is ReservationStoreAdditionalServicesSuccessState) {
            final args = ReservationArguments(
              myReservationModel: widget.myReservation,
              price: _serviceCostControllers
                  .map((element) => num.parse(element.text))
                  .toList()
                  .listSummation(),
              payment: _selectedPaymentMethod.value == PaymentMethod.visa
                  ? 1
                  : _selectedPaymentMethod.value == PaymentMethod.cash
                      ? 0
                      : 2,
              medicineTypeModel: MedicineTypeModel(),
              status: "",
              type: "",
            );
            Navigator.pushReplacementNamed(
              context,
              AppRouterNames.rQrcodeScan,
              arguments: args,
            );
          }
        },
        builder: (context, state) {
          final cubit = ReservationCubit.get(context);
          return state is ReservationStoreAdditionalServicesLoadingState
              ? const SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      heroTag: "check",
                      backgroundColor: AppColors.primary,
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (!_services.any((e) => e.value == null) &&
                            !_serviceCostControllers.any(
                                (element) => element.text.trim().isEmpty)) {
                          final request = StoreAdditionalServicesRequest(
                            reservationId: widget.myReservation.id!,
                            services: List.generate(
                              _services.length,
                              (index) => ServiceRequest(
                                id: _services[index].value!.id!,
                                price: num.parse(
                                  _serviceCostControllers[index].text,
                                ),
                              ),
                            ),
                          );
                          cubit.storeAdditionalServices(
                            request: request,
                          );
                        } else {
                          showToast(
                            "يجب اختيار الخدمة و السعر قبل التأكيد",
                            ToastState.warning,
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    FloatingActionButton(
                      heroTag: "add",
                      backgroundColor: AppColors.primary,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_servicesCount.value < _serviceList.length) {
                          _services.add(ValueNotifier(null));
                          _serviceCostControllers.add(TextEditingController());
                          _discounts.add(ValueNotifier(0));
                          _servicesCount.value++;
                        } else {
                          showToast(
                              "لايمكن إضافة خدمات اخرى", ToastState.warning);
                        }
                      },
                    ),
                  ],
                );
        },
      ),
    );
  }
}
