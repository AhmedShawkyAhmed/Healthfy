import 'package:flutter/material.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/data/models/medicine_type_doctors_model.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/views/home_views/favourite_views/favourite_text_item_view.dart';

class MedicineTypeDoctorCardView extends StatelessWidget {
  const MedicineTypeDoctorCardView({super.key, required this.doctor});

  final MedicineTypeDoctorsModel doctor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouterNames.rHospitalDetails,
          arguments: doctor.medicineType,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.defaultWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            doctor.doctorImage != null
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.network(
                      "${EndPoints.imageBaseUrlMedicineType}${doctor.doctorImage}",
                      fit: BoxFit.cover,
                      width: 80,
                      errorBuilder: (c, o, s) => const Icon(
                        Icons.image,
                        size: 100,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.image,
                    size: 100,
                    color: AppColors.primary,
                  ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          doctor.doctorName!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Alexandria',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: context.responsiveWidth(8),
                      ),
                      Image.asset(
                        AppAssets.icNewRelease,
                        width: 16,
                        height: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    doctor.medicineType!.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'Alexandria',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    doctor.doctorSpeciality!,
                    style: const TextStyle(
                      color: AppColors.grey3,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      fontFamily: 'Alexandria',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (doctor.medicineType?.normalDiscount != null &&
                              doctor.medicineType?.normalDiscount != 0)
                            Expanded(
                              child: FavouriteTextItemView(
                                icon: const Icon(
                                  Icons.confirmation_num,
                                  color: AppColors.red,
                                  size: 16,
                                ),
                                text:
                                    "خصم مجاني ${doctor.medicineType!.normalDiscount} %",
                                textColor: AppColors.red,
                              ),
                            ),
                          if (doctor.medicineType?.normalDiscount != null &&
                              doctor.medicineType?.normalDiscount != 0)
                            SizedBox(
                              width: context.responsiveWidth(12),
                            ),
                          const Expanded(
                            child: FavouriteTextItemView(
                              icon: Icon(
                                Icons.monetization_on,
                                color: AppColors.orange,
                                size: 16,
                              ),
                              text: "20 نقاط مكافئة",
                              textColor: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                      if (doctor.medicineType?.packageDiscount != null &&
                          doctor.medicineType?.packageDiscount != 0)
                        Row(
                          children: [
                            Expanded(
                              child: FavouriteTextItemView(
                                icon: const Icon(
                                  Icons.credit_card,
                                  color: AppColors.blue1,
                                  size: 16,
                                ),
                                text:
                                    "خصم كارت التأمين السنوي ${doctor.medicineType!.packageDiscount} %",
                                textColor: AppColors.blue1,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
