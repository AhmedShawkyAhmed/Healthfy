import 'package:healthify/src/data/shared_models/country_model.dart';

part 'countries_response_data.dart';

class CountriesResponse {
  String? message;
  CountriesResponseData? data;

  CountriesResponse({this.message, this.data});

  CountriesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? CountriesResponseData.fromJson(json['data'])
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
