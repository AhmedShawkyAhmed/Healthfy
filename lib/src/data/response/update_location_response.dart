class UpdateLocationResponse {
  String? message;
  List<dynamic>? data;

  UpdateLocationResponse({
    required String message,
    required List<dynamic> data,
  });

  UpdateLocationResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(v);
      });
    }
  }
}
