part of 'countries_response.dart';

class CountriesResponseData {
  List<CountryModel>? countries;

  CountriesResponseData({this.countries});

  CountriesResponseData.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <CountryModel>[];
      json['countries'].forEach((v) {
        countries!.add(CountryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
