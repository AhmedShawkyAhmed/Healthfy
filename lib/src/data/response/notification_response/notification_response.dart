import 'package:healthify/src/data/shared_models/notification_model.dart';

part 'notification_response_data.dart';

class NotificationResponse {
  String? message;
  NotificationResponseData? data;

  NotificationResponse({this.message, this.data});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? NotificationResponseData.fromJson(json['data'])
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
