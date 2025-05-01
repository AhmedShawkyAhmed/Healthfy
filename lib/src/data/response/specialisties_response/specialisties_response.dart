import 'package:healthify/src/data/shared_models/specialty_model.dart';

part 'specialisties_response_data.dart';

class SpecialistiesResponse {
  String? message;
  SpecialistiesResponseData? data;

  SpecialistiesResponse({this.message, this.data});

  SpecialistiesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? SpecialistiesResponseData.fromJson(json['data'])
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
