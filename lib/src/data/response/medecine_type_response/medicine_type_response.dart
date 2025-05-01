import 'package:healthify/src/data/models/medicine_type_doctors_model.dart';
import 'package:healthify/src/data/shared_models/medicine_type_model.dart';

part 'medicine_type_response_data.dart';

class MedicineTypeResponse {
  String? message;
  MedicineTypeResponseData? data;

  MedicineTypeResponse({this.message, this.data});

  MedicineTypeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? MedicineTypeResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = this.data?.toJson();
    return data;
  }
}
