import 'package:healthify/src/data/shared_models/location_model.dart';

part 'get_all_location_response_data.dart';

class GetAllLocationResponse {
  GetAllLocationResponse({
    this.message,
    this.data,
  });

  GetAllLocationResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null
        ? GetAllLocationResponseData.fromJson(json['data'])
        : null;
  }

  String? message;
  GetAllLocationResponseData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}
