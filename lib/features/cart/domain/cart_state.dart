import 'package:equatable/equatable.dart';
import '../../../shared/models/cart_item.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final int itemCount;
  final double totalPrice;

  const CartLoaded({
    required this.items,
    required this.itemCount,
    required this.totalPrice,
  });

  CartLoaded copyWith({
    List<CartItem>? items,
    int? itemCount,
    double? totalPrice,
  }) {
    return CartLoaded(
      items: items ?? this.items,
      itemCount: itemCount ?? this.itemCount,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [items, itemCount, totalPrice];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}

class CartItemAdded extends CartState {
  final String productName;

  const CartItemAdded(this.productName);

  @override
  List<Object?> get props => [productName];
}

class CartItemRemoved extends CartState {
  final String productName;

  const CartItemRemoved(this.productName);

  @override
  List<Object?> get props => [productName];
}

