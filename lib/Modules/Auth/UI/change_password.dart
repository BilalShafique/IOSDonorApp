import 'package:donor_app/Modules/Auth/Model/auth_model.dart';
import 'package:donor_app/Modules/Auth/Utils/auth_helper.dart';
import 'package:donor_app/Shared/UI/custom_color_scheme.dart';
import 'package:donor_app/Shared/Utils/general_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  ChangePasswordModel obj = ChangePasswordModel();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Update Password",
            style: TextStyle(
              color: Colors.white, // Text color
            ),
          ),
          // Back button (default or manually added)
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white, // Back button color
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/fundAppbar.jpg'), // Your image asset path
                fit: BoxFit.cover, // Make the image cover the entire AppBar
              ),
            ),
          ),
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Current Password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      controller: currentPassController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Current password is required';
                        } else if (value.length > 35) {
                          return 'Maximum 35 characters allowed';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        obj.currentPassword = value;
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true, // Enables the background fill
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: 'Enter current password here..',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "New Password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      controller: newPassController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'New password is required';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        obj.newPassword = value;
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true, // Enables the background fill
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        hintText: 'Enter new password here',
                        hintStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      controller: confirmPassController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm password is required';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        obj.confirmPassword = value;
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true, // Enables the background fill
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        hintText: 'Enter confirm password here',
                        hintStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
                          'Submit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            EasyLoading.show(status: 'Requesting...');

                            changePassword(obj).then((reponse) {
                              EasyLoading.dismiss();

                              if (reponse! == "1") {
                                showInfoAlert(
                                    "Success!",
                                    "Password has been changed successfully.",
                                    "assets/images/alert.json",
                                    context);
                              } else {
                                showInfoAlert("Error!", reponse,
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
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
