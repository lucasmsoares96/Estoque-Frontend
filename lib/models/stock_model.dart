class Stock {
  late int id;
  late int quantity;
  Stock({
    required id,
    required quantity,
  });
  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json["id"],
      quantity: json["quantity"],
    );
  }
  toMap() {
    return <String, dynamic>{
      "id": id,
      "quantity": quantity,
    };
  }
}
