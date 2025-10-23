import 'dart:typed_data';

import 'package:donor_app/Modules/StudentProfile/Model/std_profile_model.dart';
import 'package:donor_app/Modules/StudentProfile/Utils/std_profile_Helper.dart';
import 'package:flutter/material.dart';

class StudentTranscript extends StatefulWidget {
  StudentModel studentInfo;
  Uint8List? imageBytes;
  StudentTranscript(
      {Key? key, required this.studentInfo, required this.imageBytes})
      : super(key: key);

  @override
  StudentTranscriptState createState() => StudentTranscriptState();
}

class StudentTranscriptState extends State<StudentTranscript> {
  List<TranscriptModel> transcriptList = [];
  late StudentModel studentInfo;
  late Uint8List? imageBytes;
  List<ChartData> chartDataList = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      studentInfo = widget.studentInfo;
      imageBytes = widget.imageBytes;
    });
    getStudentTranscript(studentInfo.student_id).then((response) {
      setState(() {
        transcriptList = response!;
      });
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
          "Academic Detail",
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
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.blue,
                        backgroundImage: imageBytes != null
                            ? MemoryImage(imageBytes!)
                            : null,
                        child: imageBytes == null
                            ? Text(
                                studentInfo.student_name != null
                                    ? studentInfo.student_name[0].toUpperCase()
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
                            studentInfo.student_name ?? '---',
                            style: const TextStyle(
                                color: Color(0xFF467EAD),
                                fontWeight: FontWeight.w600,
                                fontSize: 24),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            studentInfo.school_name ?? '---',
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
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    studentInfo.current_program,
                    style: const TextStyle(
                        color: Color(0xFF467EAD),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transcriptList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                            margin: const EdgeInsets.fromLTRB(5, 15, 5, 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF467EAD),
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
                            child: Text(
                              transcriptList[index].term_name,
                              style: const TextStyle(
                                  color: Color(0xFFF5F4F4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
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
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xFFE4E4E7), // Line color
                                        width: 1.0, // Line thickness
                                      ),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Course Title",
                                        style: TextStyle(
                                            color: Color(0xFF5A5F5C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Grade",
                                        style: TextStyle(
                                            color: Color(0xFF43A047),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: transcriptList[index]
                                          .subjects!
                                          .length,
                                      itemBuilder: (context, index2) {
                                        return Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 11,
                                                child: Text(
                                                  transcriptList[index]
                                                      .subjects![index2]
                                                      .course_name,
                                                  style: const TextStyle(
                                                      color: Color(0xFF5A5F5C),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    transcriptList[index]
                                                        .subjects![index2]
                                                        .grade,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF467EAD),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
