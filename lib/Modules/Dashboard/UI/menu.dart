import 'dart:typed_data';

import 'package:donor_app/Modules/Auth/UI/change_password.dart';
import 'package:donor_app/Modules/Auth/UI/login.dart';
import 'package:donor_app/Modules/Auth/Utils/auth_helper.dart';
import 'package:donor_app/Modules/Dashboard/Model/home_model.dart';
import 'package:donor_app/Modules/Dashboard/UI/contactus.dart';
import 'package:donor_app/Modules/Dashboard/Utils/home_helper.dart';
import 'package:donor_app/Modules/StudentProfile/UI/beneficiary_list.dart';
import 'package:donor_app/Shared/UI/bottom_nav_bar.dart';
import 'package:donor_app/Shared/UI/feedback.dart';
import 'package:donor_app/Shared/Utils/SessionMangement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MenuList extends StatefulWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  MenuListState createState() => MenuListState();
}

class MenuListState extends State<MenuList> {
  DonorInfo? donorinfo;
  Uint8List? _imageBytes;
  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    getDonorInfo().then((response) {
      setState(() {
        donorinfo = response!;
        if (donorinfo!.donor_pic.isNotEmpty) {
          _fetchImage(donorinfo!.donor_pic);
        }
      });
      EasyLoading.dismiss();
    });
    super.initState();
  }

  Future<void> _fetchImage(String stdPicture) async {
    SessionMangement sm = SessionMangement();

    String? sessionId = await sm.getQalamSessionId();

    final response = await http.get(
      Uri.parse(stdPicture),
      headers: {
        'Content-Type': 'image/jpeg',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        _imageBytes = response.bodyBytes;
      });
    } else {
      print('Failed to load image: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE, dd MMM yyyy').format(now);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/BeneficiaryHeader.jpg'), // Your image asset path
                fit: BoxFit.cover, // Make the image cover the entire AppBar
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Version 1.0",
                      style: TextStyle(
                          color: Color(0xFFF5F4F4),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.home,
                          size: 30,
                          color: Color(0xFFF5F4F4),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: _imageBytes != null
                          ? MemoryImage(_imageBytes!)
                          : const AssetImage('assets/noImage.png')
                              as ImageProvider,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            donorinfo?.name ?? '---',
                            style: const TextStyle(
                                color: Color(0xFFF5F4F4),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow
                                .ellipsis, // Handle overflow if name is too long
                            maxLines: 1,
                          ),
                          Text(
                            formattedDate.toString(),
                            style: const TextStyle(
                                color: Color(0xFFF5F4F4),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavBar(
                          selectedIndex: 3,
                        )),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/batch.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "My Profile",
                    style: TextStyle(
                        color: Color(0xFF344054),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavBar(
                          selectedIndex: 1,
                        )),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/activeFund.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Funds Management",
                    style: TextStyle(
                        color: Color(0xFF344054),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          /*  GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavBar(
                          selectedIndex: 2,
                        )),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/summary.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Collection Summary",
                    style: TextStyle(
                        color: Color(0xFF344054),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ), */
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BeneficiaryList(
                    selectedIndex: 0,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/adoption.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Beneficiaries Information",
                    style: TextStyle(
                        color: Color(0xFF344054),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          /*    GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ComingSoon()),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/report.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Reports / Documents",
                    style: TextStyle(
                        color: Color(0xFF344054),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        */
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FeedBack()),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/feedback.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Feedback / Complaint",
                    style: TextStyle(
                        color: Color(0xFF344054),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ChangePassword()),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/currentPassword.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Update Password",
                    style: TextStyle(
                        color: Color(0xFF344054),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ContactUs()),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/contactus.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Contact us",
                    style: TextStyle(
                        color: Color(0xFF344054),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBC1E3D),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
