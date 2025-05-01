import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:healthify/src/business_logic/reservation_cubit/reservation_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/enums.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/data/request/reserve_request.dart';
import 'package:healthify/src/data/shared_models/schedule_model.dart';
import 'package:healthify/src/data/shared_models/service_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/views/common_views/custom_dropdown_button_view.dart';
import 'package:healthify/src/presentation/views/common_views/custom_form_field_view.dart';
import 'package:healthify/src/presentation/views/doctor_views/doctors_bottom_data_view_item.dart';
import 'package:healthify/src/presentation/widgets/custom_button.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:healthify/src/presentation/widgets/schedule_widget.dart';
import 'package:healthify/src/presentation/widgets/text_input_field.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:string_similarity/string_similarity.dart';

import '../../router/reservation_argumentd.dart';

class BookingDiscountScreen extends StatefulWidget {
  const BookingDiscountScreen({super.key, required this.reservationArguments});

  final ReservationArguments reservationArguments;

  @override
  State<BookingDiscountScreen> createState() => _BookingDiscountScreenState();
}

class _BookingDiscountScreenState extends State<BookingDiscountScreen> {
  final _controller = ScrollController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _organizationController = TextEditingController();
  final _addressController = TextEditingController();
  final _serviceController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _costController = TextEditingController();
  final _priceAfterDiscountController = TextEditingController();
  final _couponController = TextEditingController();
  final _rewardPointNotifier = ValueNotifier(false);
  late ValueNotifier<ServiceModel?> _services;
  late final List<ServiceModel> _serviceList;
  late final ValueNotifier<PaymentMethod> _selectedPaymentMethod;
  num? _discount;
  ScheduleModel? _schedule;
  late final bool _disableSchedule;

