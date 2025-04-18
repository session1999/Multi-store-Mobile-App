import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/favorite_models.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, FavoriteModels>>(
  (ref) {
    return FavoriteNotifier();
  },
);

class FavoriteNotifier extends StateNotifier<Map<String, FavoriteModels>> {
  FavoriteNotifier() : super({});

  //to add product to favorite screen

  void addProductToFavorite(
      {required String productName,
      required String productId,
      required List imageUrl,
      required double productPrice}) {
    state[productId] = FavoriteModels(
        productName: productName,
        productId: productId,
        imageUrl: imageUrl,
        productPrice: productPrice);

    //notify listner that the state has changed

    state = {...state};
  }

  // to remove all item from favorite

  void removeAllItem() {
    state.clear();

    //notify listner that the state has changed

    state = {...state};
  }

  //remove favorite item

  void removeItem(String productId) {
    state.remove(productId);
//notify listner that the state has changed

    state = {...state};
  }

//retrieve value from the state object

  Map<String, FavoriteModels> get getFavoriteItem => state;
}
