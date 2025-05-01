part of 'single_notification_response.dart';

class SingleNotificationResponseData {
  NotificationModel? massages;

  SingleNotificationResponseData({this.massages});

  SingleNotificationResponseData.fromJson(Map<String, dynamic> json) {
    massages = json['massages'] != null
        ? NotificationModel.fromJson(json['massages'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (massages != null) {
      data['massages'] = massages!.toJson();
    }
    return data;
  }
}
