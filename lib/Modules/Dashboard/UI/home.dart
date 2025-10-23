import 'dart:typed_data';

import 'package:donor_app/Modules/Auth/Utils/auth_helper.dart';
import 'package:donor_app/Modules/Dashboard/Model/home_model.dart';
import 'package:donor_app/Modules/Dashboard/UI/menu.dart';
import 'package:donor_app/Modules/Dashboard/Utils/home_helper.dart';
import 'package:donor_app/Modules/Fund/UI/fund.dart';
import 'package:donor_app/Modules/FundDetail/UI/fund_detail.dart';
import 'package:donor_app/Modules/StudentProfile/UI/beneficiary_list.dart';
import 'package:donor_app/Shared/Utils/SessionMangement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DonorInfo? donorinfo;
  List<DonorFund> fundList = [];
  Uint8List? _imageBytes;
  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'loading...');
    getDonorInfo().then((response) {
      if (response != null) {
        setState(() {
          donorinfo = response;
          if (donorinfo!.donor_pic.isNotEmpty) {
            _fetchImage(donorinfo!.donor_pic);
          }
        });
      }

      EasyLoading.dismiss();
    });
    getFunds().then((response) {
      if (response != null) {
        setState(() {
          fundList = response;
          // fundList = response != null && response.isNotEmpty ? [response[0]] : [];
        });
      }

      EasyLoading.dismiss();
    });
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
        body: SafeArea(
      child: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            //height: 200,
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/dashboardAppbar.jpg'), // Your image asset path
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
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B385B).withOpacity(
                            0.6), // Background color for the IconButton
                        shape: BoxShape.circle, // Make it circular (optional)
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.menu), // Drawer icon
                        color: Colors.white, // Icon color
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuList(),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          logout(context);
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _imageBytes != null
                          ? MemoryImage(_imageBytes!)
                          : const AssetImage('assets/noImage.png')
                              as ImageProvider,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: Text(
                        "Welcome\n${donorinfo?.name ?? '---'}",
                        style: const TextStyle(
                          color: Color(0xFFF5F4F4),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2, // Limits the lines of text
                        overflow: TextOverflow
                            .ellipsis, // Handles overflow with ellipsis (...)
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${donorinfo?.city ?? '---'},${donorinfo?.country ?? '---'}",
                      style: const TextStyle(
                          color: Color(0xFFF5F4F4),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.end,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/adoption.png',
                        height: 44,
                        width: 44,
                      ),
                      const Text(
                        " Beneficiaries",
                        style: TextStyle(
                            color: Color(0xFF467EAD),
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BeneficiaryList(selectedIndex: 0),
                          ),
                        );
                      },
                      child: Container(
                        height: 79,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(
                              5), // Add a circular border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.5), // Add shadow if needed
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes the position of the shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              donorinfo?.noOfAdobted.toString() ?? '---',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF467EAD)),
                            ),
                            const Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF5A5F5C)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BeneficiaryList(selectedIndex: 1),
                          ),
                        );
                      },
                      child: Container(
                        height: 79,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(
                              5), // Add a circular border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.5), // Add shadow if needed
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes the position of the shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              donorinfo?.noOfStudent.toString() ?? '---',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF467EAD)),
                            ),
                            const Text(
                              "Student",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF5A5F5C)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BeneficiaryList(selectedIndex: 2),
                            ),
                          );
                        },
                        child: Container(
                          height: 79,
                          width: MediaQuery.of(context).size.width * 0.28,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(
                                5), // Add a circular border radius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Add shadow if needed
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 3), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                donorinfo?.noOfAlumni.toString() ?? '---',
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF467EAD)),
                              ),
                              const Text(
                                "Alumni",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF5A5F5C)),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 25, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/activeFund.png',
                            height: 44,
                            width: 44,
                          ),
                          const Text(
                            " Active Funds",
                            style: TextStyle(
                                color: Color(0xFF467EAD),
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      TextButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: const Color(0xFF467EAD),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color(0xFF467EAD), width: 1),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Fund(),
                              ),
                            );
                          },
                          child: const Text(
                            "View more",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ))
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // Prevents internal scrolling
                      itemCount: fundList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FundDetail(fundData: fundList[index]),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fundList[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF467EAD),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  fundList[index].fund_type_desc,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF5A5F5C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                    /*   child: GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevents grid scrolling inside another scrollable widget
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      childAspectRatio: 172 / 103,
                    ),
                    itemCount: fundList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FundDetail(fundData: fundList[index]),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  fundList[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF467EAD),
                                  ),
                                ),
                              ),
                              Text(
                                fundList[index].fund_type_desc,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF5A5F5C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                */
                    ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
