import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/reservation_cubit/reservation_cubit.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/history_arguments.dart';
import '../../constants/colors.dart';
import '../router/app_router_names.dart';
import '../widgets/notification_item.dart';

class EndedReservationScreen extends StatefulWidget {
  const EndedReservationScreen({Key? key}) : super(key: key);

  @override
  State<EndedReservationScreen> createState() => _EndedReservationScreenState();
}

class _EndedReservationScreenState extends State<EndedReservationScreen> {
  @override
  void initState() {
    super.initState();
    ReservationCubit.get(context).getEndedMyReservation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenTransparent,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.defaultBlack,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.defaultWhite,
        centerTitle: true,
        title: Text(
          context.myReservation,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultBlack,
            fontWeight: FontWeight.w500,
            fontFamily: "Alexandria",
          ),
        ),
      ),
      body: BlocBuilder<ReservationCubit, ReservationState>(
        builder: (context, state) {
          final reservations =
              ReservationCubit.get(context).myEndedReservations;
          return ListView.separated(
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouterNames.rXRayDetails,
                  arguments: HistoryArguments(
                    type: "create",
                    myReservationModel: reservations[index],
                  ),
                );
              },
              child: NotificationItem(
                icon: Icons.check,
                iconColor: AppColors.green22,
                titleBackground: AppColors.bGrey,
                iconBackground: AppColors.greenTransparent,
                title: 'حجز مكتمل',
                name: reservations[index].medicineTypeModel!.name ?? "",
                date: "${reservations[index].date ?? ""}"
                    "   -   "
                    "${reservations[index].time.toString().substring(0, 5)}",
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: reservations.length,
          );
        },
      ),
    );
  }
}
