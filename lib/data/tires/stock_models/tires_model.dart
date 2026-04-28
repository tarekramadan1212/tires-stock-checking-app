class TireModel {
  final String brand;
  final String size;
  final double price;
  final int quantity;

  TireModel({
    required this.brand,
    required this.size,
    required this.price,
    required this.quantity,
  });

  factory TireModel.fromJson(Map<String, dynamic> json) {
    return TireModel(
      brand: json['brand'],
      size: json['size'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
