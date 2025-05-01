class LocationAddressModel {
  LocationAddressModel({
    required this.city,
    required this.region,
    required this.building,
    required this.floor,
    required this.flat,
    this.addition,
  });

  LocationAddressModel.fromJson(dynamic json) {
    city = json['city'];
    region = json['Region'];
    building = json['building'];
    floor = json['Floor'];
    flat = json['Flat'];
    addition = json['addition'];
  }

  String? city;
  String? region;
  String? building;
  String? floor;
  String? flat;
  String? addition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = city;
    map['Region'] = region;
    map['building'] = building;
    map['Floor'] = floor;
    map['Flat'] = flat;
    map['addition'] = addition;
    return map;
  }
}
