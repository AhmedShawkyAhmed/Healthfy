import 'package:healthify/src/data/shared_models/region_model.dart';

part 'regions_response_data.dart';

class RegionsResponse {
  String? message;
  RegionsResponseData? data;

  RegionsResponse({this.message, this.data});

  RegionsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? RegionsResponseData.fromJson(json['data'])
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
