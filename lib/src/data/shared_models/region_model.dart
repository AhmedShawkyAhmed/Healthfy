class RegionModel {
  num? id;
  num? cityId;
  String? regions;
  String? appKey;
  String? createdAt;
  String? updatedAt;

  RegionModel(
      {this.id,
      this.cityId,
      this.regions,
      this.appKey,
      this.createdAt,
      this.updatedAt});

  RegionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    regions = json['regions'];
    appKey = json['appKey'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_id'] = cityId;
    data['regions'] = regions;
    data['appKey'] = appKey;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
