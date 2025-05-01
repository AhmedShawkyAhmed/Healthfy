import 'dart:io';
import 'dart:ui';
import 'dart:developer' as dev;

import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_variables.dart';
import 'package:healthify/src/constants/enums.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/services/notification_service.dart';

import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void logError(String msg) => debugPrint(
      '\x1B[31m$msg\x1B[0m',
    );

void logSuccess(String msg) => debugPrint(
      '\x1B[32m$msg\x1B[0m',
    );

void logWarning(String msg) => debugPrint(
      '\x1B[33m$msg\x1B[0m',
    );

extension StringExtension on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  Future<void> toToastError() async {
    try {
      final message = isEmpty ? "error" : this;

      await Fluttertoast.cancel();

      showToast(message, ToastState.error);
    } catch (e) {
      logError("toToastError error $e");
    }
  }

  Future<void> toToastSuccess() async {
    try {
      final message = isEmpty ? "success" : this;

      await Fluttertoast.cancel();

      showToast(message, ToastState.success);
    } catch (e) {
      logError("toToastSuccess error: $e");
    }
  }

  Future<void> toToastWarning() async {
    try {
      final message = isEmpty ? "warning" : this;

      await Fluttertoast.cancel();

      showToast(message, ToastState.warning);
    } catch (e) {
      logError("toToastWarning error: $e");
    }
  }
}

showToast(String text, ToastState state) async {
  await Fluttertoast.cancel();
  final backgroundColor = state == ToastState.success
      ? AppColors.green
      : state == ToastState.error
          ? AppColors.defaultRed
          : AppColors.defaultYellow;
  final textColor = state == ToastState.success
      ? AppColors.defaultWhite
      : state == ToastState.error
          ? AppColors.defaultWhite
          : AppColors.defaultBlack;
  Fluttertoast.showToast(
    msg: text,
    timeInSecForIosWeb: 1,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    fontSize: 16,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}

final _imagePicker = ImagePicker();

Future pickImage({
  required ImageSource source,
  required Function(XFile image) onImageSelect,
}) async {
  XFile? image = await _imagePicker.pickImage(
    source: source,
    maxHeight: 1024,
    maxWidth: 1024,
    imageQuality: 50,
  );
  if (image != null) {
    logSuccess("PickedImage: ${image.path}");
    onImageSelect(image);
  }
}

Future pickFile({
  required Function(PlatformFile file) onFileSelect,
}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc'],
  );

  if (result != null) {
    PlatformFile file = PlatformFile(
        path: result.files.single.path!,
        name: result.files.single.name,
        size: result.files.single.size);
    onFileSelect(file);
    debugPrint(file.path);
  } else {
    // User canceled the picker
  }
}

Future<List?> getCurrentPosition({bool force = false}) async {
  LocationPermission isPermitted = await Geolocator.checkPermission();
  if (isPermitted != LocationPermission.always &&
      isPermitted != LocationPermission.whileInUse) {
    isPermitted = await Geolocator.requestPermission();
  }
  if (isPermitted == LocationPermission.always ||
      isPermitted == LocationPermission.whileInUse) {
    final position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    return [position, placemarks[0]];
  }
  if (force) {
    final position = await Geolocator.getLastKnownPosition(
      forceAndroidLocationManager: true,
    );
    List<Placemark>? placemarks = position != null
        ? await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          )
        : null;

    return [position, placemarks?[0]];
  }
  return null;
}

Future<void> backgroundMessages(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await NotificationService.initialize();
  NotificationService.showNotification(
    id: message.hashCode,
    title: message.notification?.title ?? "Title",
    body: message.notification?.body ?? "Body",
  );
}

Map<PaymentMethod, String> getPaymentMethods(BuildContext context) => {
      // PaymentMethod.visa: context.visa,
      PaymentMethod.cash: context.cash,
      // PaymentMethod.e_Wallet: context.eWallets,
    };

shareApp() {
  //TODO
  late String message;
  if (Platform.isAndroid) {
    message =
        'https://play.google.com/store/apps/details?id=com.sihatukTuhumuna.sihatukTuhumuna';
  } else {
    message = '';
  }
  Share.shareUri(Uri.parse(message));
}

void navigateTo(double lat, double lng) async {
  try {
    var uri = Uri.parse(
      Platform.isAndroid
          ? "google.navigation:q=$lat,$lng&mode=d"
          : "https://maps.apple.com/?daddr=$lat,$lng&dirflg=d",
    );
    if ((await canLaunchUrl(uri))) {
      await launchUrl(uri);
    } else {
      "حدث خطأ في الدخول علي الموقع".toToastError();
    }
  } catch (e) {
    dev.log(
      'Could not launch error => $e',
      name: "GoogleMapUrlLaunchError",
    );
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  myLocation = await Geolocator.getCurrentPosition();
  logSuccess("Location ${await Geolocator.getCurrentPosition()}");
  return await Geolocator.getCurrentPosition();
}
