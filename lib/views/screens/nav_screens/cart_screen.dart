import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/provider/cart_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopping_app/views/screens/inner_screens/checkout_screen.dart';
import 'package:shopping_app/views/screens/main_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CartNotifier = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/icons/cartb.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/icons/not.png",
                      width: 26,
                      height: 25,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                            badgeColor: Colors.yellow.shade900),
                        badgeContent: Text(
                          cartData.length.toString(),
                          style: GoogleFonts.lato(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                  "My Cart",
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
      body: cartData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Shopping Cart is Empty\n you can add product to your cart from the button below",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      letterSpacing: 1.7,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MainScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Shop Now",
                        style: GoogleFonts.lato(
                          fontSize: 17,
                          letterSpacing: 1,
                        ),
                      ))
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 49,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 49,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(color: Color(0xFFD7DDFF)),
                          ),
                        ),
                        Positioned(
                          left: 44,
                          top: 19,
                          child: Container(
                            width: 10,
                            height: 10,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Positioned(
                          left: 69,
                          top: 14,
                          child: Text(
                            "You have ${cartData.length} items",
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                      itemCount: cartData.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cartItem = cartData.values.toList()[index];

                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: Card(
                            child: SizedBox(
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                      cartItem.imageUrl[0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          cartItem.productName,
                                          style: GoogleFonts.lato(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          cartItem.categoryName,
                                          style: GoogleFonts.lato(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blueGrey),
                                        ),
                                        Text(
                                          cartItem.productPrice
                                              .toStringAsFixed(2),
                                          style: GoogleFonts.lato(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF102DE1),
                                              ),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      CartNotifier
                                                          .decrementItem(
                                                              cartItem
                                                                  .productId);
                                                    },
                                                    icon: Icon(
                                                        CupertinoIcons.minus),
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    cartItem.quantity
                                                        .toString(),
                                                    style: GoogleFonts.lato(
                                                        color: Colors.white),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      CartNotifier
                                                          .incrementItem(
                                                              cartItem
                                                                  .productId);
                                                    },
                                                    icon: Icon(
                                                        CupertinoIcons.plus),
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                CartNotifier.removeItem(
                                                    cartItem.productId);
                                              },
                                              icon: Icon(CupertinoIcons.delete),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        width: 416,
        height: 89,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 416,
                height: 89,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFC4C4C4)),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.63, -0.26),
              child: Text(
                "Subtotal",
                style: GoogleFonts.roboto(
                    color: Color(0xFFA1A1A1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment(-0.19, -0.31),
              child: Text(
                totalAmount.toStringAsFixed(2),
                style: GoogleFonts.roboto(
                    color: Color(0xFFFF6464),
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Align(
              alignment: Alignment(0.82, -1),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CheckoutScreen();
                      },
                    ),
                  );
                },
                child: Container(
                  width: 166,
                  height: 71,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: totalAmount == 0.0 ? Colors.grey : Color(0xFF1532E7),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Checkout",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.pink,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
