part of 'cities_response.dart';

class CitiesResponseData {
  List<CityModel>? cities;

  CitiesResponseData({this.cities});

  CitiesResponseData.fromJson(Map<String, dynamic> json) {
    if (json['Regions'] != null) {
      cities = <CityModel>[];
      json['Regions'].forEach((v) {
        cities!.add(CityModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cities != null) {
      data['Regions'] = cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
