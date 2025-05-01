import 'package:healthify/src/data/shared_models/medicine_type_model.dart';

class FavouriteModel {
  FavouriteModel({
    this.id,
    this.createdAt,
    this.createdAtStr,
    this.favableId,
    this.favableType,
    this.favMedicineType,
  });

  FavouriteModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    createdAtStr = json['created_at_str'];
    favableId = json['favable_id'];
    favableType = json['favable_type'];
    favMedicineType = json['favMedicineType'] != null
        ? MedicineTypeModel.fromJson(json['favMedicineType'])
        : null;
  }

  num? id;
  num? createdAt;
  String? createdAtStr;
  num? favableId;
  String? favableType;
  MedicineTypeModel? favMedicineType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['created_at_str'] = createdAtStr;
    map['favable_id'] = favableId;
    map['favable_type'] = favableType;
    if (favMedicineType != null) {
      map['favMedicineType'] = favMedicineType?.toJson();
    }
    return map;
  }
}
