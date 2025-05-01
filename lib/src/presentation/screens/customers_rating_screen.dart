import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthify/src/business_logic/medicine_type_cubit/medicine_type_cubit.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../router/app_router_names.dart';
import '../widgets/default_app_text.dart';

class CustomersRatingScreen extends StatelessWidget {
  const CustomersRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(top: 40),
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
                  child: DefaultAppText(
                    text: context.customersRate,
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
          ),
          Expanded(
            child: Container(
              color: AppColors.primaryOpacity,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 10),
                child: BlocBuilder<MedicineTypeCubit, MedicineTypeState>(
                  builder: (context, state) {
                    final rates =
                        MedicineTypeCubit.get(context).selectedModel?.rates ??
                            [];
                    return ListView.builder(
                      itemCount: rates.length,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                            color: AppColors.defaultWhite,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                DefaultAppText(
                                  text: context.rating,
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                RatingBarIndicator(
                                  rating: rates[index].rate!.toDouble(),
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemSize: 14,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            DefaultAppText(
                              text: rates[index].comment ?? "Empty Comment",
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            if (rates[index].createdAt != null)
                              const SizedBox(
                                height: 8,
                              ),
                            if (rates[index].createdAt != null)
                              DefaultAppText(
                                text: DateFormat("dd/MM/yyyy").format(
                                  DateTime.parse(
                                    rates[index].createdAt!,
                                  ),
                                ),
                                color: AppColors.grey3,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h,),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouterNames.rAddRate);
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              fixedSize: const Size(double.infinity, 56),
              backgroundColor: AppColors.primary),
          child: DefaultAppText(
            text: context.addRate,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.defaultWhite,
          ),
        ),
      ),
    );
  }
}
