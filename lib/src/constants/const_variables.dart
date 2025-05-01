import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reve_chat_sdk/reve_chat_sdk.dart';

import '../data/shared_models/home_grid_model.dart';
import '../presentation/views/home_views/account_view.dart';
import '../presentation/views/home_views/discount_view.dart';
import '../presentation/views/home_views/home_view.dart';
import '../presentation/views/home_views/notifications_view.dart';
import 'assets.dart';

late String? fcmToken;
Position? myLocation;
final imagePicker = ImagePicker();
final reveChat = ReveChatSdk();

const List<String> sliderImages = [
  AppAssets.slider1,
  AppAssets.slider2,
  AppAssets.slider3,
];
const List<Widget> homeViews = [
  HomeView(),
  DiscountView(),
  NotificationView(),
  AccountView(),
];
List<GridModel> homeList = [
  GridModel(
      image: AppAssets.healthcare,
      title: 'خدمات بالتقسيط',
      color: const Color.fromRGBO(56, 197, 88, 0.35)),
  GridModel(
      image: AppAssets.icMedicalRecord,
      title: 'السجل الطبي',
      color: const Color.fromRGBO(56, 197, 88, 0.35)),
  GridModel(
      image: AppAssets.icPharmacy2,
      title: 'صيدلية\nصحتك تهمنا',
      color: const Color.fromRGBO(56, 197, 88, 0.35)),
  GridModel(
    image: AppAssets.icAskDoctor,
    title: 'اسأل دكتور',
    color: const Color.fromRGBO(251, 235, 128, 1),
  ),
  GridModel(
      image: AppAssets.ambulance,
      title: 'الإسعاف',
      color: const Color.fromRGBO(56, 197, 88, 0.35)),
  GridModel(
    image: AppAssets.icHomeNursing,
    title: 'التمريض المنزلي',
    color: const Color.fromRGBO(254, 160, 58, 0.35),
  ),
  GridModel(
    image: AppAssets.houseCare,
    title: 'الرعاية المنزلية',
    color: const Color.fromRGBO(251, 235, 128, 1),
  ),
];
// List<GridModel> gridList = [
//   GridModel(
//       image: AppAssets.icClinics,
//       title: 'عيادات',
//       color: const Color.fromRGBO(56, 197, 88, 0.35)),
//   GridModel(
//     image: AppAssets.icHospital,
//     title: 'مستشفيات',
//     color: const Color.fromRGBO(251, 235, 128, 1),
//   ),
//   GridModel(
//     image: AppAssets.icClinics,
//     title: 'عيادات',
//     color: const Color.fromRGBO(254, 160, 58, 0.35),
//   ),
//   GridModel(
//       image: AppAssets.icClinics,
//       title: 'عيادات',
//       color: const Color.fromRGBO(56, 197, 88, 0.35)),
//   GridModel(
//     image: AppAssets.icHospital,
//     title: 'مستشفيات',
//     color: const Color.fromRGBO(251, 235, 128, 1),
//   ),
//   GridModel(
//     image: AppAssets.icClinics,
//     title: 'عيادات',
//     color: const Color.fromRGBO(254, 160, 58, 0.35),
//   ),
//   GridModel(
//       image: AppAssets.icClinics,
//       title: 'عيادات',
//       color: const Color.fromRGBO(56, 197, 88, 0.35)),
//   GridModel(
//     image: AppAssets.icHospital,
//     title: 'مستشفيات',
//     color: const Color.fromRGBO(251, 235, 128, 1),
//   ),
//   GridModel(
//     image: AppAssets.icClinics,
//     title: 'عيادات',
//     color: const Color.fromRGBO(254, 160, 58, 0.35),
//   ),
// ];
// List<String> specializations = [
//   'اسنان',
//   'عظام',
//   'عيون',
//   'جلدية',
//   'مخ و اعصاب',
//   'اطفال و حديثي الولادة',
//   'انف و اذن وحنجرة',
//   'باطنة',
//   'قلب و اوعية دموية',
//   'مسالك بولية',
//   'علاج طبيعي'
// ];

String specialization = '';
String governorate = '';
String city = '';