  @override
  void initState() {
    super.initState();
    final user = AuthCubit.get(context).user;
    _nameController.text = user?.name ?? "";
    _phoneController.text = user?.phone ?? "";
    _organizationController.text =
        widget.reservationArguments.medicineTypeModel.name ?? "Empty Name";
    _addressController.text =
        widget.reservationArguments.medicineTypeModel.address ??
            "Empty address";
    _serviceController.text =
        widget.reservationArguments.myReservationModel?.service?.name ??
            "Empty Service";
    _serviceList = ReservationCubit.get(context).services;
    _services = ValueNotifier(null);
    _services.addListener(() {
      // _costController.text = "${_services.value?.price}";
      _costController.text = "";
      _discount = num.tryParse("${_services.value?.discount}");
    });
    _selectedPaymentMethod = ValueNotifier(PaymentMethod.cash);
    if (widget.reservationArguments.type == "oneReservation") {
      _dateController.text =
          widget.reservationArguments.myReservationModel?.date ?? "Empty Date";
      _timeController.text =
          widget.reservationArguments.myReservationModel?.time ?? "Empty Date";
      // _costController.text =
      //     widget.reservationArguments.myReservationModel?.price.toString() ??
      //         "Empty Date";
      _costController.text =
              "";
      _priceAfterDiscountController.text = widget
              .reservationArguments.myReservationModel?.priceAfterDiscount
              .toString() ??
          "Empty Date";
      _discount = widget.reservationArguments.myReservationModel!.discount!;
    }
    _disableSchedule = widget.reservationArguments.medicineTypeModel.type ==
            "صيدلية" ||
        widget.reservationArguments.medicineTypeModel.type == "مركز البصريات" ||
        widget.reservationArguments.medicineTypeModel.type == "مستلزمات طبية" ||
        widget.reservationArguments.medicineTypeModel.type == "معمل تحاليل";
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
          context.discount,
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
        padding: EdgeInsets.symmetric(horizontal: context.responsiveWidth(16)),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: context.responsiveHeight(24),
            ),
            CustomFormFieldView(
              spaceBetween: 12,
              titleHeight: 0,
              title: context.customerName,
              hintText: context.customerNameHint,
              controller: _nameController,
              readOnly: true,
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: context.responsiveHeight(24),
            ),
            CustomFormFieldView(
              spaceBetween: 12,
              titleHeight: 0,
              title: context.customerPhone,
              hintText: context.customerPhoneHint,
              controller: _phoneController,
              readOnly: true,
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: context.responsiveHeight(24),
            ),
            CustomFormFieldView(
              spaceBetween: 12,
              titleHeight: 0,
              title: context.organizationName,
              hintText: context.organizationNameHint,
              controller: _organizationController,
              keyboardType: TextInputType.name,
              readOnly: true,
            ),
            SizedBox(
              height: context.responsiveHeight(24),
            ),
            CustomFormFieldView(
              spaceBetween: 12,
              titleHeight: 0,
              title: context.address,
              hintText: context.addressHint,
              controller: _addressController,
              keyboardType: TextInputType.name,
              readOnly: true,
            ),
            SizedBox(
              height: context.responsiveHeight(24),
            ),
            if (widget.reservationArguments.type == "oneReservation") ...[
              CustomFormFieldView(
                spaceBetween: 12,
                titleHeight: 0,
                title: context.services,
                hintText: context.servicesHint,
                controller: _serviceController,
                keyboardType: TextInputType.name,
                readOnly: true,
              ),
            ] else ...[
              ValueListenableBuilder(
                valueListenable: _services,
                builder: (BuildContext context, value, Widget? child) {
                  return CustomDropDownButtonView<ServiceModel>(
                    spaceBetween: 12,
                    titleHeight: 0,
                    value: value,
                    title: context.services,
                    hintText: context.servicesHint,
                    isLTR: false,
                    items: _serviceList
                        .map(
                          (e) => DropdownMenuItem<ServiceModel>(
                            value: e,
                            child: Text(
                              e.name ?? "Unknown service",
                              style: const TextStyle(
                                fontFamily: 'Alexandria',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (ServiceModel? nVal) {
                      _services.value = nVal;
                    },
                  );
                },
              ),
            ],
            if (widget.reservationArguments.myReservationModel
                    ?.additionalService !=
                null) ...[
              SizedBox(
                height: context.responsiveHeight(16),
              ),
              ExpansionTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    width: 1,
                    color: AppColors.grey3,
                  ),
                ),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    width: 1,
                    color: AppColors.grey3,
                  ),
                ),
                tilePadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                title: Container(
                  height: context.responsiveHeight(32),
                  alignment: AlignmentDirectional.centerStart,
                  child: const Text(
                    "خدمات اخرى",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      fontFamily: 'Alexandria',
                      color: AppColors.defaultBlack,
                    ),
                  ),
                ),
                expandedAlignment: Alignment.centerRight,
                childrenPadding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                children: widget
                    .reservationArguments.myReservationModel!.additionalService!
                    .map(
                      (e) => Column(
                        children: [
                          Text(
                            e.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily: 'Alexandria',
                              color: AppColors.defaultBlack,
                            ),
                          ),
                          if (widget.reservationArguments.myReservationModel!
                                  .additionalService!
                                  .indexOf(e) !=
                              widget.reservationArguments.myReservationModel!
                                      .additionalService!.length -
                                  1)
                            const SizedBox(
                              height: 12,
                            ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
            if (!_disableSchedule)
              SizedBox(
                height: context.responsiveHeight(12),
              ),
            if (!_disableSchedule)
              ValueListenableBuilder(
                valueListenable: _services,
                builder: (context, services, child) {
                  return services == null
                      ? const SizedBox(
                          key: ValueKey(1),
                        )
                      : DoctorsBottomDataViewItem(
                          key: const ValueKey(1),
                          padding: EdgeInsets.zero,
                          title: context.workHours,
                          expansions: [
                            if (services.schedule?.isNotEmpty == true)
                              SizedBox(
                                width: 100.w,
                                height: 14.h,
                                child: RawScrollbar(
                                  controller: _controller,
                                  interactive: true,
                                  thumbVisibility: true,
                                  thumbColor: AppColors.primary,
                                  radius: const Radius.circular(5),
                                  child: ListView.builder(
                                    controller: _controller,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: services.schedule!.length,
                                    itemBuilder: (context, index) {
                                      return ScheduleWidget(
                                        scheduleModel:
                                            services.schedule![index],
                                        onTap: ({int? i}) {
                                          _schedule = services.schedule![index];
                                          final from = services.schedule![index]
                                              .period![i!].from;
                                          final to = services
                                              .schedule![index].period![i].to;
                                          _timeController.text = "$from - $to";
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        );
                },
              ),
            if (!_disableSchedule)
              SizedBox(
                height: context.responsiveHeight(24),
              ),
            if (!_disableSchedule)
              Row(
                children: [
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: _services,
                        builder: (context, service, child) {
                          return CustomFormFieldView(
                            readOnly: true,
                            onTap: widget.reservationArguments.type ==
                                    "oneReservation"
                                ? null
                                : () {
                                    if (service != null && _schedule != null) {
                                      final days = DateFormat.EEEE("ar")
                                          .dateSymbols
                                          .STANDALONEWEEKDAYS;
                                      int selectedDay = 0;
                                      for (int i = 1; i <= days.length; i++) {
                                        if (days[i - 1]
                                                .similarityTo(_schedule!.day) >
                                            0.5) {
                                          selectedDay = i - 1 == 0 ? 7 : i - 1;
                                          break;
                                        }
                                      }
                                      DateTime today = DateTime.now();
                                      int difference =
                                          today.weekday - selectedDay;
                                      if (difference > 0) {
                                        today = today.subtract(
                                          Duration(
                                            days: difference.abs(),
                                          ),
                                        );
                                        today = today.add(
                                          const Duration(
                                            days: 7,
                                          ),
                                        );
                                      } else {
                                        today = today.add(
                                          Duration(
                                            days: difference.abs(),
                                          ),
                                        );
                                      }
                                      showDatePicker(
                                        context: context,
                                        initialDate: today,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now().add(
                                          const Duration(days: 30),
                                        ),
                                        selectableDayPredicate: (datetime) {
                                          return _schedule!.day.similarityTo(
                                                  DateFormat('EEEE', 'ar')
                                                      .format(datetime)) >
                                              0.5;
                                        },
                                        builder: (context, child) => Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              primary: AppColors.primary,
                                              // header background color
                                              onPrimary: AppColors.defaultWhite,
                                              // header text color
                                              onSurface: AppColors
                                                  .grey1, // body text color
                                            ),
                                          ),
                                          child: child!,
                                        ),
                                        onDatePickerModeChange: (date) {
                                          return;
                                        },
                                      ).then((value) {
                                        if (value != null) {
                                          _dateController.text =
                                              DateFormat("yyyy/MM/dd")
                                                  .format(value);
                                        } else {
                                          "يجب تحديد يوم من المتاح بالنسبة للمنشأة"
                                              .toToastWarning();
                                        }
                                      });
                                    } else {
                                      "يجب اختبار الخدمه و تحديد فتره حجز اولا"
                                          .toToastWarning();
                                    }
                                  },
                            spaceBetween: 12,
                            titleHeight: 0,
                            title: context.date,
                            hintText: context.dateHint,
                            backgroundColor: AppColors.background3,
                            enableBorder: false,
                            controller: _dateController,
                            keyboardType: TextInputType.name,
                          );
                        }),
                  ),
                  SizedBox(
                    width: context.responsiveWidth(12),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: _services,
                        builder: (context, service, child) {
                          return CustomFormFieldView(
                            readOnly: true,
                            onTap: widget.reservationArguments.type ==
                                    "oneReservation"
                                ? null
                                : null,
                            spaceBetween: 12,
                            titleHeight: 0,
                            title: context.hour,
                            hintText: context.hourHint,
                            backgroundColor: AppColors.background3,
                            enableBorder: false,
                            controller: _timeController,
                            keyboardType: TextInputType.name,
                          );
                        }),
                  ),
                ],
              ),
            SizedBox(
              height: context.responsiveHeight(24),
            ),
            if ((_discount != null &&
                    widget.reservationArguments.myReservationModel?.status ==
                        "waiting") ||
                _disableSchedule)
              Column(
                children: [
                  CustomFormFieldView(
                    spaceBetween: 12,
                    titleHeight: 0,
                    title: context.serviceCost,
                    hintText: context.serviceCostHint,
                    controller: _costController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: context.responsiveHeight(24),
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      context.costAfterDiscount,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontFamily: 'Alexandria',
                        color: AppColors.defaultBlack,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveHeight(12),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _costController,
                    builder: (context, cost, child) {
                      final costNum = num.tryParse(cost.text);
                      final finalCost = costNum == null
                          ? 0
                          : (costNum - (costNum * ((_discount ?? 0) / 100)))
                              .toInt();
                      return Container(
                        height: context.responsiveHeight(56),
                        decoration: BoxDecoration(
                          color: AppColors.green1.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  child: DefaultAppText(
                                    text: costNum == null
                                        ? "0 جنية"
                                        : "$finalCost جنية",
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (costNum != null)
                                  const WidgetSpan(
                                    child: SizedBox(
                                      width: 10,
                                    ),
                                  ),
                                if (costNum != null)
                                  WidgetSpan(
                                    child: DefaultAppText(
                                      text: "$costNum جنية",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: AppColors.grey3,
                                      lineHeight: 2,
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 3,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: context.responsiveHeight(24),
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      context.choosePayment,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        fontFamily: 'Alexandria',
                        color: AppColors.defaultBlack,
                      ),
                    ),
                  ),
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
                  SizedBox(
                    height: context.responsiveHeight(24),
                  ),
                ],
              ),
            if (widget.reservationArguments.myReservationModel?.status == "end")
              CustomButton(
                text: "إضافة خدمات اضافية",
                onTap: () => Navigator.pushNamed(
                    context, AppRouterNames.rInsertAdditionalServices,
                    arguments: widget.reservationArguments.myReservationModel),
              ),
            if (widget.reservationArguments.type != "oneReservation" &&
                widget.reservationArguments.medicineTypeModel.rewardPoints !=
                    null)
              ValueListenableBuilder(
                valueListenable: _rewardPointNotifier,
                builder: (context, useRewardPoint, child) {
                  return CheckboxListTile(
                    activeColor: AppColors.primary,
                    value: useRewardPoint,
                    title: DefaultAppText(
                      text:
                          "استخدام نقاط المكافئه ==> ${widget.reservationArguments.medicineTypeModel.rewardPoints} نقطة مكافئة",
                      fontSize: 12,
                    ),
                    onChanged: (nVal) {
                      _rewardPointNotifier.value = nVal!;
                    },
                  );
                },
              ),
            if (widget.reservationArguments.type != "oneReservation")
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 15,
                  left: 10,
                  right: 10,
                ),
                child: FieldWithLabel(
                  borderColor: AppColors.grey4,
                  controller: _couponController,
                  label: "الكوبون",
                ),
              ),
            if (widget.reservationArguments.type == "oneReservation") ...[
              if (widget.reservationArguments.myReservationModel?.status ==
                  "waiting")
                ValueListenableBuilder(
                    valueListenable: _costController,
                    builder: (context, cost, child) {
                      final costNum = num.tryParse(cost.text) ?? 0;
                      return CustomButton(
                        text: context.confirmBooking,
                        backgroundColor: costNum == 0 ? AppColors.grey3 : null,
                        onTap: costNum == 0
                            ? null
                            : () {
                                widget.reservationArguments.price =
                                    num.tryParse(
                                  _costController.text,
                                );
                                widget.reservationArguments.payment =
                                    _selectedPaymentMethod.value ==
                                            PaymentMethod.visa
                                        ? 1
                                        : _selectedPaymentMethod.value ==
                                                PaymentMethod.cash
                                            ? 0
                                            : 2;
                                Navigator.pushNamed(
                                  context,
                                  AppRouterNames.rQrcodeScan,
                                  arguments: widget.reservationArguments,
                                );
                              },
                      );
                    }),
              if (widget.reservationArguments.myReservationModel?.status ==
                  "waiting")
                SizedBox(
                  height: context.responsiveHeight(15),
                ),
              if (widget.reservationArguments.myReservationModel?.status ==
                  "waiting")
                BlocConsumer<ReservationCubit, ReservationState>(
                  listener: (context, state) {
                    if (state is ReservationCancelReservationSuccessState) {
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return state is ReservationCancelReservationLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            text: context.cancelBooking,
                            backgroundColor: AppColors.defaultWhite,
                            textColor: AppColors.red,
                            border: Border.all(color: AppColors.red),
                            onTap: () {
                              ReservationCubit.get(context).cancelReservation(
                                reservationId: widget.reservationArguments
                                    .myReservationModel!.id!,
                              );
                            },
                          );
                  },
                ),
            ] else ...[
              Container(
                height: context.responsiveHeight(55),
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveWidth(10),
                ),
                child: BlocConsumer<ReservationCubit, ReservationState>(
                  listener: (context, state) {
                    if (state is ReservationSuccessState) {
                      Navigator.pushReplacementNamed(
                          context, AppRouterNames.rBookingDone,
                          arguments: "تم الحجز بنجاح");
                    }
                  },
                  builder: (context, state) {
                    return ValueListenableBuilder(
                        valueListenable: _costController,
                        builder: (context, cost, child) {
                          return ValueListenableBuilder(
                              valueListenable: _services,
                              builder: (context, services, child) {
                                return ValueListenableBuilder(
                                    valueListenable: _dateController,
                                    builder: (context, date, child) {
                                      return ValueListenableBuilder(
                                          valueListenable: _timeController,
                                          builder: (context, time, child) {
                                            final enabled = !_disableSchedule
                                                ? time.text.isNotEmpty &&
                                                    date.text.isNotEmpty &&
                                                    services != null
                                                : services != null &&
                                                    cost.text.isNotEmpty &&
                                                    cost.text != "0";
                                            return state
                                                    is ReservationLoadingState
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : CustomButton(
                                                    backgroundColor: enabled
                                                        ? null
                                                        : AppColors.grey4,
                                                    textColor: enabled
                                                        ? null
                                                        : AppColors.grey3,
                                                    text: _disableSchedule
                                                        ? "الحصول على الخصم"
                                                        : "حجز موعد جديد",
                                                    onTap: enabled
                                                        ? () {
                                                            if (!_disableSchedule) {
                                                              final request =
                                                                  ReserveRequest(
                                                                coupon:
                                                                    _couponController
                                                                        .text,
                                                                useRewardPoint:
                                                                    _rewardPointNotifier
                                                                            .value
                                                                        ? 1
                                                                        : 0,
                                                                serviceId:
                                                                    _services
                                                                        .value!
                                                                        .id!,
                                                                date: date.text,
                                                                time: time.text,
                                                              );
                                                              ReservationCubit
                                                                      .get(
                                                                          context)
                                                                  .reserve(
                                                                request:
                                                                    request,
                                                              );
                                                            } else {
                                                              final args =
                                                                  ReservationArguments(
                                                                medicineTypeModel: widget
                                                                    .reservationArguments
                                                                    .medicineTypeModel,
                                                                status: widget
                                                                    .reservationArguments
                                                                    .status,
                                                                type: widget
                                                                    .reservationArguments
                                                                    .type,
                                                                payment: _selectedPaymentMethod
                                                                            .value ==
                                                                        PaymentMethod
                                                                            .visa
                                                                    ? 1
                                                                    : _selectedPaymentMethod.value ==
                                                                            PaymentMethod.cash
                                                                        ? 0
                                                                        : 2,
                                                                price: num
                                                                    .tryParse(
                                                                  _costController
                                                                      .text,
                                                                ),
                                                                coupon:
                                                                    _couponController
                                                                        .text,
                                                                useRewardPoint:
                                                                    _rewardPointNotifier
                                                                            .value
                                                                        ? 1
                                                                        : 0,
                                                                serviceId:
                                                                    _services
                                                                        .value!
                                                                        .id!,
                                                              );
                                                              Navigator
                                                                  .pushNamed(
                                                                context,
                                                                AppRouterNames
                                                                    .rQrcodeScan,
                                                                arguments: args,
                                                              );
                                                            }
                                                          }
                                                        : null,
                                                  );
                                          });
                                    });
                              });
                        });
                  },
                ),
              ),
            ],
            SizedBox(
              height: context.responsiveHeight(24),
            ),
          ],
        ),
      ),
    );
  }
}
