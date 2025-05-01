class PointsModel {
  int? id;
  String? points;
  List<dynamic>? transaction;

  PointsModel({this.id, this.points, this.transaction});

  PointsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    points = json['points'];
    if (json['transaction'] != null) {
      transaction = <Null>[];
      json['transaction'].forEach((v) {
        transaction!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['points'] = points;
    if (transaction != null) {
      data['transaction'] = transaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
