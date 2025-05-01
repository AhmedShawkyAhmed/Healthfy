import 'package:flutter/material.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../router/hospital_arguments.dart';
import '../views/home_views/favourite_views/favourite_item_view.dart';
import '../widgets/default_app_text.dart';

class SpecialistDoctorsScreen extends StatelessWidget {
  final HospitalArguments hospitalArguments;

  const SpecialistDoctorsScreen({
    Key? key,
    required this.hospitalArguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(top: 50, bottom: 20),
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      DefaultAppText(
                        text: hospitalArguments.name,
                        textAlign: TextAlign.center,
                        color: AppColors.grey4,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const DefaultAppText(
                        text: "الدكاترة المتخصصين",
                        textAlign: TextAlign.center,
                        color: AppColors.grey1,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.primaryOpacity,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => FavouriteItemView(
                  specialitiesMaxLines: 5,
                  nameMaxLines: 5,
                  height: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  image: Image.network(
                    EndPoints.imageBaseUrlMedicineType +
                        hospitalArguments.doctors[index].image!,
                    fit: BoxFit.contain,
                    errorBuilder: (c, o, s) => const Icon(
                      Icons.image,
                      size: 100,
                      color: AppColors.primary,
                    ),
                  ),
                  onTap: null,
                  name: hospitalArguments.doctors[index].name ?? "",
                  rate: "",
                  ratesCount: "",
                  location: "",
                  specialities: hospitalArguments.doctors[index].title ?? "",
                ),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 1.h,
                  );
                },
                itemCount: hospitalArguments.doctors.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
