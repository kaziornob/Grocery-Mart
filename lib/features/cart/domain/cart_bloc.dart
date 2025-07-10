import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/services/cart_service.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService _cartService;

  CartBloc({CartService? cartService})
      : _cartService = cartService ?? CartService(),
        super(const CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(
    LoadCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(const CartLoading());
      await _cartService.loadCart();
      
      emit(CartLoaded(
        items: _cartService.cartItems,
        itemCount: _cartService.itemCount,
        totalPrice: _cartService.totalPrice,
      ));
    } catch (e) {
      emit(CartError('Failed to load cart: ${e.toString()}'));
    }
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartService.addToCart(event.product, quantity: event.quantity);
      
      emit(CartLoaded(
        items: _cartService.cartItems,
        itemCount: _cartService.itemCount,
        totalPrice: _cartService.totalPrice,
      ));
      
      // Emit a temporary state to show success message
      emit(CartItemAdded(event.product.name));
      
      // Return to loaded state
      emit(CartLoaded(
        items: _cartService.cartItems,
        itemCount: _cartService.itemCount,
        totalPrice: _cartService.totalPrice,
      ));
    } catch (e) {
      emit(CartError('Failed to add item to cart: ${e.toString()}'));
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      final item = _cartService.getCartItem(event.productId);
      await _cartService.removeFromCart(event.productId);
      
      emit(CartLoaded(
        items: _cartService.cartItems,
        itemCount: _cartService.itemCount,
        totalPrice: _cartService.totalPrice,
      ));
      
      // Emit a temporary state to show success message
      if (item != null) {
        emit(CartItemRemoved(item.product.name));
        
        // Return to loaded state
        emit(CartLoaded(
          items: _cartService.cartItems,
          itemCount: _cartService.itemCount,
          totalPrice: _cartService.totalPrice,
        ));
      }
    } catch (e) {
      emit(CartError('Failed to remove item from cart: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateQuantity(
    UpdateQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartService.updateQuantity(event.productId, event.quantity);
      
      emit(CartLoaded(
        items: _cartService.cartItems,
        itemCount: _cartService.itemCount,
        totalPrice: _cartService.totalPrice,
      ));
    } catch (e) {
      emit(CartError('Failed to update quantity: ${e.toString()}'));
    }
  }

  Future<void> _onIncreaseQuantity(
    IncreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartService.increaseQuantity(event.productId);
      
      emit(CartLoaded(
        items: _cartService.cartItems,
        itemCount: _cartService.itemCount,
        totalPrice: _cartService.totalPrice,
      ));
    } catch (e) {
      emit(CartError('Failed to increase quantity: ${e.toString()}'));
    }
  }

  Future<void> _onDecreaseQuantity(
    DecreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartService.decreaseQuantity(event.productId);
      
      emit(CartLoaded(
        items: _cartService.cartItems,
        itemCount: _cartService.itemCount,
        totalPrice: _cartService.totalPrice,
      ));
    } catch (e) {
      emit(CartError('Failed to decrease quantity: ${e.toString()}'));
    }
  }

  Future<void> _onClearCart(
    ClearCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartService.clearCart();
      
      emit(CartLoaded(
        items: _cartService.cartItems,
        itemCount: _cartService.itemCount,
        totalPrice: _cartService.totalPrice,
      ));
    } catch (e) {
      emit(CartError('Failed to clear cart: ${e.toString()}'));
    }
  }
}

