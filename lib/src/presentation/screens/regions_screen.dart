import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/location_cubit/location_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/data/models/category_model.dart';
import 'package:healthify/src/data/shared_models/region_model.dart';
import 'package:healthify/src/data/shared_models/specialty_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:sizer/sizer.dart';

import '../router/app_router_names.dart';
import '../widgets/default_app_text.dart';
import '../widgets/text_input_field.dart';

class RegionScreen extends StatefulWidget {
  const RegionScreen({
    super.key,
    required this.category,
    required this.specialty,
    //required this.city,
  });

  final CategoryModel category;
  final SpecialtyModel? specialty;

  //final CityModel city;

  @override
  State<RegionScreen> createState() => _RegionScreenState();
}

class _RegionScreenState extends State<RegionScreen> {
  List<RegionModel> regions = [];

  @override
  void initState() {
    super.initState();
    LocationCubit.get(context).getRegions(1);
    LocationCubit.get(context).getCities();
  }

  TextEditingController searchController = TextEditingController();
  bool search = false;

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.only(top: 40, bottom: 1),
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
                    text: context.chooseRegion,
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
                label: 'ابحث عن منطقة ...',
                hasLabel: false,
                cursorColor: AppColors.grey3,
                borderColor: AppColors.grey4,
              ),
            ),
          ],
          Expanded(
            child: Container(
              color: AppColors.primaryOpacity,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
              child: BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  final cities = LocationCubit.get(context).cities;
                  return state is LocationGetRegionsLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ValueListenableBuilder(
                          valueListenable: searchController,
                          builder: (context, text, child) {
                            if (text.text.trim().isNotEmpty) {
                              regions = LocationCubit.get(context)
                                  .regions
                                  .where(
                                    (element) =>
                                        element.regions!.contains(text.text),
                                  )
                                  .toList();
                            } else {
                              regions = LocationCubit.get(context).regions;
                            }
                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouterNames.rSearchAreaDoctors,
                                    arguments: [
                                      widget.category,
                                      widget.specialty,
                                      index == 0 ? null : cities[0],
                                      index == 0 ? null : regions[index - 1],
                                    ],
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 1.5.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.defaultWhite,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      DefaultAppText(
                                        text: index == 0
                                            ? "جميع المناطق"
                                            : regions[index - 1].regions ??
                                                "Unknown",
                                        textAlign: TextAlign.center,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      const Icon(
                                        // index == 0
                                        //     ? Icons.my_location
                                        //     :
                                        Icons.arrow_forward_ios_rounded,
                                        color:
                                            // index == 0 ? Colors.red :
                                            Colors.black,
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
                              itemCount: regions.length + 1,
                            );
                          });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
