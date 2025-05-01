import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/cache_keys.dart';
import 'package:healthify/src/services/cache_helper.dart';
import 'package:healthify/src/services/network_checker_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  late ThemeMode _themeMode;

  Locale _locale = const Locale('ar');

  Locale get locale => _locale;

  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeMode get themeMode => _themeMode;

  startNetworkStream() {
    NetworkCheckerHelper.streamNetworkState().listen((event) {
      if (event == InternetConnectionStatus.connected) {
        emit(AppInternetConnectedState());
      } else {
        emit(AppInternetDisconnectedState());
      }
    });
  }

  initAppCubit() {
    _initLocale();
    _initDarkTheme();
  }

  Future _initLocale() async {
    final lang = CacheHelper.getDataFromSharedPreference(
          key: CacheKeys.ckAppLang,
        ) ??
        'ar';
    _locale = Locale(lang);
    log(_locale.languageCode);
    emit(AppLanguageUpdateState());
  }

  Future changeAppLanguage(Locale locale) async {
    _locale = locale;
    CacheHelper.saveDataSharedPreference(
      key: CacheKeys.ckAppLang,
      value: _locale.languageCode,
    );
    emit(AppLanguageUpdateState());
  }

  Future _initDarkTheme() async {
    final isDarkTheme = CacheHelper.getDataFromSharedPreference(
          key: CacheKeys.ckIsDarkTheme,
        ) ??
        false;
    _themeMode = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    await CacheHelper.saveDataSharedPreference(
      key: CacheKeys.ckIsDarkTheme,
      value: isDarkTheme,
    );
    _isDark = _themeMode == ThemeMode.dark;
    emit(AppThemeUpdateState());
  }

  Future toggleTheme() async {
    _themeMode = _isDark ? ThemeMode.light : ThemeMode.dark;
    await CacheHelper.saveDataSharedPreference(
      key: CacheKeys.ckIsDarkTheme,
      value: _themeMode == ThemeMode.dark,
    );
    _isDark = _themeMode == ThemeMode.dark;
    emit(AppThemeUpdateState());
  }
}
