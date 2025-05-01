import 'package:healthify/src/data/shared_models/medical_history_model.dart';

part 'medical_history_response_data.dart';

class MedicalHistoryResponse {
  String? message;
  MedicalHistoryResponseData? data;

  MedicalHistoryResponse({this.message, this.data});

  MedicalHistoryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? MedicalHistoryResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
