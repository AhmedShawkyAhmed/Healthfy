class DoctorModel {
  String? name;
  String? image;
  String? title;

  DoctorModel({
    this.name,
    this.image,
    this.title,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        name: json["name"] ?? "",
        image: json["image"] ?? "",
        title: json["title"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'title': title,
      };
}
