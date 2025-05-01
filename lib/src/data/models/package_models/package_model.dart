class PackageModel {
  int? id;
  String? name;
  String? description;
  String? price;
  String? oldPrice;
  int? duration;
  int? mostSale;

  PackageModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.oldPrice,
    this.duration,
    this.mostSale,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        description: json['description'] ?? "",
        price: json['price'] ?? "",
        oldPrice: json['old_price'] ?? "",
        duration: json['duration'] ?? 0,
        mostSale: json['most_sale'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'old_price': oldPrice,
        'duration': duration,
        "most_sale": mostSale,
      };
}
