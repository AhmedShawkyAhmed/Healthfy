import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:healthify/src/business_logic/location_cubit/location_cubit.dart';
import 'package:healthify/src/business_logic/medicine_type_cubit/medicine_type_cubit.dart';
import 'package:healthify/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:healthify/src/business_logic/package_cubit/package_cubit.dart';
import 'package:healthify/src/business_logic/points_cubit/points_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/services/notification_service.dart';

import '../../../business_logic/home_cubit/home_cubit.dart';
import '../../../constants/const_variables.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    if (AuthCubit.get(context).user == null) {
      AuthCubit.get(context).getProfile();
    }
    PackageCubit.get(context).getMyHealthPackage();
    if (MedicineTypeCubit.get(context).medicineTypeCategories.isEmpty) {
      MedicineTypeCubit.get(context).getMedicineTypeCategories();
    }
    if (LocationCubit.get(context).locations.isEmpty) {
      LocationCubit.get(context).getAllLocations();
    }
    if (PointsCubit.get(context).pointsModel == null) {
      PointsCubit.get(context).getPoints();
    }
    FirebaseMessaging.instance.getToken().then((value) {
      if (value != null) {
        NotificationCubit.get(context).updateFCM(value);
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      NotificationService.showNotification(
        id: message.hashCode,
        title: message.notification?.title ?? "Title",
        body: message.notification?.body ?? "Body",
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      NotificationService.showNotification(
        id: message.hashCode,
        title: message.notification?.title ?? "Title",
        body: message.notification?.body ?? "Body",
      );
    });
    FirebaseMessaging.onBackgroundMessage(backgroundMessages);
    HomeCubit.get(context).getAds();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
          ),
          backgroundColor: AppColors.primaryOpacity,
          body: homeViews[BlocProvider.of<HomeCubit>(context).bottomIndex],
          bottomNavigationBar: BottomNavigationBar(
              elevation: 10,
              backgroundColor: Colors.white,
              onTap: BlocProvider.of<HomeCubit>(context).changeBottomIndex,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              currentIndex: BlocProvider.of<HomeCubit>(context).bottomIndex,
              selectedLabelStyle: const TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.bold),
              showSelectedLabels: true,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.grey3,
              unselectedLabelStyle: const TextStyle(
                  color: AppColors.grey3, fontWeight: FontWeight.bold),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'الرئيسية'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.local_offer_outlined), label: 'الخصومات'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications), label: 'الاشعارات'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'الحساب'),
              ]),
        );
      },
    );
  }
}
