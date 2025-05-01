import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/location_cubit/location_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/data/shared_models/specialty_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:sizer/sizer.dart';

import '../router/app_router_names.dart';
import '../widgets/default_app_text.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({
    super.key,
    required this.category,
    required this.specialty,
  });

  final String category;
  final SpecialtyModel specialty;

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  void initState() {
    super.initState();
    if (LocationCubit.get(context).cities.isEmpty) {
      LocationCubit.get(context).getCities();
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
                    text: context.chooseCity,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.primaryOpacity,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
              child: BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  final cities = LocationCubit.get(context).cities;
                  return state is LocationGetCitiesLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRouterNames.rLocationRegions,
                                arguments: [
                                  widget.category,
                                  widget.specialty,
                                  cities[index],
                                ],
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: AppColors.defaultWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultAppText(
                                    text: cities[index].city ?? "Unknown",
                                    textAlign: TextAlign.center,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_rounded,
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
                          itemCount: cities.length,
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
