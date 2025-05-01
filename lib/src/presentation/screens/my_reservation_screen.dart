import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/reservation_cubit/reservation_cubit.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/router/reservation_argumentd.dart';

import '../../constants/colors.dart';
import '../widgets/notification_item.dart';

class MyReservationScreen extends StatefulWidget {
  const MyReservationScreen({Key? key}) : super(key: key);

  @override
  State<MyReservationScreen> createState() => _MyReservationScreenState();
}

class _MyReservationScreenState extends State<MyReservationScreen> {
  @override
  void initState() {
    super.initState();
    ReservationCubit.get(context).getMyReservation();
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
      backgroundColor: AppColors.greenTransparent,
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
          context.myReservation,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultWhite,
            fontWeight: FontWeight.w500,
            fontFamily: "Alexandria",
          ),
        ),
      ),
      body: BlocBuilder<ReservationCubit, ReservationState>(
        builder: (context, state) {
          final reservations = ReservationCubit.get(context).myReservations;
          return state is ReservationGetMyReservationLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 20),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRouterNames.rBookingDiscount,
                        arguments: ReservationArguments(
                          myReservationModel: reservations[index],
                          medicineTypeModel:
                              reservations[index].medicineTypeModel!,
                          type: "oneReservation",
                          status: reservations[index].status ?? "",
                        ),
                      );
                    },
                    child: NotificationItem(
                      icon: reservations[index].status == "waiting"
                          ? Icons.access_time
                          : reservations[index].status == "cancel"
                              ? Icons.close
                              : Icons.check,
                      iconColor: reservations[index].status == "waiting"
                          ? AppColors.orange
                          : reservations[index].status == "cancel"
                              ? AppColors.red
                              : AppColors.green22,
                      titleBackground: reservations[index].status == "waiting"
                          ? AppColors.yellowTransparent
                          : reservations[index].status == "cancel"
                              ? AppColors.redTransparent
                              : AppColors.green20,
                      iconBackground: reservations[index].status == "waiting"
                          ? AppColors.yellowTransparent
                          : reservations[index].status == "cancel"
                              ? AppColors.redTransparent
                              : AppColors.greenTransparent,
                      title: reservations[index].status == "waiting"
                          ? 'قيد الانتظار'
                          : reservations[index].status == "cancel"
                              ? 'تم إلغاء'
                              : 'تم بنجاح',
                      name: reservations[index].medicineTypeModel!.name ?? "",
                      date: "${reservations[index].date ?? ""}"
                          "   -   "
                          "${reservations[index].time.toString().substring(0, 5)}",
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemCount: reservations.length,
                );
        },
      ),
    );
  }
}
