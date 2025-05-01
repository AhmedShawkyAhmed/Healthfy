part of 'specialisties_response.dart';

class SpecialistiesResponseData {
  List<SpecialtyModel>? mostChosenSpecialties;
  List<SpecialtyModel>? otherSpecialties;

  SpecialistiesResponseData({
    required this.mostChosenSpecialties,
    required this.otherSpecialties,
  });

  SpecialistiesResponseData.fromJson(Map<String, dynamic> json) {
    if (json['Most Chosen'] != null) {
      mostChosenSpecialties = <SpecialtyModel>[];
      json['Most Chosen'].forEach((v) {
        mostChosenSpecialties!.add(SpecialtyModel.fromJson(v));
      });
    }
    if (json['Other'] != null) {
      otherSpecialties = <SpecialtyModel>[];
      json['Other'].forEach((v) {
        otherSpecialties!.add(SpecialtyModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mostChosenSpecialties != null) {
      data['Most Chosen'] =
          mostChosenSpecialties!.map((v) => v.toJson()).toList();
    }
    if (otherSpecialties != null) {
      data['Other'] = otherSpecialties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
