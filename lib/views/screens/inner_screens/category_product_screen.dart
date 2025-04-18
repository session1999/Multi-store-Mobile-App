import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/model/category_models.dart';
import 'package:shopping_app/views/screens/nav_screens/widgets/populatitem.dart';

class CategoryProductScreen extends StatelessWidget {
  final CategoryModels categoryModels;

  const CategoryProductScreen({super.key, required this.categoryModels});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
        .collection('products')
        .where("category", isEqualTo: categoryModels.categoryName)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryModels.categoryName,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No product under this category\ncheck back later",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.7),
              ),
            );
          }

          return GridView.count(
            physics: ScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            shrinkWrap: true,
            childAspectRatio: 300 / 500,
            children: List.generate(snapshot.data!.size, (index) {
              final productData = snapshot.data!.docs[index];

              return PopularItem(productData: productData);
            }),
          );
        },
      ),
    );
  }
}
