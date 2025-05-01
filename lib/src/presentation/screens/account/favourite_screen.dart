import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/Favourite_cubit/favourite_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/views/home_views/favourite_views/favourite_item_view.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    FavouriteCubit.get(context).getMyFavourites();
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
          context.favourite,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultWhite,
            fontWeight: FontWeight.w500,
            fontFamily: "Alexandria",
          ),
        ),
      ),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          final fav = FavouriteCubit.get(context).favourites;
          return state is FavouriteGetLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : fav.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.hourglass_empty_rounded,
                            color: AppColors.primary,
                            size: 100,
                          ),
                          SizedBox(
                            height: context.responsiveHeight(20),
                          ),
                          const DefaultAppText(
                            text: "لا يوجد منشآت مفضلة بعد!",
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveWidth(16),
                        vertical: context.responsiveHeight(12),
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => FavouriteItemView(
                        onTap: () {
                          if (fav[index].favMedicineType?.type == "Hospital") {
                            Navigator.pushNamed(
                              context,
                              AppRouterNames.rHospitalDetails,
                              arguments: fav[index].favMedicineType,
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              AppRouterNames.rDoctorDetails,
                              arguments: fav[index].favMedicineType,
                            );
                          }
                        },
                        image: fav[index].favMedicineType?.image != null
                            ? Image.network(
                                "${EndPoints.imageBaseUrlMedicineType}${fav[index].favMedicineType?.image}",
                                fit: BoxFit.cover,
                                loadingBuilder: (c, w, i) => i != null
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          value: (i.cumulativeBytesLoaded /
                                              i.expectedTotalBytes!),
                                        ),
                                      )
                                    : w,
                                errorBuilder: (c, o, s) => const Icon(
                                  Icons.image,
                                  size: 100,
                                  color: AppColors.primary,
                                ),
                              )
                            : const Icon(
                                Icons.image,
                                size: 100,
                                color: AppColors.primary,
                              ),
                        name: fav[index].favMedicineType?.name ?? "",
                        rate: fav[index].favMedicineType?.ratesAvg ?? "0.0",
                        ratesCount:
                            "(${fav[index].favMedicineType?.ratesCount})",
                        location: fav[index].favMedicineType?.address ??
                            "Empty Address",
                        discount: fav[index].favMedicineType?.normalDiscount ==
                                null
                            ? null
                            : "خصم مجاني ${fav[index].favMedicineType?.normalDiscount} %",
                        insuranceDiscount: fav[index]
                                    .favMedicineType
                                    ?.packageDiscount ==
                                null
                            ? null
                            : "خصم كارت التأمين السنوي ${fav[index].favMedicineType?.packageDiscount} %",
                        reward: "${fav[index].favMedicineType?.rewardPoints} نقاط مكافئة",
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: context.responsiveHeight(12),
                      ),
                      itemCount: fav.length,
                    );
        },
      ),
    );
  }
}
