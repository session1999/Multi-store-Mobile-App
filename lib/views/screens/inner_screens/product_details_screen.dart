import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/provider/cart_provider.dart';
import 'package:shopping_app/provider/favorite_provider.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final dynamic productData;

  const ProductDetailsScreen({super.key, required this.productData});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.pink),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Product Details",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, color: Color(0xFF363330)),
            ),
            IconButton(
              onPressed: () {
                favoriteProviderData.addProductToFavorite(
                    productName: widget.productData["productName"],
                    productId: widget.productData["productId"],
                    imageUrl: widget.productData["productImages"],
                    productPrice: widget.productData["productPrice"]);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    margin: EdgeInsets.all(15),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.grey,
                    content: Text(" You have added " +
                        widget.productData["productName"] +
                        " to your Favorite")));
              },
              icon: favoriteProviderData.getFavoriteItem
                      .containsKey(widget.productData["productId"])
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 260,
                height: 274,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 50,
                      child: Container(
                        width: 260,
                        height: 260,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Color(0xFFD8DDFF),
                          borderRadius: BorderRadius.circular(130),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 22,
                      top: 0,
                      child: Container(
                        width: 216,
                        height: 274,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Color(0xFF9CA8FF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: SizedBox(
                          height: 300,
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                widget.productData["productImages"].length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                widget.productData["productImages"][index],
                                width: 198,
                                height: 225,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.productData["productName"],
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Color(0xFF3C55EF),
                    ),
                  ),
                  Text(
                    "\$${widget.productData["productPrice"].toStringAsFixed(2)}",
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Color(0xFF3C55EF),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.productData["category"],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            widget.productData["rating"] == 0
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(" "),
                  )
                : Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        widget.productData["rating"].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        "(${widget.productData["totalReviews"]})",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                        ),
                      )
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Size",
                    style: GoogleFonts.lato(
                      color: Color(0xFF343434),
                      fontSize: 16,
                      letterSpacing: 1.6,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productData["productSize"].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF126881),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    widget.productData["productSize"][index],
                                    style:
                                        GoogleFonts.lato(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About",
                    style: GoogleFonts.lato(
                      color: Color(0xFF363330),
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(widget.productData["description"]),
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            cartProviderData.addProductToCart(
                productPrice: widget.productData["productPrice"],
                categoryName: widget.productData["category"],
                productName: widget.productData["productName"],
                imageUrl: widget.productData["productImages"],
                quantity: 1,
                instock: widget.productData["quantity"],
                productId: widget.productData["productId"],
                productSize: " ",
                discount: widget.productData["discount"],
                description: widget.productData["description"]);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                margin: EdgeInsets.all(15),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.grey,
                content: Text(widget.productData["productName"])));
          },
          child: Container(
            width: 386,
            height: 48,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Color(0xFF3B54EE),
                borderRadius: BorderRadius.circular(24)),
            child: Center(
              child: Text(
                "ADD TO CART",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
