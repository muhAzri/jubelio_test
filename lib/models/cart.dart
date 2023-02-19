import 'package:equatable/equatable.dart';
import 'package:jubelio_test/models/product.dart';

class CartModel extends Equatable {
  final int? id;
  final ProductModel product;
  int quantity;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      product: ProductModel.fromJson(json),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'product': product.toJson(), 'quantity': quantity};
  }
  @override
  List<Object?> get props => [id, product, quantity];
}
