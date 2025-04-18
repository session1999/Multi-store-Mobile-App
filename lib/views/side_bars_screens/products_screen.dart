import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  static const String id = "productsScreen";

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _sizeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final List<String> _categoryList = [];
  final List<Uint8List> _images = [];
  final List<String> _sizeList = [];
  final List<String> _imagesUrl = []; // to store images url

  bool _isIsentered = false;

//We will be uploading the values stored in these variable to the cloudfire store
  String? selectedCategory;

  String? productName;
  double? productPrice;
  int? discount;
  int? quantity;
  String? discription;

  chooseImage() async {
    final pickedImages = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (pickedImages == null) {
      print("No image picked");
    } else {
      setState(() {
        for (var file in pickedImages.files) {
          _images.add(file.bytes!);
        }
      });
    }
  }

  _getCategories() {
    return _firestore
        .collection("categories")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _categoryList.add(doc["categoryName"]);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  //upload product image to storage
  // uploadImageToStorage() async {
  //   for (var img in _images) {
  //     Reference ref =
  //         _firebaseStorage.ref().child("productImages").child(Uuid().v4());
  //     await ref.putData(img).whenComplete(() async {
  //       await ref.getDownloadURL().then((value) {
  //         setState(() {
  //           _imagesUrl.add(value);
  //         });
  //       });
  //     });
  //   }
  // }

  Future<void> uploadImageToStorage() async {
    List<String> uploadedUrls = [];

    for (var img in _images) {
      Reference ref =
          _firebaseStorage.ref().child("productImages").child(Uuid().v4());

      // Upload image and wait for completion
      TaskSnapshot snap = await ref.putData(img);

      // Get download URL
      String downloadUrl = await snap.ref.getDownloadURL();
      uploadedUrls.add(downloadUrl);
    }

    // Update state once all images are uploaded
    setState(() {
      _imagesUrl.addAll(uploadedUrls);
    });

    print("Uploaded Image URLs: $_imagesUrl"); // Debugging log
  }

  //function to upload product to cloud

  uploadData() async {
    setState(() {
      _isLoading = true;
    });
    await uploadImageToStorage();

    if (_imagesUrl.isNotEmpty) {
      final productId = Uuid().v4();
      await _firestore.collection("product").doc(productId).set({
        "productId": productId,
        "productName": productName,
        "productPrice": productPrice,
        "productSize": _sizeList,
        "category": selectedCategory,
        "description": discription,
        "discount": discount,
        "quantity": quantity,
        "productImages": _imagesUrl
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
          _formKey.currentState!.reset();
          _imagesUrl.clear();
          _images.clear();
          _sizeList.clear();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Products Information,",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) {
                  productName = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter field";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Enter Product Name",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      onChanged: (value) {
                        print("Raw value before parsing: $value");
                        // productPrice = double.parse(value);
                        productPrice = double.tryParse(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter field";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Enter Price",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: buildDropDownField(),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  productPrice = double.tryParse(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter field";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Discount",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  quantity = int.tryParse(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter field";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Quantity",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  discription = value;
                },
                maxLength: 800,
                maxLines: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter field";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Enter Discription",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: _sizeController,
                        onChanged: (value) {
                          setState(() {
                            _isIsentered = true;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Add Size",
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  _isIsentered == true
                      ? Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _sizeList.add(_sizeController.text);
                                _sizeController
                                    .clear(); //This will clear the textfield after adding
                              });
                            },
                            child: Text("Add"),
                          ),
                        )
                      // : SizedBox.shrink(),
                      : Text(" "),
                ],
              ),
              _sizeList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _sizeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _sizeList.removeAt(index);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade800,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _sizeList[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  : SizedBox.shrink(),
              // : Text(" "),
              SizedBox(
                height: 20,
              ),

              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _images.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Center(
                            child: IconButton(
                                onPressed: () {
                                  chooseImage();
                                },
                                icon: Icon(Icons.add)),
                          )
                        : Image.memory(_images[index - 1]);
                  }),

              InkWell(
                onTap: () {
                  //Upload product to cloud firestore
                  if (_formKey.currentState!.validate()) {
                    uploadData();

                    print("Uploaded");
                  } else {
                    //please fill in all fields
                    print("Bad status");
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(9)),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Center(
                          child: Text(
                            "Upload Products",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropDownField() {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: "Select Category",
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
        items: _categoryList.map((value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedCategory = value;
            });
          }
        });
  }
}
