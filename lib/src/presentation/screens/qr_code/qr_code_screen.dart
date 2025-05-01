// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/constants/qr_code_scanner_overlay.dart';
import 'package:healthify/src/data/request/reservation_confirmation_request.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/router/reservation_argumentd.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../business_logic/reservation_cubit/reservation_cubit.dart';
import '../../../constants/const_variables.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key, required this.reservationArguments});

  final ReservationArguments reservationArguments;

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  late final MobileScannerController _cameraController;
  bool _stopScan = false;

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
    _cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.unrestricted,
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
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
          context.scanCode,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultWhite,
            fontWeight: FontWeight.w500,
            fontFamily: "Alexandria",
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Center(
              child: BlocListener<ReservationCubit, ReservationState>(
                listener: (context, state) {
                  if (state is ReservationConfirmReservationSuccessState) {
                    Navigator.pop(context);
                    if (state.paymentUrl == null ||
                        state.paymentUrl is! String) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRouterNames.rBookingDone,
                        arguments: "تم الحصول علي الخصم",
                      );
                    } else {
                      Navigator.pushNamed(
                        context,
                        AppRouterNames.rChargeBalance,
                        arguments: state.paymentUrl,
                      ).then((value) {
                        if (value == true) {
                          ReservationCubit.get(context)
                              .updateReservationAfterConfirmation(
                            widget.reservationArguments.myReservationModel!.id!,
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            AppRouterNames.rBookingDone,
                            arguments: "تم الحصول علي الخصم",
                          );
                        }
                      });
                    }
                  } else if (state
                      is ReservationConfirmReservationFailureState) {
                    Navigator.pop(context);
                    _stopScan = false;
                  }
                },
                child: RepaintBoundary(
                  child: MobileScanner(
                    scanWindow: Rect.fromCenter(
                      center: Offset(
                        MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.height / 2,
                      ),
                      width: 300,
                      height: 300,
                    ),
                    controller: _cameraController,
                    errorBuilder: (context, exception, child) {
                      _cameraController.stop().then(
                            (value) => _cameraController.start(),
                          );
                      return Center(
                        child: DefaultAppText(
                          text: "Error: ${exception.errorDetails?.message}",
                          color: AppColors.red,
                        ),
                      );
                    },
                    onDetect: (barcodes) async {
                      if (barcodes.barcodes.isNotEmpty && !_stopScan) {
                        _stopScan = true;
                        final val = barcodes.barcodes.first.rawValue;
                        logSuccess("QrCodeText: $val");
                        if (myLocation == null) {
                          "Unknown location, enable you location and scan again."
                              .toToastError();
                          try {
                            myLocation = await Geolocator.getCurrentPosition();
                          } catch (e) {
                            e.toString().toToastError();
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                          final request = ReservationConfirmationRequest(
                            payment: widget.reservationArguments.payment!,
                            price: widget.reservationArguments.price!,
                            medicineTypeId: num.parse(val!),
                            reservationId: widget
                                .reservationArguments.myReservationModel?.id,
                            latitude: myLocation!.latitude,
                            longitude: myLocation!.longitude,
                            serviceId: widget.reservationArguments.serviceId,
                            useRewardPoint:
                                widget.reservationArguments.useRewardPoint,
                            coupon: widget.reservationArguments.coupon,
                          );
                          ReservationCubit.get(context).confirmReservation(
                            request: request,
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: ShapeDecoration(
                  shape: QrCodeScannerOverlayShape(
                    overlayColor: AppColors.background2.withOpacity(0.7),
                    borderColor: AppColors.defaultBlack,
                    borderRadius: 8,
                    borderLength: 20,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              ),
            ),
            Positioned(
              top: context.responsiveHeight(16.5),
              right: context.responsiveWidth(16.5),
              height: context.responsiveHeight(44),
              width: context.responsiveWidth(44),
              child: Material(
                color: AppColors.defaultWhite,
                type: MaterialType.circle,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: _cameraController.toggleTorch,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveWidth(10),
                      vertical: context.responsiveHeight(10),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: _cameraController.hasTorchState,
                      builder: (context, flashOn, child) {
                        return Icon(
                          flashOn == true ? Icons.flash_on : Icons.flash_off,
                          color: AppColors.primary,
                        );
                      },
                    ),
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
