part of 'get_all_location_response.dart';

class GetAllLocationResponseData {
  GetAllLocationResponseData({
    this.locations,
  });

  GetAllLocationResponseData.fromJson(dynamic json) {
    if (json['locations'] != null) {
      locations = [];
      json['locations'].forEach((v) {
        locations?.add(LocationModel.fromJson(v));
      });
    }
  }

  List<LocationModel>? locations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (locations != null) {
      map['locations'] = locations?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
