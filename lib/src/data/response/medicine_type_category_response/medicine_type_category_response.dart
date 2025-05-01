import 'package:healthify/src/data/models/category_model.dart';

part 'medicine_type_category_response_data.dart';

class MedicineTypeCategoriesResponse {
  String? message;
  MedicineTypeCategoriesResponseData? data;

  MedicineTypeCategoriesResponse({this.message, this.data});

  MedicineTypeCategoriesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? MedicineTypeCategoriesResponseData.fromJson(json['data'])
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
