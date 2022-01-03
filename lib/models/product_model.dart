class Product {
  int? id;
  late String name;
  late String productType;
  Product({
    id,
    required String this.name,
    required String this.productType,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      productType: json["productType"],
    );
  }
  toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "productType": productType,
    };
  }
}
