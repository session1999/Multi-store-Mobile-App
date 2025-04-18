class CartModels {
  final String productName;
  final double productPrice;
  final String categoryName;
  final List imageUrl;
  int quantity;
  final int instock;
  final String productId;
  final String productSize;
  final int discount;
  final String description;

  CartModels(
      {required this.productName,
      required this.productPrice,
      required this.categoryName,
      required this.imageUrl,
      required this.quantity,
      required this.instock,
      required this.productId,
      required this.productSize,
      required this.discount,
      required this.description});
}
