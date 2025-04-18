import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/provider/favorite_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopping_app/views/screens/main_screen.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishItemData = ref.watch(favoriteProvider);
    final favoriteData = ref.read(favoriteProvider.notifier);
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
                          wishItemData.length.toString(),
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
                  "My Favorite",
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
      body: Center(
        child: wishItemData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your Wish list is empty\n you can add to wishList from the button below",
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
                        "Add Now",
                        style: GoogleFonts.lato(
                          fontSize: 17,
                          letterSpacing: 1,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: wishItemData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final wishData = wishItemData.values.toList()[index];

                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: 335,
                      height: 96,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: SizedBox(
                        width: double.infinity,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 336,
                                height: 97,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0xFFEFF0F2),
                                    ),
                                    borderRadius: BorderRadius.circular(9)),
                              ),
                            ),
                            Positioned(
                              left: 13,
                              top: 9,
                              child: Container(
                                width: 78,
                                height: 78,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Color(0xFFBCC5FF),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            Positioned(
                              left: 275,
                              top: 16,
                              child: Text(
                                (wishData.productPrice as num)
                                    .toDouble()
                                    .toStringAsFixed(2),
                                style: GoogleFonts.lato(
                                    color: Color(0xFF0B0C1E),
                                    fontWeight: FontWeight.w600,
                                    height: 1.3),
                              ),
                            ),
                            Positioned(
                              left: 101,
                              top: 14,
                              child: SizedBox(
                                width: 162,
                                child: Text(
                                  wishData.productName,
                                  style: GoogleFonts.getFont("Lato",
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 23,
                              top: 14,
                              child: Image.network(
                                wishData.imageUrl[0],
                                width: 58,
                                height: 67,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                left: 284,
                                top: 47,
                                child: InkWell(
                                  onTap: () {
                                    favoriteData.removeItem(wishData.productId);
                                  },
                                  child: Image.asset(
                                    "assets/icons/delete.png",
                                    width: 28,
                                    height: 28,
                                    fit: BoxFit.cover,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
