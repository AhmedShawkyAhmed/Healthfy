class AddOrRemoveFavouriteResponse {
  String? message;
  List<dynamic>? data;

  AddOrRemoveFavouriteResponse({
    this.message,
    this.data,
  });

  AddOrRemoveFavouriteResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(v);
      });
    }
  }
}
