import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../../core/constants/app_constants.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  List<CartItem> _cartItems = [];

  // Get all cart items
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  // Get cart items count
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Get total price
  double get totalPrice => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Load cart from SharedPreferences
  Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(AppConstants.cartItemsKey);
      
      if (cartJson != null) {
        final List<dynamic> cartList = json.decode(cartJson);
        _cartItems = cartList.map((item) => CartItem.fromJson(item)).toList();
      }
    } catch (e) {
      // If there's an error loading, start with empty cart
      _cartItems = [];
    }
  }

  // Save cart to SharedPreferences
  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = json.encode(_cartItems.map((item) => item.toJson()).toList());
      await prefs.setString(AppConstants.cartItemsKey, cartJson);
    } catch (e) {
      // Handle save error silently
    }
  }

  // Add item to cart
  Future<void> addToCart(Product product, {int quantity = 1}) async {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      // Update existing item quantity
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + quantity,
      );
    } else {
      // Add new item
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }
    
    await _saveCart();
  }

  // Remove item from cart
  Future<void> removeFromCart(String productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
    await _saveCart();
  }

  // Update item quantity
  Future<void> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      await _saveCart();
    }
  }

  // Increase item quantity
  Future<void> increaseQuantity(String productId) async {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      );
      await _saveCart();
    }
  }

  // Decrease item quantity
  Future<void> decreaseQuantity(String productId) async {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      final newQuantity = _cartItems[index].quantity - 1;
      if (newQuantity <= 0) {
        await removeFromCart(productId);
      } else {
        _cartItems[index] = _cartItems[index].copyWith(quantity: newQuantity);
        await _saveCart();
      }
    }
  }

  // Clear cart
  Future<void> clearCart() async {
    _cartItems.clear();
    await _saveCart();
  }

  // Check if product is in cart
  bool isInCart(String productId) {
    return _cartItems.any((item) => item.product.id == productId);
  }

  // Get quantity of specific product in cart
  int getProductQuantity(String productId) {
    final item = _cartItems.where((item) => item.product.id == productId).firstOrNull;
    return item?.quantity ?? 0;
  }

  // Get cart item by product ID
  CartItem? getCartItem(String productId) {
    try {
      return _cartItems.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }
}

// Extension to add firstOrNull method
extension ListExtension<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      return iterator.current;
    }
    return null;
  }
}

