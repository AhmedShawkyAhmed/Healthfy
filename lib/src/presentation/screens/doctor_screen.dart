// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthify/src/business_logic/Favourite_cubit/favourite_cubit.dart';
import 'package:healthify/src/business_logic/medicine_type_cubit/medicine_type_cubit.dart';
import 'package:healthify/src/business_logic/package_cubit/package_cubit.dart';
import 'package:healthify/src/business_logic/reservation_cubit/reservation_cubit.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/request/add_favourite_request.dart';
import 'package:healthify/src/data/shared_models/medicine_type_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/views/doctor_views/doctors_bottom_data_view_item.dart';
import 'package:healthify/src/presentation/views/doctor_views/doctors_top_data_view_item.dart';
import 'package:healthify/src/presentation/widgets/schedule_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../router/reservation_argumentd.dart';
import '../widgets/default_app_text.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({super.key, required this.medicineType});

  final MedicineTypeModel medicineType;

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  final ValueNotifier<bool> _availToday = ValueNotifier(false);
  final _controller = ScrollController();
  late final bool _disableBooking;

  List<double> maxDiscount = [];

  phone(String phone) async {
    if (await canLaunchUrl(Uri.parse("tel://$phone"))) {
      await launchUrl(Uri.parse("tel://$phone"),
          mode: LaunchMode.externalApplication);
    }
  }

  @override
  void initState() {
    debugPrint(widget.medicineType.type);
    _disableBooking = widget.medicineType.type == "صيدلية" ||
        widget.medicineType.type == "مركز البصريات" ||
        widget.medicineType.type == "مستلزمات طبية" ||
        widget.medicineType.type == "معمل تحاليل";
    for (int k = 0; k < widget.medicineType.service!.length; k++) {
      widget.medicineType.service![k].offer != null &&
              widget.medicineType.service![k].offer!.isNotEmpty
          ? maxDiscount.add(
              double.parse(
                widget.medicineType.service![k].offer![0].discount.toString(),
              ),
            )
          : maxDiscount.add(0.0);
    }
    super.initState();
    // _initTodayAvailability();
    final cubit = MedicineTypeCubit.get(context);
    cubit.updateSelectedModel(
      cubit.medicineTypes.firstWhere(
        (element) => element.id == widget.medicineType.id,
        orElse: () => widget.medicineType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.medicineType.id);
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
                  child: DefaultAppText(
                    text: widget.medicineType.type ?? "",
                    textAlign: TextAlign.center,
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.primaryOpacity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.defaultWhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 64,
                            height: 64,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: widget.medicineType.image != null
                                  ? Image.network(
                                      "${EndPoints.imageBaseUrlMedicineType}${widget.medicineType.image}",
                                      fit: BoxFit.cover,
                                      // loadingBuilder: (c, w, i) => const Center(
                                      //   child: CircularProgressIndicator(),
                                      // ),
                                      errorBuilder: (c, o, s) => const Icon(
                                        Icons.image,
                                        size: 40,
                                        color: AppColors.primary,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.image,
                                      size: 40,
                                      color: AppColors.primary,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: DefaultAppText(
                                        text: widget.medicineType.name ?? "",
                                        textAlign: TextAlign.start,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    SvgPicture.asset(
                                      AppAssets.icVerified,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                if (widget.medicineType.doctor?.isNotEmpty ==
                                        true &&
                                    widget.medicineType.name?.trim().contains(
                                              widget.medicineType.doctor?.first
                                                      .name
                                                      ?.trim() ??
                                                  "",
                                            ) ==
                                        false)
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: DefaultAppText(
                                      text:
                                          widget.medicineType.doctor == null ||
                                                  widget.medicineType.doctor!
                                                      .isEmpty
                                              ? ""
                                              : widget.medicineType.doctor
                                                      ?.first.name ??
                                                  "",
                                      textAlign: TextAlign.start,
                                      fontSize: 11,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                if (widget.medicineType.doctor?.isNotEmpty ==
                                        true &&
                                    widget.medicineType.name?.trim().contains(
                                              widget.medicineType.doctor?.first
                                                      .name
                                                      ?.trim() ??
                                                  "",
                                            ) ==
                                        false)
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                if (widget.medicineType.doctor?.isNotEmpty ==
                                        true &&
                                    widget.medicineType.doctor?.first.title !=
                                        null &&
                                    widget.medicineType.doctor!.first.title!
                                        .isNotEmpty)
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: DefaultAppText(
                                      text: widget
                                          .medicineType.doctor!.first.title!,
                                      textAlign: TextAlign.start,
                                      fontSize: 11,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                if (widget.medicineType.doctor?.isNotEmpty ==
                                        true &&
                                    widget.medicineType.doctor?.first.title !=
                                        null &&
                                    widget.medicineType.doctor!.first.title!
                                        .isNotEmpty)
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                widget.medicineType.installmentFeature == 0
                                    ? const SizedBox()
                                    : Row(
                                        children: [
                                          SvgPicture.asset(
                                              AppAssets.icCashCoin),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          SizedBox(
                                            height: 2.5.h,
                                            child: const DefaultAppText(
                                              text: "متاح خدمة التقسيط",
                                              color: AppColors.primaryGreen,
                                              textAlign: TextAlign.start,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              BlocConsumer<FavouriteCubit, FavouriteState>(
                                listener: (context, state) {
                                  if (state is FavouriteAddSuccessState ||
                                      state is FavouriteRemoveSuccessState) {
                                    widget.medicineType.fav =
                                        state is FavouriteAddSuccessState;
                                    setState(() {});
                                    MedicineTypeCubit.get(context)
                                        .updateMedicineTypeFav(
                                      widget.medicineType.id!,
                                      state is FavouriteAddSuccessState,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return InkWell(
                                    onTap: state is FavouriteAddLoadingState ||
                                            state is FavouriteRemoveLoadingState
                                        ? null
                                        : () {
                                            if (widget.medicineType.fav ==
                                                true) {
                                              FavouriteCubit.get(context)
                                                  .removeFavourite(
                                                id: widget.medicineType.id!,
                                              );
                                            } else {
                                              FavouriteCubit.get(context)
                                                  .addFavourite(
                                                request: AddFavouriteRequest(
                                                  favableId:
                                                      widget.medicineType.id!,
                                                ),
                                              );
                                            }
                                          },
                                    child: widget.medicineType.fav == true
                                        ? const Icon(
                                            Icons.favorite,
                                            color: AppColors.defaultRed,
                                          )
                                        : SvgPicture.asset(
                                            AppAssets.icFavorite,
                                            color: AppColors.defaultRed,
                                          ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              const InkWell(
                                onTap: shareApp,
                                child: Icon(
                                  Icons.share_outlined,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: AppColors.defaultWhite,
                      height: 15.h,
                      width: 100.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 2.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DoctorsTopDataViewItem(
                            icon: SvgPicture.asset(AppAssets.icPointsEarned),
                            text1: "20 نقطة مكافئة",
                            text2: "نقاط الكاش باك",
                          ),
                          DoctorsTopDataViewItem(
                            icon: Icon(
                              Icons.star,
                              size: 4.w,
                              color: AppColors.primary,
                            ),
                            text1: "${widget.medicineType.ratesAvg} "
                                "(${widget.medicineType.ratesCount})",
                            text2: "التقييمات",
                          ),
                          if (maxDiscount.isNotEmpty &&
                              maxDiscount.reduce(max).toInt() != 0)
                            DoctorsTopDataViewItem(
                              icon: SvgPicture.asset(AppAssets.icTicket),
                              text1: "خصم مجاني",
                              text2: "${maxDiscount.reduce(max).toInt()} %",
                            ),
                          ValueListenableBuilder(
                              valueListenable: _availToday,
                              builder: (context, availToday, child) {
                                return DoctorsTopDataViewItem(
                                  icon: SvgPicture.asset(
                                    AppAssets.icCalendarChecked,
                                  ),
                                  text1: availToday
                                      ? "متاح اليوم"
                                      : "غير متاح اليوم",
                                  text2: "ساعات العمل",
                                );
                              }),
                        ],
                      ),
                    ),
                    Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(2.25),
                        1: FlexColumnWidth(1.25),
                        2: FlexColumnWidth(1.5),
                      },
                      border: TableBorder(
                          top: const BorderSide(color: AppColors.grey5),
                          bottom: const BorderSide(color: AppColors.grey5),
                          left: const BorderSide(color: AppColors.grey5),
                          right: const BorderSide(color: AppColors.grey5),
                          verticalInside:
                              const BorderSide(color: AppColors.grey5),
                          horizontalInside:
                              const BorderSide(color: AppColors.grey5),
                          borderRadius: BorderRadius.circular(8)),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: List.generate(
                        widget.medicineType.service?.length != null
                            ? widget.medicineType.service!.length + 1
                            : 0,
                        (index) => TableRow(
                          decoration: BoxDecoration(
                              color: index == 0
                                  ? AppColors.defaultWhite
                                  : AppColors.background2,
                              borderRadius: BorderRadius.circular(8)),
                          children: [
                            Container(
                              height: 5.h,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 1.h),
                              child: FittedBox(
                                child: DefaultAppText(
                                  text: index == 0
                                      ? context.service
                                      : widget.medicineType.service![index - 1]
                                              .name ??
                                          "Unknown service",
                                  textAlign: TextAlign.center,
                                  fontSize: index == 0 ? 12.sp : 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            ...List.generate(
                              (maxDiscount.isNotEmpty &&
                                      maxDiscount.reduce(max).toInt() != 0)
                                  ? 2
                                  : 1,
                              (i) => Container(
                                height: 4.h,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 1.h),
                                child: FittedBox(
                                  child: DefaultAppText(
                                    text: index == 0
                                        ? (((maxDiscount.isNotEmpty &&
                                                    maxDiscount
                                                            .reduce(max)
                                                            .toInt() !=
                                                        0)
                                                ? i == 0
                                                : i != 0)
                                            ? context.freeDiscount
                                            : context.insuranceCardDiscount)
                                        : ((maxDiscount.isNotEmpty &&
                                                    maxDiscount
                                                            .reduce(max)
                                                            .toInt() !=
                                                        0)
                                                ? i == 0
                                                : i != 0)
                                            ? "${widget.medicineType.service![index - 1].offer!.isNotEmpty && widget.medicineType.service![index - 1].offer?[0].discount != null ? widget.medicineType.service![index - 1].offer![0].discount : "0"}%"
                                            : "${widget.medicineType.service![index - 1].offer!.isNotEmpty && widget.medicineType.service![index - 1].offer?[1].discount != null ? widget.medicineType.service![index - 1].offer![1].discount : "0"}%",
                                    textAlign: TextAlign.center,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // if (!_disableBooking)
                    Container(
                      color: AppColors.defaultWhite,
                      child: BlocConsumer<ReservationCubit, ReservationState>(
                        listener: (context, state) {
                          if (widget.medicineType.service!.isNotEmpty) {
                            if (state
                                is ReservationGetServicesWithDiscountSuccessState) {
                              if (widget.medicineType.hasReservations == true) {
                                Navigator.pushNamed(
                                  context,
                                  AppRouterNames.rQrcodeScan,
                                  arguments: ReservationArguments(
                                    medicineTypeModel: widget.medicineType,
                                    status: "",
                                    type: "allReservation",
                                  ),
                                );
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  AppRouterNames.rBookingDiscount,
                                  arguments: ReservationArguments(
                                    medicineTypeModel: widget.medicineType,
                                    status: "",
                                    type: "allReservation",
                                  ),
                                );
                              }
                            }
                          }
                        },
                        builder: (context, state) {
                          return state
                                  is ReservationGetServicesWithDiscountLoadingState
                              ? const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Column(
                                  children: [
                                    if ((maxDiscount.isNotEmpty &&
                                        maxDiscount.reduce(max).toInt() != 0))
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 2.h,
                                            left: 4.w,
                                            right: 4.w,
                                            bottom: 0.75.h),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: widget.medicineType
                                                        .hasReservations !=
                                                    true
                                                ? () {
                                                    // if (_disableBooking) {
                                                    //   Navigator.pushNamed(
                                                    //     context,
                                                    //     AppRouterNames
                                                    //         .rQrcodeScan,
                                                    //     arguments:
                                                    //         ReservationArguments(
                                                    //       medicineTypeModel:
                                                    //           widget
                                                    //               .medicineType,
                                                    //       status: "",
                                                    //       type:
                                                    //           "allReservation",
                                                    //     ),
                                                    //   );
                                                    // } else {
                                                    ReservationCubit.get(
                                                            context)
                                                        .getServicesWithDiscount(
                                                      medicineTypeId: widget
                                                          .medicineType.id!,
                                                    );
                                                    // }
                                                  }
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                fixedSize: const Size(
                                                    double.infinity, 56),
                                                backgroundColor:
                                                    AppColors.primary),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    AppAssets.icQrCode),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                DefaultAppText(
                                                  text:
                                                      "احصل علي الخصم المجاني",
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.defaultWhite,
                                                  fontSize: 10.sp,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 0.75.h,
                                          left: 4.w,
                                          right: 4.w,
                                          bottom: 2.h),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: widget.medicineType
                                                      .hasReservations !=
                                                  true
                                              ? () {
                                                  if (PackageCubit.get(context)
                                                          .myPackageResponse
                                                          ?.data
                                                          ?.myPackage ==
                                                      null) {
                                                    Navigator.pushNamed(
                                                      context,
                                                      AppRouterNames
                                                          .rInsuranceCard,
                                                    );
                                                  } else {
                                                    ReservationCubit.get(
                                                            context)
                                                        .getServicesWithDiscount(
                                                      medicineTypeId: widget
                                                          .medicineType.id!,
                                                    );
                                                  }
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: AppColors.primary),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              fixedSize: const Size(
                                                  double.infinity, 56),
                                              backgroundColor:
                                                  AppColors.defaultWhite),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                AppAssets.icCreditCard,
                                                color: AppColors.primary,
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              FittedBox(
                                                child: DefaultAppText(
                                                  text:
                                                      "احصل علي خصم كارت التأمين السنوي",
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.primary,
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Theme(
                      data: ThemeData(useMaterial3: true),
                      child: Column(
                        children: [
                          Builder(builder: (context) {
                            var title = widget.medicineType.type!;
                            switch (title) {
                              case "عيادة":
                                title = context.about(context.doctor);
                                break;
                              case "مركز اشاعة":
                                title = context.about("مركز الاشاعة");
                                break;
                              case "صيدلية":
                                title = context.about("الصيدلية");
                                break;
                              case "معمل تحاليل":
                                title = context.about("معمل التحاليل");
                                break;
                              default:
                                break;
                            }
                            return DoctorsBottomDataViewItem(
                              leading: SvgPicture.asset(AppAssets.icInfo),
                              title: title,
                              expansions: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: DefaultAppText(
                                      text: widget.medicineType.aboutUs ??
                                          "Empty Text",
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                          DoctorsBottomDataViewItem(
                            title: context.workHours,
                            leading: SvgPicture.asset(AppAssets.icPace),
                            expansions: [
                              SizedBox(
                                width: 100.w,
                                height: 18.h,
                                child: ListView.builder(
                                  controller: _controller,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      widget.medicineType.schedule!.length,
                                  itemBuilder: (context, index) {
                                    return BlocBuilder<ReservationCubit,
                                        ReservationState>(
                                      builder: (context, state) {
                                        final cubit =
                                            ReservationCubit.get(context);
                                        return ScheduleWidget(
                                          book: !_disableBooking,
                                          loading: state
                                              is ReservationGetServicesWithDiscountLoadingState,
                                          scheduleModel: widget
                                              .medicineType.schedule![index],
                                          onTap: _disableBooking
                                              ? null
                                              : ({int? i}) {
                                                  if (!widget.medicineType
                                                          .hasReservations! &&
                                                      state
                                                          is! ReservationGetServicesWithDiscountLoadingState &&
                                                      state
                                                          is! ReservationGetServicesWithDiscountFailureState) {
                                                    cubit
                                                        .getServicesWithDiscount(
                                                      medicineTypeId: widget
                                                          .medicineType.id!,
                                                    );
                                                  }
                                                },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          DoctorsBottomDataViewItem(
                            title: context.address,
                            leading: SvgPicture.asset(AppAssets.icLocationOn),
                            subtitle: widget.medicineType.address ??
                                "Unknown address",
                            trailing: const SizedBox(),
                          ),
                          DoctorsBottomDataViewItem(
                            title: context.phone,
                            leading: SvgPicture.asset(AppAssets.icCall),
                            expansions: widget.medicineType.phoneNumbers!
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      start: 20,
                                      end: 20,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            phone(e);
                                          },
                                          child: DefaultAppText(
                                            text: e,
                                          ),
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          DoctorsBottomDataViewItem(
                            title: context.customersRating,
                            leading: SvgPicture.asset(AppAssets.icHotelClass),
                            trailing: const Icon(Icons.keyboard_arrow_left),
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRouterNames.rRates,
                            ),
                          ),
                          DoctorsBottomDataViewItem(
                            title: "اللوكيشن",
                            leading: SvgPicture.asset(AppAssets.icDirections),
                            trailing: const Icon(Icons.keyboard_arrow_left),
                            onTap: () {
                              navigateTo(
                                double.parse(widget
                                    .medicineType.locationModel!.latitude
                                    .toString()),
                                double.parse(widget
                                    .medicineType.locationModel!.longitude
                                    .toString()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
