class LocalCityModel {
  String? name;
  List<City>? data;

  LocalCityModel({this.name, this.data});

  LocalCityModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['data'] != null) {
      data = <City>[];
      json['data'].forEach((v) {
        data!.add(City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  String? id;
  String? governorateId;
  String? cityNameAr;
  String? cityNameEn;

  City({this.id, this.governorateId, this.cityNameAr, this.cityNameEn});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorateId = json['governorate_id'];
    cityNameAr = json['city_name_ar'];
    cityNameEn = json['city_name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['governorate_id'] = governorateId;
    data['city_name_ar'] = cityNameAr;
    data['city_name_en'] = cityNameEn;
    return data;
  }
}
