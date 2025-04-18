import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String state;
  late String city;
  late String locality;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF2FFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xF2FFFFFF),
        title: Text(
          "Delivery",
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Where will your order\n be shipped",
                  style: GoogleFonts.lato(fontSize: 18, letterSpacing: 2),
                ),
                TextFormField(
                  onChanged: (value) {
                    state = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter field";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(labelText: "State"),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  onChanged: (value) {
                    city = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter field";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(labelText: "City"),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  onChanged: (value) {
                    locality = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter field";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(labelText: "Locality"),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              //Update the user locality, city, state, pincode
              _showDialog(context);
              await _firestore
                  .collection("Buyers")
                  .doc(_auth.currentUser!.uid)
                  .update({
                "state": state,
                "city": city,
                "locality": locality
              }).whenComplete(() {
                Navigator.of(context).pop();
                setState(() {
                  _formKey.currentState!.validate();
                });
              });
            } else {
              //We can show a snackBar
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFF1532E7),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Center(
              child: Text(
                "Add Address",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false, //User must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Updating Address"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text("Please wait"),
              ],
            ),
          );
        });

    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pop();
      },
    );
  }
}
