class CategoryModel {
  String? key;
  String? nameAr;
  String? nameEn;
  String? logo;

  CategoryModel({
    this.nameAr,
    this.nameEn,
    this.key,
    this.logo,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    nameAr: json['nameAr'] ?? "",
    nameEn: json['nameEn'] ?? "",
    key: json['key'] ?? "",
    logo: json['logo'] ?? "",
  );

  Map<String, dynamic> toJson() => {
    'nameAr': nameAr,
    'nameEn': nameEn,
    'key': key,
    'logo': logo,
  };
}
