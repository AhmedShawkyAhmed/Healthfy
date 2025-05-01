// ignore_for_file: deprecated_member_use

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
import 'package:healthify/src/presentation/router/hospital_arguments.dart';
import 'package:healthify/src/presentation/views/doctor_views/doctors_bottom_data_view_item.dart';
import 'package:healthify/src/presentation/views/doctor_views/doctors_top_data_view_item.dart';
import 'package:healthify/src/presentation/widgets/schedule_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../router/reservation_argumentd.dart';
import '../views/doctor_views/hospital_doctors_view.dart';
import '../widgets/default_app_text.dart';

class HospitalDetailsScreen extends StatefulWidget {
  const HospitalDetailsScreen({super.key, required this.medicineType});

  final MedicineTypeModel medicineType;

  @override
  State<HospitalDetailsScreen> createState() => _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState extends State<HospitalDetailsScreen> {
  final ValueNotifier<bool> _availToday = ValueNotifier(false);
  final _controller = ScrollController();

  phone(String phone) async {
    if (await canLaunchUrl(Uri.parse("tel://$phone"))) {
      await launchUrl(Uri.parse("tel://$phone"),
          mode: LaunchMode.externalApplication);
    }
  }

  @override
  void initState() {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15.w,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
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
                SizedBox(
                  width: 15.w,
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
                          const SizedBox(
                            width: 8,
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
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    SvgPicture.asset(AppAssets.icVerified),
                                  ],
                                ),
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
                            text1:
                                "${widget.medicineType.rewardPoints ?? 0} نقطة مكافئة",
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
                          if (widget.medicineType.normalDiscount != null &&
                              widget.medicineType.normalDiscount! > 0)
                            DoctorsTopDataViewItem(
                              icon: Icon(
                                Icons.discount,
                                size: 4.w,
                                color: AppColors.primary,
                              ),
                              text1: "${widget.medicineType.normalDiscount} %",
                              text2: "الخصم المجانى",
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
                              widget.medicineType.service?.every((element) =>
                                          element.offer?.isNotEmpty == true &&
                                          element.offer![0].discount != null &&
                                          num.tryParse(
                                                element.offer![0].discount!,
                                              ) ==
                                              0) ==
                                      true
                                  ? 1
                                  : 2,
                              (i) {
                                final isCardOnly = widget.medicineType.service
                                        ?.every((element) =>
                                            element.offer?.isNotEmpty == true &&
                                            element.offer![0].discount !=
                                                null &&
                                            num.tryParse(
                                                  element.offer![i].discount!,
                                                ) ==
                                                0) ==
                                    true;
                                return Container(
                                  height: 4.h,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 1.h),
                                  child: FittedBox(
                                    child: DefaultAppText(
                                      text: index == 0
                                          ? (i == 0 && !isCardOnly
                                              ? context.freeDiscount
                                              : context.insuranceCardDiscount)
                                          : widget.medicineType
                                                  .service![index - 1].offer!
                                                  .any(
                                              (element) =>
                                                  (element.type == 2 &&
                                                      i == 0) ||
                                                  (element.type == 1 && i == 1),
                                            )
                                              ? "${widget.medicineType.service![index - 1].offer![isCardOnly ? 1 : i].discount!} %"
                                              : "No Discount",
                                      textAlign: TextAlign.center,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColors.bGrey,
                    ),
                    if (widget.medicineType.doctor?.isEmpty == false) ...[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 1.h, bottom: 2.h, left: 5.w, right: 2.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DefaultAppText(
                              text: "الأطباء المتخصصين",
                              color: AppColors.defaultBlack,
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouterNames.rSpecialistDoctors,
                                  arguments: HospitalArguments(
                                    name: widget.medicineType.name ?? "",
                                    doctors: widget.medicineType.doctor ?? [],
                                  ),
                                );
                              },
                              child: DefaultAppText(
                                text: "عرض المزيد",
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: 8.sp,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 1.h, bottom: 3.h, left: 5.w, right: 2.w),
                        child: SizedBox(
                          width: 100.w,
                          height: 18.h,
                          child: widget.medicineType.doctor?.isEmpty == true
                              ? const Center(
                                  child: DefaultAppText(
                                    text: "Empty Doctors!",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: widget.medicineType.doctor?.length,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return HospitalDoctorView(
                                      image:
                                          EndPoints.imageBaseUrlMedicineType +
                                              widget.medicineType.doctor![index]
                                                  .image!,
                                      name: widget.medicineType.doctor?[index]
                                              .name ??
                                          "",
                                      department: widget.medicineType
                                              .doctor?[index].title ??
                                          "",
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                    Container(
                      color: AppColors.defaultWhite,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.h,
                                left: 4.w,
                                right: 4.w,
                                bottom: 0.75.h),
                            child: SizedBox(
                              width: double.infinity,
                              child: BlocConsumer<ReservationCubit,
                                  ReservationState>(
                                listener: (context, state) {
                                  if (widget.medicineType.service!.isNotEmpty) {
                                    if (state
                                        is ReservationGetServicesWithDiscountSuccessState) {
                                      if (!widget
                                          .medicineType.hasReservations!) {
                                        Navigator.pushNamed(
                                          context,
                                          AppRouterNames.rBookingDiscount,
                                          arguments: ReservationArguments(
                                            medicineTypeModel:
                                                widget.medicineType,
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
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ElevatedButton(
                                          onPressed: widget
                                                  .medicineType.hasReservations!
                                              ? null
                                              : () {
                                                  ReservationCubit.get(context)
                                                      .getServicesWithDiscount(
                                                    medicineTypeId:
                                                        widget.medicineType.id!,
                                                  );
                                                },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
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
                                                text: "احصل علي الخصم المجاني",
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.defaultWhite,
                                                fontSize: 10.sp,
                                              ),
                                            ],
                                          ),
                                        );
                                },
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
                                onPressed:
                                    widget.medicineType.hasReservations != true
                                        ? () {
                                            if (PackageCubit.get(context)
                                                    .myPackageResponse
                                                    ?.data
                                                    ?.myPackage ==
                                                null) {
                                              Navigator.pushNamed(
                                                context,
                                                AppRouterNames.rInsuranceCard,
                                              );
                                            } else {
                                              ReservationCubit.get(context)
                                                  .getServicesWithDiscount(
                                                medicineTypeId:
                                                    widget.medicineType.id!,
                                              );
                                            }
                                          }
                                        : null,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: AppColors.primary),
                                        borderRadius: BorderRadius.circular(8)),
                                    fixedSize: const Size(double.infinity, 56),
                                    backgroundColor: AppColors.defaultWhite),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Theme(
                      data: ThemeData(useMaterial3: true),
                      child: Column(
                        children: [
                          DoctorsBottomDataViewItem(
                            leading: SvgPicture.asset(AppAssets.icInfo),
                            title: widget.medicineType.type == "مركز تخصصي"
                                ? context.about("المركز التخصصى")
                                : context
                                    .about("ال${widget.medicineType.type!}"),
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
                          ),
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
                                            book: true,
                                            loading: state
                                                is ReservationGetServicesWithDiscountLoadingState,
                                            scheduleModel: widget
                                                .medicineType.schedule![index],
                                            onTap: ({int? i}) {
                                              if (!widget.medicineType
                                                      .hasReservations! &&
                                                  state
                                                      is! ReservationGetServicesWithDiscountLoadingState &&
                                                  state
                                                      is! ReservationGetServicesWithDiscountFailureState) {
                                                cubit.getServicesWithDiscount(
                                                  medicineTypeId:
                                                      widget.medicineType.id!,
                                                );
                                              }
                                            },
                                          );
                                        },
                                      );
                                    }),
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
