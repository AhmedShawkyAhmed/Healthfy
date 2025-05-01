part of 'medicine_type_category_response.dart';

class MedicineTypeCategoriesResponseData {
  List<CategoryModel>? types;

  MedicineTypeCategoriesResponseData({this.types});

  MedicineTypeCategoriesResponseData.fromJson(Map<String, dynamic> json) {
    types = json["types"] != null
        ? List<CategoryModel>.from(
        json["types"].map((x) => CategoryModel.fromJson(x)))
        : json["types"];
  }

  Map<String, dynamic> toJson() => {
    'types':List<dynamic>.from(types!.map((x) => x.toJson())),
  };
}