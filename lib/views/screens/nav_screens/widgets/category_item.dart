// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shopping_app/controller/category_controller.dart';

// class CategoryItem extends StatefulWidget {
//   const CategoryItem({super.key});

//   @override
//   State<CategoryItem> createState() => _CategoryItemState();
// }

// class _CategoryItemState extends State<CategoryItem> {
//   final CategoryController _categoryController = Get.find<CategoryController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GridView.builder(
//               itemCount: _categoryController.categories.length,
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   mainAxisSpacing: 4, crossAxisSpacing: 8, crossAxisCount: 4),
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () {},
//                   child: Column(
//                     children: [
//                       Image.network(
//                         _categoryController.categories[index].categoryImage,
//                         width: 47,
//                         height: 47,
//                         fit: BoxFit.cover,
//                       ),
//                       Text(
//                         _categoryController.categories[index].categoryImage,
//                         style: GoogleFonts.quicksand(
//                             fontSize: 14,
//                             letterSpacing: 0.3,
//                             fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 );
//               }),
//         ],
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/controller/category_controller.dart';
import 'package:shopping_app/views/screens/inner_screens/category_product_screen.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  final CategoryController _categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: GridView.builder(
          itemCount: _categoryController.categories.length,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 8,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CategoryProductScreen(
                        categoryModels: _categoryController.categories[index],
                      );
                    },
                  ),
                );
              },
              child: Column(
                children: [
                  Image.network(
                    _categoryController.categories[index].categoryImage,
                    width: 47,
                    height: 47,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    _categoryController.categories[index]
                        .categoryName, // Changed from categoryImage to categoryName
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
