import 'package:healthify/src/data/shared_models/notification_model.dart';

part 'single_notication_response_data.dart';

class SingleNotificationResponse {
  String? message;
  SingleNotificationResponseData? data;

  SingleNotificationResponse({this.message, this.data});

  SingleNotificationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? SingleNotificationResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
