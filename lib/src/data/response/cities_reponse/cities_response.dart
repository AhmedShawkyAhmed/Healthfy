import 'package:healthify/src/data/shared_models/city_model.dart';

part 'cities_response_data.dart';

class CitiesResponse {
  String? message;
  CitiesResponseData? data;

  CitiesResponse({this.message, this.data});

  CitiesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data =
        json['data'] != null ? CitiesResponseData.fromJson(json['data']) : null;
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
