class CityModel {
  num? id;
  num? countryId;
  String? city;
  String? appKey;
  String? createdAt;
  String? updatedAt;

  CityModel(
      {this.id,
      this.countryId,
      this.city,
      this.appKey,
      this.createdAt,
      this.updatedAt});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    city = json['city'];
    appKey = json['appKey'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['city'] = city;
    data['appKey'] = appKey;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
