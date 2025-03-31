import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/controller/auth_controller.dart';
import 'package:shopping_app/views/screens/authentication_screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // const RegisterScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();

  final AuthController _authController = AuthController();

  late String email;

  late String password;

  late String fullNames;

  bool _isLoading = false;

  bool _isObscure = true;

  registerUser() async {
    BuildContext localContext = context;
    setState(() {
      _isLoading = true;
    });
    String res =
        await _authController.registerNewUser(email, password, fullNames);
    if (res == "Success") {
      Future.delayed(Duration.zero, () {
        Navigator.push(localContext, MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }));
      });

      ScaffoldMessenger.of(localContext)
          .showSnackBar(SnackBar(content: Text("Congrats account is created")));
    } else {
      setState(() {
        _isLoading = false;
      });
    }
    Future.delayed(Duration.zero, () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Create Your Account",
                  style: GoogleFonts.getFont("Lato",
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "To Explore the world exclusives",
                style: GoogleFonts.getFont("Lato",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/Illustration.png",
                height: 200,
                width: 200,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Email",
                  style: GoogleFonts.getFont("Lato", color: Colors.pink),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your email";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelText: "Enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(08),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/icons/email.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  fullNames = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your full names";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: "Enter your Full name",
                  labelStyle: GoogleFonts.getFont("Lato", color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.8)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/icons/user.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                  // suffixIcon: Icon(Icons.visibility),
                ),
              ),
              TextFormField(
                obscureText: _isObscure,
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    labelText: "Enter your password",
                    labelStyle:
                        GoogleFonts.getFont("Lato", color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.8)),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/icons/password.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off))),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // _authController.registerNewUser(email, password, fullNames);
                    registerUser();
                  } else {
                    print("failed");
                  }
                },
                child: Container(
                  width: 318,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.blue.shade900]),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 278,
                        top: 19,
                        child: Opacity(
                          opacity: 0.5,
                          child: Container(
                            width: 60,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                border: Border.all(width: 12),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 260,
                          top: -10,
                          child: Opacity(
                            opacity: 0.5,
                            child: Container(
                              width: 30,
                              height: 30,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 20, color: Colors.black),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          )),
                      Center(
                        child: InkWell(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Sign up",
                                  style: GoogleFonts.getFont("Lato",
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.getFont("Lato",
                        color: Colors.black, fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    child: Text(
                      "Sign in",
                      style: GoogleFonts.getFont("Lato",
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
