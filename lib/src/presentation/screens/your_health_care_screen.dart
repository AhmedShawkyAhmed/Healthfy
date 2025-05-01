import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthify/src/business_logic/app_content_cubit/app_content_cubit.dart';
import 'package:healthify/src/constants/assets.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/const_variables.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';

class YourHealthCareScreen extends StatefulWidget {
  const YourHealthCareScreen({super.key, required this.type});

  final String type;

  @override
  State<YourHealthCareScreen> createState() => _YourHealthCareScreenState();
}

class _YourHealthCareScreenState extends State<YourHealthCareScreen> {
  TextEditingController commentController = TextEditingController();
  double rate = 4;

  whatsApp(String phone) async {
    if (await canLaunchUrl(Uri.parse("https://wa.me/$phone"))) {
      await launchUrl(Uri.parse("https://wa.me/$phone"),
          mode: LaunchMode.externalApplication);
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
    return BlocProvider(
      create: (context) => AppContentCubit()..getPhone(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.primary,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 50,
                bottom: 20,
              ),
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
                    child: Column(
                      children: [
                        DefaultAppText(
                          text: context.yourHealthCare,
                          textAlign: TextAlign.center,
                          color: AppColors.defaultWhite,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DefaultAppText(
                          text: widget.type,
                          textAlign: TextAlign.center,
                          color: AppColors.defaultWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  const IconButton(
                    onPressed: shareApp,
                    icon: Icon(
                      Icons.share_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.primaryOpacity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: AppColors.defaultWhite,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 85,
                                  width: 85,
                                  child: Image.asset(
                                    AppAssets.icLogo,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                DefaultAppText(
                                  text: context.healthify,
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SvgPicture.asset(AppAssets.icVerified)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (widget.type == context.pharmacy ||
                                            widget.type ==
                                                context.homeNursing ||
                                            widget.type == context.askDoctor ||
                                            widget.type == context.homeCare)
                                          DefaultAppText(
                                            text: widget.type ==
                                                    context.pharmacy
                                                ? context.askForMedicine
                                                : widget.type ==
                                                        context.homeNursing
                                                    ? context.askForHomeNursing
                                                    : widget.type ==
                                                            context.askDoctor
                                                        ? context.talkToDoctor
                                                        : widget.type ==
                                                                context.homeCare
                                                            ? context
                                                                .askForHomeCare
                                                            : '',
                                            color: AppColors.primary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        if (widget.type == context.homeCare ||
                                            widget.type == context.ambulance ||
                                            widget.type == context.askDoctor ||
                                            widget.type == context.pharmacy)
                                          DefaultAppText(
                                            text: widget.type ==
                                                    context.pharmacy
                                                ? context.pharmacySub
                                                : widget.type ==
                                                        context.askDoctor
                                                    ? context.askDocSub
                                                    : widget.type ==
                                                            context.ambulance
                                                        ? context
                                                            .askForAmbulance
                                                        : widget.type ==
                                                                context.homeCare
                                                            ? context
                                                                .homeCareTypes
                                                            : "",
                                            color: AppColors.primary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        if (widget.type == context.pharmacy)
                                          const SizedBox(
                                            height: 16,
                                          ),
                                        if (widget.type == context.pharmacy ||
                                            widget.type == context.ambulance ||
                                            widget.type == context.homeCare ||
                                            widget.type == context.homeNursing)
                                          DefaultAppText(
                                            text: widget.type ==
                                                        context.ambulance ||
                                                    widget.type ==
                                                        context.homeCare ||
                                                    widget.type ==
                                                        context.homeNursing
                                                ? context.freeDiscountOnRequest
                                                : context.freePharmacyDelivery,
                                            color: AppColors.green,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Image.asset(
                                      widget.type == context.pharmacy
                                          ? AppAssets.imgPharmacy
                                          : widget.type == context.homeNursing
                                              ? AppAssets.imgHomeNursing
                                              : widget.type == context.askDoctor
                                                  ? AppAssets.imgAskDoctor
                                                  : widget.type ==
                                                          context.ambulance
                                                      ? AppAssets.imgAmbulance
                                                      : AppAssets.imgHomeCare,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (widget.type == context.pharmacy)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 16),
                                decoration: BoxDecoration(
                                    color: AppColors.green2,
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: AppColors.green1)),
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const RotatedBox(
                                        quarterTurns: 2,
                                        child:
                                            Icon(Icons.error_outline_rounded)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: DefaultAppText(
                                        text: context
                                            .allMedicineIsSoldThroughLicensedPharmacies,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<AppContentCubit, AppContentState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: reveChat.gotoReveChat,
                            child: Container(
                              color: AppColors.defaultWhite,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 16),
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                          height: 32,
                                          width: 32,
                                          child: Image.asset(
                                              AppAssets.imgAskDoctor)),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      DefaultAppText(
                                        text: widget.type == context.pharmacy ||
                                                widget.type ==
                                                    context.ambulance ||
                                                widget.type ==
                                                    context.homeNursing ||
                                                widget.type == context.homeCare
                                            ? context.requestNow
                                            : widget.type == context.askDoctor
                                                ? context.askNow
                                                : context
                                                    .communicateWithCustomerService,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  const Icon(Icons.arrow_forward_ios_rounded)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
