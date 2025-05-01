part of 'points_response.dart';

class PointsResponseData {
  PointsModel? points;

  PointsResponseData({this.points});

  PointsResponseData.fromJson(Map<String, dynamic> json) {
    points = json['Points'] != null ? PointsModel.fromJson(json['Points']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (points != null) {
      data['Points'] = points!.toJson();
    }
    return data;
  }
}
