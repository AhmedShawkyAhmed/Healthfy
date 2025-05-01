part of 'get_my_favourites_response.dart';

class GetMyFavouritesResponseData {
  GetMyFavouritesResponseData({
    this.favs,
  });

  GetMyFavouritesResponseData.fromJson(dynamic json) {
    if (json['favs'] != null) {
      favs = [];
      json['favs'].forEach((v) {
        favs?.add(FavouriteModel.fromJson(v));
      });
    }
  }

  List<FavouriteModel>? favs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (favs != null) {
      map['favs'] = favs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
