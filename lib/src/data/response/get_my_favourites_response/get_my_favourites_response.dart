import 'package:healthify/src/data/shared_models/favourite_model.dart';

part 'get_my_favourites_response_data.dart';

class GetMyFavouritesResponse {
  GetMyFavouritesResponse({
    this.message,
    this.data,
  });

  GetMyFavouritesResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null
        ? GetMyFavouritesResponseData.fromJson(json['data'])
        : null;
  }

  String? message;
  GetMyFavouritesResponseData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}
