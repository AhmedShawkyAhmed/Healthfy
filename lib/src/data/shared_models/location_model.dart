import 'location_address_model.dart';

class LocationModel {
  LocationModel({
    this.id,
    this.createdAt,
    this.createdAtStr,
    this.type,
    this.longitude,
    this.latitude,
    this.address,
    this.address1,
  });

  LocationModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    createdAtStr = json['created_at_str'];
    type = json['type'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
    address1 = json['address1'] != null
        ? LocationAddressModel.fromJson(json['address1'])
        : null;
  }

  num? id;
  num? createdAt;
  String? createdAtStr;
  String? type;
  num? longitude;
  num? latitude;
  String? address;
  LocationAddressModel? address1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['created_at_str'] = createdAtStr;
    map['type'] = type;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['address'] = address;
    if (address1 != null) {
      map['address1'] = address1?.toJson();
    }
    return map;
  }
}
