import 'package:donor_app/Modules/AlumniProfile/Model/alumniprofile_model.dart';
import 'package:donor_app/Modules/AlumniProfile/UI/alumni_jobs.dart';
import 'package:donor_app/Modules/AlumniProfile/Utils/alumniDataHelper.dart';

import 'package:donor_app/Modules/FundDetail/Model/fundDetail_model.dart';
import 'package:flutter/material.dart';

class AlumniProfile extends StatefulWidget {
  StudentBasic alumni;
  String fundName = "";
  AlumniProfile({Key? key, required this.alumni, required this.fundName})
      : super(key: key);

  @override
  AlumniProfileState createState() => AlumniProfileState();
}

class AlumniProfileState extends State<AlumniProfile> {
  late StudentBasic _alumni;
  String fundName = "";
  AlumniInfo? studentInfo;
  @override
  void initState() {
    super.initState();
    setState(() {
      _alumni = widget.alumni;
      fundName = widget.fundName;
    });
    getAlumniDetail(_alumni.student_code).then((response) {
      if (response != null) {
        setState(() {
          studentInfo = response;
          if (response.employmentList != null &&
              response.employmentList!.isNotEmpty) {
            var currentEmployments = response.employmentList!
                .where((project) => project.bCurrentWorking == 1)
                .toList();

            if (currentEmployments.isNotEmpty) {
              var currentEmployment = currentEmployments.first;
              studentInfo!.currentDesignation =
                  currentEmployment.currentDesignation;
              studentInfo!.currentIndustry = currentEmployment.currentIndustry;
              studentInfo!.currentOrganiztion =
                  currentEmployment.currentOrganiztion;
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Funds Graduates",
            style: TextStyle(
              color: Colors.white, // Text color
            ),
          ),
          // Back button (default or manually added)
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white, // Back button color
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/BeneficiaryHeader.jpg'), // Your image asset path
                fit: BoxFit.cover, // Make the image cover the entire AppBar
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.blue,
                        backgroundImage: studentInfo?.photo != null &&
                                studentInfo!.photo.isNotEmpty
                            ? NetworkImage(studentInfo!.photo)
                            : null,
                        child: studentInfo?.photo == null ||
                                studentInfo!.photo.isEmpty
                            ? Text(
                                studentInfo?.photo != null
                                    ? studentInfo!.name[0].toUpperCase()
                                    : '---',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (_alumni.student_name.isNotEmpty)
                                ? _alumni.student_name
                                : '---',
                            style: const TextStyle(
                                color: Color(0xFF467EAD),
                                fontWeight: FontWeight.w600,
                                fontSize: 24),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            (_alumni.school_name.isNotEmpty)
                                ? _alumni.school_name
                                : '---',
                            style: const TextStyle(
                                color: Color(0xFF5A5F5C),
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                fundName != ""
                    ? Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: const Text(
                          "Scholarship Info",
                          style: TextStyle(
                              color: Color(0xFF467EAD),
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    : Container(),
                fundName != ""
                    ? Container(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(
                                    5), // Add a circular border radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.5), // Add shadow if needed
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0,
                                        3), // changes the position of the shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                      'assets/fundGraduate.png',
                                      width: 36,
                                      height: 36,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Scholarship Fund Name",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF545463)),
                                        ),
                                        Text(
                                          fundName,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF545463)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Current Employment",
                        style: TextStyle(
                            color: Color(0xFF467EAD),
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      studentInfo != null
                          ? TextButton(
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
                                    builder: (context) => AlumniJob(
                                      student_code: studentInfo!,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "View all jobs",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ))
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                studentInfo == null
                    ? Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15),
                        child: const Column(
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
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 10,
                ),
                studentInfo != null
                    ? Container(
                        // height: 73,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.center,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/organization.png',
                                width: 36,
                                height: 36,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Company / Organization",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF545463)),
                                  ),
                                  Text(
                                    (studentInfo?.currentOrganiztion
                                                .isNotEmpty ??
                                            false)
                                        ? studentInfo!.currentOrganiztion
                                        : '---',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF545463)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                studentInfo != null
                    ? const SizedBox(
                        height: 20,
                      )
                    : const SizedBox.shrink(),
                studentInfo != null
                    ? Container(
                        //height: 73,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.center,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/sector.png',
                                width: 36,
                                height: 36,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Industry / Sector",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF545463)),
                                ),
                                Text(
                                  (studentInfo?.currentIndustry.isNotEmpty ??
                                          false)
                                      ? studentInfo!.currentIndustry
                                      : '---',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF545463)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                studentInfo != null
                    ? const SizedBox(
                        height: 20,
                      )
                    : const SizedBox.shrink(),
                studentInfo != null
                    ? Container(
                        height: 73,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.center,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/location.png',
                                width: 36,
                                height: 36,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "City",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF545463)),
                                ),
                                Text(
                                  "${(studentInfo?.city.isNotEmpty ?? false) ? studentInfo!.city : '---'},${(studentInfo?.country.isNotEmpty ?? false) ? studentInfo!.country : '---'}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF545463)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                studentInfo != null
                    ? const SizedBox(
                        height: 20,
                      )
                    : const SizedBox.shrink(),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Award & Achievement",
                    style: TextStyle(
                        color: Color(0xFF467EAD),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                studentInfo != null && studentInfo!.achievementList!.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: studentInfo!.achievementList!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.only(bottom: 5),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      studentInfo!
                                          .achievementList![index].sTitle,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF545463)),
                                    ),
                                    Text(
                                      studentInfo!
                                          .achievementList![index].sDescription,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF545463)),
                                    ),
                                  ],
                                ),
                                /* child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Expanded(
                                      child: Text(
                                        studentInfo!
                                            .achievementList![index].sTitle,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF545463)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        studentInfo!.achievementList![index]
                                            .sDescription,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF545463)),
                                      ),
                                    ),
                                  ],
                                ), */
                              );
                            }))
                    : Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15),
                        child: const Column(
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
                      ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Academic Info",
                    style: TextStyle(
                        color: Color(0xFF467EAD),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 73,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.center,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/batch.png',
                                width: 36,
                                height: 36,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Graduated On",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF545463)),
                                ),
                                Text(
                                  (_alumni.passing_year.isNotEmpty)
                                      ? _alumni.passing_year
                                      : '---',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF545463)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 73,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.center,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/batch.png',
                                width: 36,
                                height: 36,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Intake / Batch",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF545463)),
                                ),
                                Text(
                                  (studentInfo?.batch.isNotEmpty ?? false)
                                      ? studentInfo!.batch
                                      : '---',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF545463)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        // height: 73,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.center,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/degree.png',
                                width: 44,
                                height: 44,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Degree / Discipline",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF545463)),
                                ),
                                Text(
                                  (studentInfo?.discipline_long.isNotEmpty ??
                                          false)
                                      ? studentInfo!.discipline_long
                                      : '---',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF545463)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
