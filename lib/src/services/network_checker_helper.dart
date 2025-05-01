import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkCheckerHelper {
  static late final InternetConnectionChecker networkChecker;

  static init() {
    networkChecker = InternetConnectionChecker();
  }

  static Future<bool> isNetworkConnected() async =>
      await networkChecker.hasConnection;

  static Stream<InternetConnectionStatus> streamNetworkState() =>
      networkChecker.onStatusChange;
}
