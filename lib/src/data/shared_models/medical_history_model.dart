import 'package:healthify/src/data/shared_models/medial_model.dart';
import 'package:healthify/src/data/shared_models/medicine_type_model.dart';
import 'package:healthify/src/data/shared_models/user_model.dart';

class MedicalHistoryModel {
  int? id;
  int? medicineTypeId;
  MedicineTypeModel? medicineType;
  int? userId;
  UserModel? user;
  String? name;
  List<MediaModel>? medias;
  String? date;
  MedicalHistoryModel({
    this.id,
    this.medicineTypeId,
    this.medicineType,
    this.userId,
    this.user,
    this.name,
    this.medias,
    this.date,
  });

  MedicalHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicineTypeId = json['medicine_type_id'];
    medicineType = json['medicine_type'] != null
        ? MedicineTypeModel.fromJson(json['medicine_type'])
        : null;
    userId = json['user_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    name = json['name'];
    date = json['date'];
    if (json['Medias'] != null) {
      medias = <MediaModel>[];
      json['Medias'].forEach((v) {
        medias!.add(MediaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medicine_type_id'] = medicineTypeId;
    if (medicineType != null) {
      data['medicine_type'] = medicineType!.toJson();
    }
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['name'] = name;
    if (medias != null) {
      data['Medias'] = medias!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
