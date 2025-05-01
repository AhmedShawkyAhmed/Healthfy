import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healthify/src/business_logic/Favourite_cubit/favourite_cubit.dart';
import 'package:healthify/src/business_logic/app_cubit/app_cubit.dart';
import 'package:healthify/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:healthify/src/business_logic/bloc_observer.dart';
import 'package:healthify/src/business_logic/home_cubit/home_cubit.dart';
import 'package:healthify/src/business_logic/location_cubit/location_cubit.dart';
import 'package:healthify/src/business_logic/medical_history_cubit/medical_history_cubit.dart';
import 'package:healthify/src/business_logic/medicine_type_cubit/medicine_type_cubit.dart';
import 'package:healthify/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:healthify/src/business_logic/package_cubit/package_cubit.dart';
import 'package:healthify/src/business_logic/points_cubit/points_cubit.dart';
import 'package:healthify/src/business_logic/rate_cubit/rate_cubit.dart';
import 'package:healthify/src/business_logic/reservation_cubit/reservation_cubit.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/const_variables.dart';
import 'package:healthify/src/constants/themes.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router.dart';
import 'package:healthify/src/services/cache_helper.dart';
import 'package:healthify/src/services/dio_helper.dart';
import 'package:healthify/src/services/network_checker_helper.dart';
import 'package:healthify/src/services/notification_service.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark));
      Bloc.observer = MyBlocObserver();
      await NotificationService.initialize();
      await CacheHelper.init();
      NetworkCheckerHelper.init();
      DioHelper.init();
      await Firebase.initializeApp();
      determinePosition();
      fcmToken = await FirebaseMessaging.instance.getToken();
      await reveChat.initReveChat("6431897");
      if (Platform.isAndroid) {
        await reveChat.setReveChatDeviceToken(
          (await FirebaseMessaging.instance.getToken()) ?? "DeviceToken",
        );
      }
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      runApp(const MyApp());
    },
    (error, stackTrace) async {
      logError("Global Error: $error");
      logError("Global StackTrace: $stackTrace");
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..initAppCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(FirebaseAuth.instance),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => PackageCubit(),
        ),
        BlocProvider(
          create: (context) => MedicineTypeCubit(),
        ),
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
        BlocProvider(
          create: (context) => ReservationCubit()..getWaitingMyReservation(),
        ),
        // BlocProvider(
        //   create: (context) => AppContentCubit(),
        // ),
        BlocProvider(
          create: (context) => NotificationCubit(),
        ),
        BlocProvider(
          create: (context) => PointsCubit(),
        ),
        BlocProvider(
          create: (context) => FavouriteCubit(),
        ),
        BlocProvider(
          create: (context) => RateCubit(),
        ),
        BlocProvider(
          create: (context) => MedicalHistoryCubit(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          return Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'صحتك تهمنا',
              onGenerateTitle: (context) => context.healthify,
              onGenerateRoute: AppRouter.onGenerateRoutes,
              themeMode: cubit.themeMode,
              theme: LightTheme.lightTheme,
              darkTheme: DarkTheme.darkTheme,
              locale: const Locale('ar'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
            );
          });
        },
      ),
    );
  }
}
