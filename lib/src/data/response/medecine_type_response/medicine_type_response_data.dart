part of 'medicine_type_response.dart';

class MedicineTypeResponseData {
  List<MedicineTypeModel>? medicineType;
  List<MedicineTypeDoctorsModel>? doctors;

  MedicineTypeResponseData({this.medicineType, this.doctors});

  MedicineTypeResponseData.fromJson(Map<String, dynamic> json) {
    medicineType = json['MedicineType'] != null
        ? (json['MedicineType'] as List)
            .map(
              (e) => MedicineTypeModel.fromJson(
                e,
              ),
            )
            .toList()
        : null;
    doctors = json['Doctors'] != null
        ? (json['Doctors'] as List)
            .map(
              (e) => MedicineTypeDoctorsModel.fromJson(
                e,
              ),
            )
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MedicineType'] = medicineType?.map((v) => v.toJson()).toList();
    data['Doctors'] = doctors?.map((v) => v.toJson()).toList();
    return data;
  }
}
