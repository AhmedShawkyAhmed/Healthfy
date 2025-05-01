part of 'regions_response.dart';

class RegionsResponseData {
  List<RegionModel>? regions;

  RegionsResponseData({this.regions});

  RegionsResponseData.fromJson(Map<String, dynamic> json) {
    if (json['Regions'] != null) {
      regions = <RegionModel>[];
      json['Regions'].forEach((v) {
        regions!.add(RegionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (regions != null) {
      data['Regions'] = regions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
