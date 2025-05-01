import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthify/src/business_logic/medicine_type_cubit/medicine_type_cubit.dart';
import 'package:healthify/src/business_logic/rate_cubit/rate_cubit.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/data/request/add_rate_request.dart';
import 'package:healthify/src/data/shared_models/rate_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';

import '../../constants/colors.dart';

class AddRatingScreen extends StatefulWidget {
  const AddRatingScreen({super.key});

  @override
  State<AddRatingScreen> createState() => _AddRatingScreenState();
}

class _AddRatingScreenState extends State<AddRatingScreen> {
  TextEditingController commentController = TextEditingController();
  double rate = 4;

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
                    text: context.addRate,
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Image.asset(AppAssets.imgStar),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultAppText(
                      text: context.addYourRate,
                      color: AppColors.primary,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    RatingBar.builder(
                      initialRating: rate,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        debugPrint(rating.toString());
                        rate = rating;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: commentController,
                      maxLines: 5,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                          hintText: context.addComment,
                          hintStyle: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          filled: true,
                          fillColor: AppColors.primaryOpacity,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 75),
                            child: Column(
                              children: [
                                SvgPicture.asset(AppAssets.icEdit),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: AppColors.defaultTransparent,
                                  width: 0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: AppColors.defaultTransparent,
                                  width: 1.8)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: AppColors.defaultTransparent,
                                  width: 1.8))),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 50,
                        horizontal: 20,
                      ),
                      width: double.infinity,
                      child: BlocConsumer<RateCubit, RateState>(
                        listener: (context, state) {
                          if (state is RateAddSuccessState) {
                            final model =
                                MedicineTypeCubit.get(context).selectedModel;
                            final rateModel = RateModel(
                              rate: rate,
                              comment: commentController.text.trim().isEmpty
                                  ? null
                                  : commentController.text.trim(),
                              createdAt: DateTime.timestamp().toString(),
                            );
                            model!.rates!.add(rateModel);
                            MedicineTypeCubit.get(context)
                                .updateSelectedModel(model);
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, state) {
                          return state is RateAddLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    final request = AddRateRequest(
                                      id: MedicineTypeCubit.get(context)
                                          .selectedModel!
                                          .id!,
                                      rate: rate,
                                      comment:
                                          commentController.text.trim().isEmpty
                                              ? null
                                              : commentController.text.trim(),
                                    );
                                    RateCubit.get(context)
                                        .addRate(request: request);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      fixedSize:
                                          const Size(double.infinity, 56),
                                      backgroundColor: AppColors.primary),
                                  child: DefaultAppText(
                                    text: context.send,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.defaultWhite,
                                    fontSize: 18,
                                  ),
                                );
                        },
                      ),
                    )
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
