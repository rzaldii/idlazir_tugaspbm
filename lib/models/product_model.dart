class ProductModel {

  final int id;
  final String name;
  final int price;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: double.parse(
        json['price'].toString(),
      ).toInt(),
      description:
          json['description'] ?? '',
    );
  }
}