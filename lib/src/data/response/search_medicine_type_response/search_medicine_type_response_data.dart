part of 'search_medicine_type_response.dart';

class SearchMedicineTypeResponseData {
  int? pages;
  List<MedicineTypeModel>? media;

  SearchMedicineTypeResponseData({this.pages, this.media});

  SearchMedicineTypeResponseData.fromJson(Map<String, dynamic> json) {
    pages = json['pages'];
    if (json['media'] != null) {
      media = <MedicineTypeModel>[];
      json['media'].forEach((v) {
        media!.add(MedicineTypeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pages'] = pages;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
