class GovernorateModel {
  String? name;
  List<Governorate>? data;

  GovernorateModel({this.name, this.data});

  GovernorateModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['data'] != null) {
      data = <Governorate>[];
      json['data'].forEach((v) {
        data!.add(Governorate.fromJson(v));
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

class Governorate {
  String? id;
  String? governorateNameAr;
  String? governorateNameEn;

  Governorate({this.id, this.governorateNameAr, this.governorateNameEn});

  Governorate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorateNameAr = json['governorate_name_ar'];
    governorateNameEn = json['governorate_name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['governorate_name_ar'] = governorateNameAr;
    data['governorate_name_en'] = governorateNameEn;
    return data;
  }
}
