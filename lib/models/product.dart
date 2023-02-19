import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<String>? imageUrl;
  final String price;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> images = json['images'];
    final List<String> imageUrls =
        images.map((image) => image['src']).cast<String>().toList();

    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] == ''
          ? json['short_description']
          : json['description'],
      imageUrl: imageUrls,
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  @override
  List<Object?> get props => [id, name, description, imageUrl, price];
}
