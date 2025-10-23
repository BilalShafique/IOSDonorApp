import 'package:donor_app/Modules/Profile/Utils/donor_profileDataHelper.dart';
import 'package:donor_app/Shared/UI/custom_color_scheme.dart';

import 'package:donor_app/Shared/Utils/general_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  FeedBackState createState() => FeedBackState();
}

class FeedBackState extends State<FeedBack> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  int feedBackType = 1;
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
            "Feedback",
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
                    feedBackType == 1
                        ? Row(
                            children: [
                              Image.asset(
                                'assets/suggestion.png',
                                width: 50,
                                height: 50,
                              ),
                              const Text(
                                "Suggestion",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF467EAD)),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Image.asset(
                                'assets/complaints.png',
                                width: 50,
                                height: 50,
                              ),
                              const Text(
                                "Complaint",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF467EAD)),
                              ),
                            ],
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            setState(() {
                              feedBackType = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: feedBackType == 1
                                  ? const Color(0xFF467EAD)
                                  : const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/suggestion.png',
                                  width: 50,
                                  height: 50,
                                  color: feedBackType == 1
                                      ? const Color(0xFFF5F4F4).withOpacity(0.5)
                                      : null,
                                ),
                                Text(
                                  "Suggestion",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: feedBackType == 1
                                        ? const Color(0xFFF5F4F4)
                                        : const Color(0xFF5A5F5C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            setState(() {
                              feedBackType = 2;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: feedBackType == 2
                                  ? const Color(0xFF467EAD)
                                  : const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/complaints.png',
                                  width: 50,
                                  height: 50,
                                  color: feedBackType == 2
                                      ? const Color(0xFFF5F4F4).withOpacity(0.5)
                                      : null,
                                ),
                                Text(
                                  "Complaint",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: feedBackType == 2
                                        ? const Color(0xFFF5F4F4)
                                        : const Color(0xFF5A5F5C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text(
                        "Subject",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      controller: subjectController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Subject is required';
                        } else if (value.length > 35) {
                          return 'Maximum 35 characters allowed';
                        }
                        return null;
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
                        hintText: 'Enter subject here..',
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
                        "Description",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      controller: bodyController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Description is required';
                        }
                        return null;
                      },
                      maxLines: 5,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true, // Enables the background fill
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        hintText: 'Enter description here',
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

                            SendFeedback(subjectController.text,
                                    bodyController.text, feedBackType)
                                .then((reponse) {
                              EasyLoading.dismiss();

                              if (reponse! == "1") {
                                showInfoAlert(
                                    "Success!",
                                    "Feedback has been sent successfully.",
                                    "assets/images/alert.json",
                                    context);
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
