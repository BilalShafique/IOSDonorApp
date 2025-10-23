import 'dart:typed_data';

import 'package:donor_app/Modules/Dashboard/Model/home_model.dart';
import 'package:donor_app/Modules/StudentProfile/Model/std_profile_model.dart';
import 'package:donor_app/Modules/StudentProfile/UI/student_transcript.dart';
import 'package:donor_app/Modules/StudentProfile/Utils/std_profile_Helper.dart';
import 'package:donor_app/Shared/Utils/SessionMangement.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class StudentProfile extends StatefulWidget {
  int studentId = 0;
  DonorFund? fundModel;
  StudentProfile({Key? key, required this.studentId, required this.fundModel})
      : super(key: key);

  @override
  StudentProfileState createState() => StudentProfileState();
}

class StudentProfileState extends State<StudentProfile> {
  StudentModel? studentInfo;
  int studentId = 0;
  List<ChartData> chartDataList = [];
  Uint8List? _imageBytes;
  DonorFund? fundModel;
  @override
  void initState() {
    super.initState();
    setState(() {
      studentId = widget.studentId;
      if (widget.fundModel != null) {
        fundModel = widget.fundModel!;
      }
    });
    getStudentDetail(studentId).then((response) {
      setState(() {
        studentInfo = response!;
        chartDataList = studentInfo!.cgpa_list!
            .map((data) => ChartData(data.code, data.cgpa))
            .toList();
        if (studentInfo!.student_pic.isNotEmpty) {
          _fetchImage(studentInfo!.student_pic);
        }
      });
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Beneficiary Profile",
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
            gradient: LinearGradient(
              colors: [Color(0xFF43A047), Color(0xFF67D56C)], // Gradient colors
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fundModel != null
                    ? Container(
                        alignment: Alignment.center,
                        child: Text(
                          fundModel!.name,
                          style: const TextStyle(
                              color: Color(0xFF467EAD),
                              fontWeight: FontWeight.w600,
                              fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(),
                fundModel != null
                    ? Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${fundModel!.fund_type_desc} (PKR)",
                          style: const TextStyle(
                              color: Color(0xFF5A5F5C),
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.blue,
                        backgroundImage: _imageBytes != null
                            ? MemoryImage(_imageBytes!)
                            : null,
                        child: _imageBytes == null
                            ? Text(
                                studentInfo?.student_name != null
                                    ? studentInfo!.student_name[0].toUpperCase()
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
                            studentInfo?.student_name ?? '---',
                            style: const TextStyle(
                                color: Color(0xFF467EAD),
                                fontWeight: FontWeight.w600,
                                fontSize: 24),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            studentInfo?.school_name ?? '---',
                            style: const TextStyle(
                                color: Color(0xFF5A5F5C),
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 75,
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
                            const Text(
                              "Current Semester",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF5A5F5C)),
                            ),
                            Text(
                              studentInfo?.current_semester ?? '---',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF5A5F5C)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        height: 75,
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
                            const Text(
                              "CGPA",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF5A5F5C)),
                            ),
                            Text(
                              studentInfo?.curr_cgpa.toString() ?? '---',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF5A5F5C)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 40),
                      child: const Text(
                        "Academic Info",
                        style: TextStyle(
                            color: Color(0xFF467EAD),
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: const Color(0xFF467EAD),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color(0xFF467EAD), width: 1),
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentTranscript(
                                    studentInfo: studentInfo!,
                                    imageBytes: _imageBytes),
                              ),
                            );
                          },
                          child: const Text(
                            "View Transcript",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )),
                    ),
                  ],
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
                                  "Intake / Batch",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF545463)),
                                ),
                                Text(
                                  studentInfo?.batch_id ?? '---',
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
                                'assets/degree.png',
                                width: 44,
                                height: 44,
                              ),
                            ),
                            Expanded(
                              child: Column(
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
                                    studentInfo?.current_program ?? '---',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF545463)),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
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
                ),
                Container(
                  child: const Text(
                    "Semester Progress",
                    style: TextStyle(
                        color: Color(0xFF467EAD),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    labelStyle: const TextStyle(fontSize: 9),
                  ),
                  primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: 4,
                    labelFormat:
                        '{value}', // Default label format, but we'll handle in data labels
                  ),
                  title: ChartTitle(
                      text: '',
                      textStyle: const TextStyle(
                        color: Color(0xFF467EAD),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      alignment: ChartAlignment.near),
                  legend: const Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    ColumnSeries<ChartData, String>(
                        dataSource: chartDataList,
                        xValueMapper: (ChartData obj, _) => obj.x,
                        yValueMapper: (ChartData obj, _) => obj.y,
                        pointColorMapper: (ChartData data, _) {
                          return null;
                        },
                        name: 'Semester Progress',
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.top,
                          textStyle: TextStyle(fontSize: 12),
                        ),
                        width: chartDataList.length > 5 ? 0.8 : 0.4),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  child: const Text(
                    "General Info",
                    style: TextStyle(
                        color: Color(0xFF467EAD),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (studentInfo?.father_prof != null &&
                    studentInfo!.father_prof.isNotEmpty)
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
                            'assets/adoption.png',
                            width: 36,
                            height: 36,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Father / Guardian Profession",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF545463)),
                              ),
                              Text(
                                studentInfo?.father_prof.isEmpty ?? true
                                    ? '---'
                                    : studentInfo!.father_prof,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF545463)),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (studentInfo?.father_income != null &&
                    studentInfo!.father_income == 0)
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
                            'assets/activeFund.png',
                            width: 36,
                            height: 36,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Family Monthly Income",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF545463)),
                            ),
                            Text(
                              NumberFormat.decimalPattern().format(
                                  (studentInfo?.father_income ?? 0.0).round()),
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
                  height: 20,
                ),
                if (studentInfo?.city != null && studentInfo!.city.isNotEmpty)
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
                            'assets/location.png',
                            width: 36,
                            height: 36,
                          ),
                        ),
                        Expanded(
                          child: Column(
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
                                studentInfo?.city ?? '---',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF545463)),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
