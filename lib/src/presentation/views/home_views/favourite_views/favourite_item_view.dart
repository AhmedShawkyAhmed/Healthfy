import 'package:flutter/material.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/presentation/views/home_views/favourite_views/favourite_text_item_view.dart';

class FavouriteItemView extends StatelessWidget {
  const FavouriteItemView({
    super.key,
    this.onTap,
    required this.name,
    required this.rate,
    required this.ratesCount,
    required this.location,
    this.discount,
    this.reward,
    this.specialities,
    this.insuranceDiscount,
    required this.image,
    this.specialitiesMaxLines,
    this.nameMaxLines,
    this.padding,
    this.height,
  });

  final Function()? onTap;
  final String name;
  final String rate;
  final String ratesCount;
  final String location;
  final String? discount;
  final String? specialities;
  final String? reward;
  final String? insuranceDiscount;
  final Widget image;
  final int? specialitiesMaxLines;
  final int? nameMaxLines;
  final EdgeInsets? padding;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height == 0 ? null : context.responsiveHeight(180),
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: context.responsiveWidth(16),
              vertical: context.responsiveHeight(10),
            ),
        decoration: BoxDecoration(
          color: AppColors.defaultWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 98,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: AppColors.grey6,
                ),
              ),
              child: image,
            ),
            SizedBox(
              width: context.responsiveWidth(12),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: context.responsiveHeight(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            maxLines: nameMaxLines,
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
                  ),
                  if (specialities != null && specialities != "")
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.responsiveHeight(4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              specialities.toString(),
                              maxLines: specialitiesMaxLines,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                fontFamily: 'Alexandria',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (rate != "")
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.responsiveHeight(4),
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppColors.yellow,
                              ),
                              SizedBox(
                                width: context.responsiveWidth(4),
                              ),
                              Text(
                                rate,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Alexandria',
                                  color: AppColors.defaultBlack,
                                ),
                              ),
                              SizedBox(
                                width: context.responsiveWidth(4),
                              ),
                              Text(
                                ratesCount,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Alexandria',
                                  color: AppColors.grey3,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  if (location != "")
                    FavouriteTextItemView(
                      icon: Image.asset(
                        AppAssets.icLocation,
                        width: 16,
                        height: 16,
                      ),
                      text: location,
                      textColor: AppColors.defaultBlack,
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (discount != null)
                            Expanded(
                              child: FavouriteTextItemView(
                                icon: const Icon(
                                  Icons.confirmation_num,
                                  color: AppColors.red,
                                  size: 16,
                                ),
                                text: discount!,
                                textColor: AppColors.red,
                              ),
                            ),
                          if (reward != null && discount != null)
                            SizedBox(
                              width: context.responsiveWidth(12),
                            ),
                          if (reward != null)
                            Expanded(
                              child: FavouriteTextItemView(
                                icon: const Icon(
                                  Icons.monetization_on,
                                  color: AppColors.orange,
                                  size: 16,
                                ),
                                text: reward!,
                                textColor: AppColors.orange,
                              ),
                            ),
                        ],
                      ),
                      if (insuranceDiscount != null)
                        Row(
                          children: [
                            Expanded(
                              child: FavouriteTextItemView(
                                icon: const Icon(
                                  Icons.credit_card,
                                  color: AppColors.blue1,
                                  size: 16,
                                ),
                                text: insuranceDiscount!,
                                textColor: AppColors.blue1,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
