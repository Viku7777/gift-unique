class ProductModel {
  final String title;
  final String description;
  final double price;
  final double lineThroughPrice;
  final List<String> images;
  final List<String> size;
  final bool isSale;

  // Constructor
  ProductModel({
    required this.title,
    required this.description,
    required this.price,
    required this.lineThroughPrice,
    required this.images,
    required this.size,
    required this.isSale,
  });

  // Factory method to create a ProductModel instance from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      lineThroughPrice: json['lineThroughPrice'].toDouble(),
      images: List<String>.from(json['images']),
      size: List<String>.from(json['size']),
      isSale: json['isSale'],
    );
  }

  // Method to convert Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'lineThroughPrice': lineThroughPrice,
      'images': images,
      'size': size,
      'isSale': isSale,
    };
  }
}
