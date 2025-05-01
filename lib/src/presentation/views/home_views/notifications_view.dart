import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:healthify/src/presentation/widgets/notification_item.dart';
import 'package:sizer/sizer.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    NotificationCubit.get(context).getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenTransparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          context.notifications,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          final notifications = NotificationCubit.get(context).notifications;
          return state is GetAllNotificationInitial
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : notifications.isEmpty
                  ? Center(
                      child: DefaultAppText(
                        text: "لا يوجد إشعارات",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(top: 20),
                      itemBuilder: (context, index) => NotificationItem(
                        icon: Icons.notifications,
                        iconColor: AppColors.green22,
                        titleBackground: AppColors.green20,
                        iconBackground: AppColors.greenTransparent,
                        title: notifications[index].title ?? "",
                        name: notifications[index].massage ?? "",
                        date: notifications[index].createdAtStr ?? "",
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemCount: notifications.length,
                    );
        },
      ),
    );
  }
}
