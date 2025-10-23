import 'package:donor_app/Modules/AlumniProfile/Model/alumniprofile_model.dart';
import 'package:donor_app/Shared/Utils/GeneralFuncation.dart';
import 'package:flutter/material.dart';

class AlumniJob extends StatefulWidget {
  AlumniInfo? student_code;
  AlumniJob({Key? key, this.student_code}) : super(key: key);

  @override
  AlumniJobeState createState() => AlumniJobeState();
}

class AlumniJobeState extends State<AlumniJob> {
  late AlumniInfo? alumniDetail;
  String fundName = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      alumniDetail = widget.student_code;
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
            "Employment History",
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
        body: ListView.builder(
            shrinkWrap:
                true, // Ensures that the inner ListView uses only as much space as necessary
            //physics: const NeverScrollableScrollPhysics(),
            itemCount: alumniDetail?.employmentList!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius:
                      BorderRadius.circular(5), // Add a circular border radius
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.grey.withOpacity(0.5), // Add shadow if needed
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(
                          0, 3), // changes the position of the shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // height: 73,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.center,
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
                                  (alumniDetail!.employmentList![index]
                                          .currentOrganiztion.isNotEmpty)
                                      ? alumniDetail!.employmentList![index]
                                          .currentOrganiztion
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
                    ),
                    Container(
                      // height: 73,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.center,
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Designation/Position",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF545463)),
                                ),
                                Text(
                                  (alumniDetail!.employmentList![index]
                                          .currentDesignation.isNotEmpty)
                                      ? alumniDetail!.employmentList![index]
                                          .currentDesignation
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
                    ),
                    Container(
                      //height: 73,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.center,
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
                                  "Duration",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF545463)),
                                ),
                                Text(
                                  "${(alumniDetail!.employmentList![index].dtmFrom.isNotEmpty) ? getDateFormate(alumniDetail!.employmentList![index].dtmFrom) : '---'},${(alumniDetail!.employmentList![index].dtmTo.isNotEmpty) ? getDateFormate(alumniDetail!.employmentList![index].dtmTo) : '---'}",
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
                  ],
                ),
              );
            }));
  }
}
