import 'package:donor_app/Modules/AlumniProfile/UI/alumni_profile.dart';
import 'package:donor_app/Modules/FundDetail/Model/fundDetail_model.dart';
import 'package:donor_app/Modules/StudentProfile/UI/student_profile.dart';
import 'package:donor_app/Modules/StudentProfile/Utils/std_profile_Helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BeneficiaryList extends StatefulWidget {
  int selectedIndex = 0;
  BeneficiaryList({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  BeneficiaryListState createState() => BeneficiaryListState();
}

class BeneficiaryListState extends State<BeneficiaryList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedIndex = 0;
  List<StudentBasic> allList = [];
  List<StudentBasic> studentList = [];
  List<StudentBasic> alumniList = [];
  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {});
    EasyLoading.show(status: 'loading...');
    setState(() {
      _selectedIndex = widget.selectedIndex;
    });

    if (_selectedIndex == 0) {
      geAllBeneficiary(null).then((response) {
        if (response != null) {
          setState(() {
            allList = response;
          });
        }
        EasyLoading.dismiss();
      });
      EasyLoading.dismiss();
    } else if (_selectedIndex == 1) {
      geAllBeneficiary("enroll").then((response) {
        if (response != null) {
          setState(() {
            studentList = response;
          });
        }

        EasyLoading.dismiss();
      });
    } else if (_selectedIndex == 2) {
      _selectedIndex = 2;
      geAllBeneficiary("alumni").then((response) {
        if (response != null) {
          setState(() {
            alumniList = response;
          });
        }

        EasyLoading.dismiss();
      });
    }
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: _selectedIndex);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        EasyLoading.addStatusCallback((status) {});
        EasyLoading.show(status: 'loading...');
        if (_selectedIndex == 0) {
          _selectedIndex = 0;
          geAllBeneficiary(null).then((response) {
            if (response != null) {
              setState(() {
                allList = response;
              });
            }
            EasyLoading.dismiss();
          });
        } else if (_selectedIndex == 1) {
          _selectedIndex = 1;

          geAllBeneficiary("enroll").then((response) {
            if (response != null) {
              setState(() {
                studentList = response;
              });
            }

            EasyLoading.dismiss();
          });
        } else if (_selectedIndex == 2) {
          _selectedIndex = 2;
          geAllBeneficiary("alumni").then((response) {
            if (response != null) {
              setState(() {
                alumniList = response;
              });
            }

            EasyLoading.dismiss();
          });
        } else {
          EasyLoading.dismiss();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Beneficiaries Info",
            style: TextStyle(
              color: Colors.white, // Text color
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF74AEF1),
                  Color(0xFF8597EF)
                ], // Gradient colors
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        body: DefaultTabController(
          length: 3,
          initialIndex: _selectedIndex,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/activeFund.png',
                      height: 44,
                      width: 44,
                    ),
                    const Text(
                      " Beneficiaries Info",
                      style: TextStyle(
                          color: Color(0xFF467EAD),
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              TabBar(
                  controller: _tabController,
                  onTap: (index) {
                    if (index == 0) {
                      _selectedIndex = 0;
                      geAllBeneficiary(null).then((response) {
                        if (response != null) {
                          setState(() {
                            allList = response;
                          });
                        }
                        EasyLoading.dismiss();
                      });
                    } else if (index == 1) {
                      _selectedIndex = 1;

                      geAllBeneficiary("enroll").then((response) {
                        if (response != null) {
                          setState(() {
                            studentList = response;
                          });
                        }

                        EasyLoading.dismiss();
                      });
                    } else if (index == 2) {
                      _selectedIndex = 2;
                      geAllBeneficiary("alumni").then((response) {
                        if (response != null) {
                          setState(() {
                            alumniList = response;
                          });
                        }

                        EasyLoading.dismiss();
                      });
                    }
                  },
                  dividerColor: const Color(0xFFF0F3F5),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 9),
                  tabs: [
                    Tab(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4E4E7),
                        borderRadius: BorderRadius.circular(25),
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
                      child: const Text(
                        "All",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF5A5F5C)),
                      ),
                    )),
                    Tab(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4E4E7),
                        borderRadius: BorderRadius.circular(25),
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
                      child: const Text(
                        "Students",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF5A5F5C)),
                      ),
                    )),
                    Tab(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4E4E7),
                        borderRadius: BorderRadius.circular(25),
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
                      child: const Text(
                        "Alumni",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF5A5F5C)),
                      ),
                    )),
                  ]),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  allList.isNotEmpty
                      ? ListView.builder(
                          itemCount: allList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                allList[index].status == "Alumni"
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AlumniProfile(
                                            alumni: allList[index],
                                            fundName: "",
                                          ),
                                        ),
                                      )
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => StudentProfile(
                                            studentId:
                                                allList[index].student_id,
                                            fundModel: null,
                                          ),
                                        ),
                                      );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                margin:
                                    const EdgeInsets.fromLTRB(22, 10, 22, 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3)),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            allList[index].student_name,
                                            style: const TextStyle(
                                              color: Color(0xFF5A5F5C),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            allList[index].school_name,
                                            style: const TextStyle(
                                              color: Color(0xffA7A8BB),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    allList[index].status == "Alumni"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Text(
                                                "Graduated In",
                                                style: TextStyle(
                                                  color: Color(0xFF5A5F5C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                allList[index].passing_year,
                                                style: const TextStyle(
                                                  color: Color(0xff7209B7),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                allList[index].current_semester,
                                                style: const TextStyle(
                                                  color: Color(0xffBC1E3D),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              const Text(
                                                "Semester",
                                                style: TextStyle(
                                                  color: Color(0xFF5A5F5C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "No data found",
                              style: TextStyle(
                                color: Color(0xffA7A8BB),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                  studentList.isNotEmpty
                      ? ListView.builder(
                          //physics: const NeverScrollableScrollPhysics(),
                          //shrinkWrap: true,
                          itemCount: studentList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentProfile(
                                      studentId: studentList[index].student_id,
                                      fundModel: null,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                margin:
                                    const EdgeInsets.fromLTRB(22, 10, 22, 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3)),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            studentList[index].student_name,
                                            style: const TextStyle(
                                              color: Color(0xFF5A5F5C),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            studentList[index].school_name,
                                            style: const TextStyle(
                                              color: Color(0xffA7A8BB),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          studentList[index].current_semester,
                                          style: const TextStyle(
                                            color: Color(0xffBC1E3D),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        const Text(
                                          "Semester",
                                          style: TextStyle(
                                            color: Color(0xFF5A5F5C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "No data found",
                              style: TextStyle(
                                color: Color(0xffA7A8BB),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                  alumniList.isNotEmpty
                      ? ListView.builder(
                          //physics: const NeverScrollableScrollPhysics(),
                          //shrinkWrap: true,
                          itemCount: alumniList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlumniProfile(
                                      alumni: alumniList[index],
                                      fundName: "",
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                margin:
                                    const EdgeInsets.fromLTRB(22, 10, 22, 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3)),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            alumniList[index].student_name,
                                            style: const TextStyle(
                                              color: Color(0xFF5A5F5C),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            alumniList[index].school_name,
                                            style: const TextStyle(
                                              color: Color(0xffA7A8BB),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Graduated In",
                                          style: TextStyle(
                                            color: Color(0xFF5A5F5C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          alumniList[index].passing_year,
                                          style: const TextStyle(
                                            color: Color(0xff7209B7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "No data found",
                              style: TextStyle(
                                color: Color(0xffA7A8BB),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                ]),
              )
            ],
          ),
        ));
  }
}
