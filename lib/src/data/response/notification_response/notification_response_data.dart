part of 'notification_response.dart';

class NotificationResponseData {
  List<NotificationModel>? massages;

  NotificationResponseData({this.massages});

  NotificationResponseData.fromJson(Map<String, dynamic> json) {
    if (json['massages'] != null) {
      massages = <NotificationModel>[];
      json['massages'].forEach((v) {
        massages!.add(NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (massages != null) {
      data['massages'] = massages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}