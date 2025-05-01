import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:healthify/src/business_logic/home_cubit/home_cubit.dart';
import 'package:healthify/src/business_logic/location_cubit/location_cubit.dart';
import 'package:healthify/src/business_logic/medicine_type_cubit/medicine_type_cubit.dart';
import 'package:healthify/src/business_logic/reservation_cubit/reservation_cubit.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/views/home_views/reservation_view.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/const_variables.dart';
import '../../router/app_router_names.dart';
import '../../router/reservation_argumentd.dart';
import '../../widgets/text_input_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();
  final ValueNotifier<bool> _enableLeft = ValueNotifier(true);
  final ValueNotifier<bool> _enableRight = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset == 0) {
        _enableLeft.value = true;
        _enableRight.value = false;
      } else if (_scrollController.offset > 0 &&
          !_scrollController.position.atEdge) {
        _enableLeft.value = true;
        _enableRight.value = true;
      } else {
        _enableLeft.value = false;
        _enableRight.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BlocBuilder<LocationCubit, LocationState>(
                      builder: (context, state) {
                        final isAM = DateFormat("hh:mm a")
                            .format(
                              DateTime.now(),
                            )
                            .contains(
                              "AM",
                            );
                        final cubit = LocationCubit.get(context);
                        return cubit.locations.isEmpty
                            ? Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: FittedBox(
                                  child: Text.rich(
                                    TextSpan(
                                        text: isAM
                                            ? 'صباح الخير '
                                            : 'مساء الخير ',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: AuthCubit.get(context)
                                                .user
                                                ?.name,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: AppColors.defaultBlack,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              )
                            : DropdownButton(
                                value: cubit.locations.first,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.primary,
                                ),
                                isDense: true,
                                isExpanded: true,
                                underline: const SizedBox(),
                                items: cubit.locations
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        onTap: () {
                                          LocationCubit.get(context)
                                              .updateCurrentLocation(e);
                                        },
                                        child: Text(
                                          e.address ?? "Unknown address",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.primary,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {},
                              );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      const Text('صحتك تهمنا',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(width: 5),
                      Image.asset(
                        AppAssets.icLogo,
                        height: 40,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final ads = HomeCubit.get(context).ads;
                final loading = state is HomeGetAdsLoadingState;
                return loading
                    ? const SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : CarouselSlider(
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {},
                          viewportFraction: .8,
                          enlargeFactor: 0.28,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                        ),
                        items: ads.map(
                          (e) {
                            return InkWell(
                              onTap: () {
                                if (e.key ==
                                    "Hospital" ||
                                    e.key ==
                                        "Medical Center") {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouterNames
                                        .rHospitalDetails,
                                    arguments:
                                    e.medicineType,
                                  );
                                } else {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouterNames
                                        .rDoctorDetails,
                                    arguments:
                                    e.medicineType,
                                  );
                                }
                              },
                              child: Container(
                                alignment: AlignmentDirectional.bottomStart,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.grey5,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "${EndPoints.imageBaseUrlMedicineType}${e.banner}",
                                      ),
                                      onError: (e, s) {
                                        logError(
                                            "Home Ads Network Image error: $e");
                                      },
                                      fit: BoxFit.fill),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Container(
                                  height: 12.h,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.defaultBlack.withOpacity(0.7),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: const [
                                        0.3,
                                        1,
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      DefaultAppText(
                                        text: e.title,
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      DefaultAppText(
                                        text: e.description,
                                        color: Colors.white,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: BlocBuilder<ReservationCubit, ReservationState>(
                      builder: (context, state) {
                        final reservations =
                            ReservationCubit.get(context).myWaitingReservations;
                        return reservations.isEmpty
                            ? const SizedBox()
                            : SizedBox(
                                height: 13.h,
                                width: 100.w,
                                child: ListView.builder(
                                  itemCount: reservations.length,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return ReservationView(
                                      title: reservations[index]
                                              .medicineTypeModel
                                              ?.name ??
                                          "",
                                      status: reservations[index].status ?? "",
                                      onCancel: () {},
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRouterNames.rBookingDiscount,
                                          arguments: ReservationArguments(
                                            myReservationModel:
                                                reservations[index],
                                            medicineTypeModel:
                                                reservations[index]
                                                    .medicineTypeModel!,
                                            type: "oneReservation",
                                            status:
                                                reservations[index].status ??
                                                    "",
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FieldWithLabel(
                      fillColor: Colors.white,
                      filled: true,
                      readOnly: true,
                      onTap: () {
                        HomeCubit.get(context).changeBottomIndex(1);
                      },
                      prefix: const Icon(
                        Icons.search,
                        color: AppColors.green,
                      ),
                      label: 'ابحث عن صيدلية, عيادة, مستشفي ...',
                      hasLabel: false,
                      cursorColor: AppColors.primaryGreen,
                      borderColor: AppColors.primaryGreen,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'صحتك تهمنا',
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ListView.separated(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemBuilder: (context, index) => Center(
                              child: InkWell(
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.pushNamed(
                                      context,
                                      AppRouterNames.rWebView,
                                      arguments: [
                                        "خدمات بالتقسيط",
                                        'https://sehtak.com.eg/services/4b4ea800-55ae-442a-bd2f-3bb898b36213/',
                                      ],
                                    );
                                  }
                                  if (index == 1) {
                                    Navigator.pushNamed(
                                        context, AppRouterNames.rMedicalRecord);
                                  }
                                  if (index == 2) {
                                    Navigator.pushNamed(
                                        context, AppRouterNames.rYourHealthCare,
                                        arguments: context.pharmacy);
                                  }
                                  if (index == 3) {
                                    Navigator.pushNamed(
                                        context, AppRouterNames.rYourHealthCare,
                                        arguments: context.askDoctor);
                                  }
                                  if (index == 4) {
                                    Navigator.pushNamed(
                                        context, AppRouterNames.rYourHealthCare,
                                        arguments: context.ambulance);
                                  }
                                  if (index == 5) {
                                    Navigator.pushNamed(
                                        context, AppRouterNames.rYourHealthCare,
                                        arguments: context.homeNursing);
                                  }
                                  if (index == 6) {
                                    Navigator.pushNamed(
                                        context, AppRouterNames.rYourHealthCare,
                                        arguments: context.homeCare);
                                  }
                                },
                                child: Container(
                                  width: 30.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 2),
                                  child: FittedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(homeList[index].image),
                                        const SizedBox(height: 10),
                                        Text(
                                          homeList[index].title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            itemCount: 7,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 10,
                            ),
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 0,
                          top: 0,
                          child: ValueListenableBuilder(
                            valueListenable: _enableLeft,
                            builder: (context, left, child) {
                              return left
                                  ? InkWell(
                                      onTap: () {
                                        _scrollController.animateTo(
                                          _scrollController.offset + 150,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Center(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: AppColors.grey4,
                                            shape: BoxShape.circle,
                                          ),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          padding: const EdgeInsets.all(8.0),
                                          child: const RotatedBox(
                                            quarterTurns: 2,
                                            child: Icon(
                                              Icons.arrow_back_ios_new,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container();
                            },
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 0,
                          top: 0,
                          child: ValueListenableBuilder(
                            valueListenable: _enableRight,
                            builder: (context, right, child) {
                              return right
                                  ? InkWell(
                                      onTap: () {
                                        _scrollController.animateTo(
                                          _scrollController.offset - 150,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Center(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: AppColors.grey4,
                                            shape: BoxShape.circle,
                                          ),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Icon(
                                              Icons.arrow_back_ios_sharp),
                                        ),
                                      ),
                                    )
                                  : Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'الأقسام',
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocBuilder<MedicineTypeCubit, MedicineTypeState>(
                      builder: (context, state) {
                        final categories = MedicineTypeCubit.get(context)
                            .medicineTypeCategories;
                        if (state is MedicineTypeGetTypesLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            crossAxisCount: 3,
                            mainAxisSpacing: 5,
                            childAspectRatio: 9 / 10,
                            crossAxisSpacing: 5,
                            shrinkWrap: true,
                            children: categories
                                .map((e) => Center(
                                      child: InkWell(
                                        onTap: () {
                                          if (e.key == "Hospital" ||
                                              e.key == "Clinic" ||
                                              e.key == "Medical Center") {
                                            Navigator.pushNamed(
                                              context,
                                              AppRouterNames.rClinics,
                                              arguments: e,
                                            );
                                          } else {
                                            Navigator.pushNamed(
                                              context,
                                              AppRouterNames.rLocationRegions,
                                              arguments: [e, null],
                                            );
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                e.logo!,
                                                width: 40,
                                                loadingBuilder:
                                                    (context, child, image) =>
                                                        image != null
                                                            ? Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  value: image
                                                                          .cumulativeBytesLoaded /
                                                                      image
                                                                          .expectedTotalBytes!,
                                                                ),
                                                              )
                                                            : child,
                                                errorBuilder:
                                                    (context, error, stack) =>
                                                        const Icon(
                                                  Icons.error,
                                                  color: AppColors.red,
                                                ),
                                              ),
                                              const SizedBox(height: 14),
                                              Text(
                                                e.nameAr!,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
