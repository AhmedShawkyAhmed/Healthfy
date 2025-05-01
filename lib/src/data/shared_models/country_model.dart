class CountryModel {
  num? id;
  String? country;
  String? appKey;
  String? dialCode;
  String? code;
  num? continents;
  String? createdAt;
  String? updatedAt;

  CountryModel(
      {this.id,
      this.country,
      this.appKey,
      this.dialCode,
      this.code,
      this.continents,
      this.createdAt,
      this.updatedAt});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    appKey = json['appKey'];
    dialCode = json['dial_code'];
    code = json['code'];
    continents = json['continents'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country'] = country;
    data['appKey'] = appKey;
    data['dial_code'] = dialCode;
    data['code'] = code;
    data['continents'] = continents;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
