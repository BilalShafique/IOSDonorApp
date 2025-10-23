import 'package:donor_app/Modules/Auth/UI/forgot_password.dart';
import 'package:donor_app/Modules/Auth/Utils/auth_helper.dart';
import 'package:donor_app/Shared/UI/bottom_nav_bar.dart';
import 'package:donor_app/Shared/UI/custom_color_scheme.dart';
import 'package:donor_app/Shared/Utils/SessionMangement.dart';
import 'package:donor_app/Shared/Utils/general_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool isShowPassword = false;
  bool rememberMe = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SessionMangement _sm = SessionMangement();
  @override
  void initState() {
    super.initState();
    checkUserCredentials();
  }

  void checkUserCredentials() async {
    String? username = await _sm.getUserName();
    String? password = await _sm.getPassword();

    if (username != null && password != null) {
      setState(() {
        userNameController.text = username;
        passwordController.text = password;
      });

      EasyLoading.show(status: 'Checking Authentication...');

      Donorlogin(username, password).then((response) {
        EasyLoading.dismiss();
        if (response != null) {
          if (response.isAuthSuccessful) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavBar(selectedIndex: 0)),
            );
          } else {
            showInfoAlert("Oops!", response.errorMessage,
                "assets/images/alert.json", context);
          }
        } else {
          showInfoAlert("Oops!", "Invalid credentials",
              "assets/images/alert.json", context);
        }
      }).catchError((error) {
        EasyLoading.dismiss();
        showInfoAlert("Error", "An error occurred: $error",
            "assets/images/error.json", context);
      });
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/login_background.png'), // Background image path
              fit: BoxFit.cover, // Fit the image to cover the entire screen
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            color: const Color(0xFF0B385B).withOpacity(0.8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
                    width: 150,
                  ),
                  const Text(
                    "Greetings!",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "Please enter you details",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Username",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextFormField(
                    controller: userNameController,
                    validator: (value) {
                      String pattern =
                          r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      RegExp regex = RegExp(pattern);

                      if (value!.isEmpty) {
                        return 'Email Address is required';
                      } else if (value.length > 35) {
                        return 'Maximum up 35 characters';
                      } else if (!regex.hasMatch(value)) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true, // Enables the background fill
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      hintText: 'example@nust.com',
                      hintStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextFormField(
                    obscureText: !isShowPassword,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      filled: true, // Enables the background fill
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(5.0)),
                      suffixIcon: IconButton(
                          icon: Icon(
                              isShowPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 20),
                          onPressed: () {
                            setState(() {
                              isShowPassword = !isShowPassword;
                            });
                          }),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.blueColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          EasyLoading.show(
                              status: 'Checking Authentication...');

                          Donorlogin(userNameController.text,
                                  passwordController.text)
                              .then((reponse) {
                            EasyLoading.dismiss();
                            if (reponse != null) {
                              if (reponse.isAuthSuccessful == true) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavBar(
                                            selectedIndex: 0,
                                          )),
                                );
                              } else {
                                showInfoAlert("Oops!", reponse.errorMessage,
                                    "assets/images/alert.json", context);
                              }
                            } else {
                              EasyLoading.dismiss();
                              showInfoAlert("Oops!", "Invalid credentials",
                                  "assets/images/alert.json", context);
                            }
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF0B385B).withOpacity(0.0),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        "National University of Sciences & \n Technology (NUST)",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    ]));
  }
}
