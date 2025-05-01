import 'package:healthify/src/data/shared_models/medicine_type_model.dart';

class MedicineTypeDoctorsModel {
  final String? doctorName;
  final String? doctorImage;
  final String? doctorSpeciality;
  final MedicineTypeModel? medicineType;

  const MedicineTypeDoctorsModel({
    this.doctorName,
    this.doctorImage,
    this.doctorSpeciality,
    this.medicineType,
  });

  Map<String, dynamic> toJson() => {
        'name': doctorName,
        'image': doctorImage,
        'speciality': doctorSpeciality,
        'medicine_types': medicineType,
      };

  factory MedicineTypeDoctorsModel.fromJson(Map<String, dynamic> json) {
    return MedicineTypeDoctorsModel(
      doctorName: json['name'],
      doctorImage: json['image'],
      doctorSpeciality: json['speciality'],
      medicineType: json['medicine_types'] != null
          ? MedicineTypeModel.fromJson(json['medicine_types'])
          : null,
    );
  }
}
