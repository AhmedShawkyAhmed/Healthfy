import 'package:healthify/src/data/shared_models/medicine_type_model.dart';

part 'search_medicine_type_response_data.dart';

class SearchMedicineTypeResponse {
  String? message;
  SearchMedicineTypeResponseData? data;

  SearchMedicineTypeResponse({this.message, this.data});

  SearchMedicineTypeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? SearchMedicineTypeResponseData.fromJson(json['data'])
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
