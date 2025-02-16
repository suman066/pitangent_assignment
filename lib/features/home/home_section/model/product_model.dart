class Product {
  final int id;
  final String title;
  final String image;
  final double price;

  Product({required this.id, required this.title, required this.image, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
