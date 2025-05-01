part of 'medical_history_response.dart';

class MedicalHistoryResponseData {
  List<MedicalHistoryModel>? medicalHistory;

  MedicalHistoryResponseData({this.medicalHistory});

  MedicalHistoryResponseData.fromJson(Map<String, dynamic> json) {
    if (json['medicalHistory'] != null) {
      medicalHistory = <MedicalHistoryModel>[];
      json['medicalHistory'].forEach((v) {
        medicalHistory!.add(MedicalHistoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medicalHistory != null) {
      data['medicalHistory'] = medicalHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
