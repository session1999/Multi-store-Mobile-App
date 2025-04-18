import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/cart_models.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<dynamic, CartModels>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<Map<dynamic, CartModels>> {
  CartNotifier() : super({});

  void addProductToCart({
    required double productPrice,
    required String categoryName,
    required String productName,
    required List imageUrl,
    required int quantity,
    required int instock,
    required String productId,
    required String productSize,
    required int discount,
    required String description,
  }) {
    if (state.containsKey(productId)) {
      state = {
        ...state,
        productId: CartModels(
            productName: state[productId]!.productName,
            productPrice: state[productId]!.productPrice,
            categoryName: state[productId]!.categoryName,
            imageUrl: state[productId]!.imageUrl,
            quantity: state[productId]!.quantity + 1,
            instock: state[productId]!.instock,
            productId: state[productId]!.productId,
            productSize: state[productId]!.productSize,
            discount: state[productId]!.discount,
            description: state[productId]!.description)
      };
    } else {
      state = {
        ...state,
        productId: CartModels(
            productName: productName,
            productPrice: productPrice,
            categoryName: categoryName,
            imageUrl: imageUrl,
            quantity: quantity,
            instock: instock,
            productId: productId,
            productSize: productSize,
            discount: discount,
            description: description)
      };
    }
  }

  //function to remove item from cart

  void removeItem(String productId) {
    state.remove(productId);

    //Notify listener that the state has changed
    state = {...state};
  }

  //function to increment cart item

  void incrementItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;
    }

    //notify listner that the state has changed

    state = {...state};
  }

  //function to decrement the cart item

  void decrementItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;
    }

    //notify listener that the state has changed

    state = {...state};
  }

  //function to calculate amount
  double calculateTotalAmount() {
    double totalAmount = 0.0;

    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.discount;
    });

    return totalAmount;
  }

  Map<dynamic, CartModels> get getCartItems => state;
}
