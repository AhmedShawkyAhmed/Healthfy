import 'package:healthify/src/data/shared_models/points_model.dart';

part 'points_response_data.dart';

class PointsResponse {
  String? message;
  PointsResponseData? data;

  PointsResponse({this.message, this.data});

  PointsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data =
        json['data'] != null ? PointsResponseData.fromJson(json['data']) : null;
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
