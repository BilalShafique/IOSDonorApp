import 'package:donor_app/Modules/AlumniProfile/UI/alumni_profile.dart';
import 'package:donor_app/Modules/Dashboard/Model/home_model.dart';
import 'package:donor_app/Modules/FundDetail/Model/fundDetail_model.dart';
import 'package:donor_app/Modules/FundDetail/Utils/fundDetailDataHelper.dart';
import 'package:donor_app/Modules/Pledge/UI/PledgeDetail.dart';
import 'package:donor_app/Modules/StudentProfile/UI/student_profile.dart';
import 'package:donor_app/Modules/Transation/UI/transation.dart';

import 'package:donor_app/Shared/Utils/GeneralFuncation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class FundDetail extends StatefulWidget {
  DonorFund fundData;

  FundDetail({Key? key, required this.fundData}) : super(key: key);

  @override
  FundDetailState createState() => FundDetailState();
}

class FundDetailState extends State<FundDetail>
    with SingleTickerProviderStateMixin {
  late DonorFund fundModel;
  int _selectedIndex = 0;
  late TabController _tabController;
  List<StudentBasic> studentList = [];
  List<StudentBasic> alumniList = [];
  List<FypDetail> fypList = [];
  List<Pledge> pledgeList = [];
  List<TransactionList> transactionList = [];

  final currentYear = DateTime.now().year;
  @override
  void initState() {
    super.initState();
    setState(() {
      fundModel = widget.fundData;
    });
    EasyLoading.show(status: 'loading...');
    getFundFyp(fundModel.id).then((response) {
      setState(() {
        fypList = response!;
      });
      EasyLoading.dismiss();
    });
    getFundBeneficiary(fundModel.id).then((response) {
      if (response != null) {
        setState(() {
          studentList = response;
        });
      }

      EasyLoading.dismiss();
    });

    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        EasyLoading.addStatusCallback((status) {});
        EasyLoading.show(status: 'loading...');
        if (_selectedIndex == 0) {
          _selectedIndex = 0;
          getFundBeneficiary(fundModel.id).then((response) {
            if (response != null) {
              setState(() {
                studentList = response;
              });
            }
            EasyLoading.dismiss();
          });
        } else if (_selectedIndex == 1) {
          _selectedIndex = 1;
          getFundAlumni(fundModel.id).then((response) {
            if (response != null) {
              setState(() {
                alumniList = response;
              });
            }
            EasyLoading.dismiss();
          });
        } else if (_selectedIndex == 2) {
          _selectedIndex = 2;
          getFundPledges(fundModel.id).then((response) {
            if (response != null) {
              setState(() {
                pledgeList = response;
              });
            }
            EasyLoading.dismiss();
          });
        } else if (_selectedIndex == 3) {
          _selectedIndex = 2;
          getFundTransation(fundModel.id).then((response) {
            if (response != null) {
              setState(() {
                transactionList = response;
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Fund Overview",
              style: TextStyle(
                color: Colors.white, // Text color
              ),
            ),
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
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.home,
                  size: 35,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              fundModel.name,
                              style: const TextStyle(
                                  color: Color(0xFF467EAD),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${fundModel.fund_type_desc} (PKR)",
                              style: const TextStyle(
                                  color: Color(0xFF5A5F5C),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          fundModel.is_report == false
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "$currentYear FY Report",
                                    style: const TextStyle(
                                        color: Color(0xFF5A5F5C),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          Container(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 75,
                                    padding: const EdgeInsets.all(10),
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Created on",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF5A5F5C)),
                                          textAlign: TextAlign.end,
                                        ),
                                        Text(
                                          getDateFormate(
                                              fundModel.fund_creation_date),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF467EAD)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                fundModel.is_report == true
                                    ? Expanded(
                                        child: Container(
                                        height: 75,
                                        padding: const EdgeInsets.all(10),
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
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Text(
                                              "Initial Fund",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF5A5F5C)),
                                            ),
                                            Text(
                                              NumberFormat.decimalPattern()
                                                  .format(double.parse(fundModel
                                                          .funding_amount)
                                                      .round()),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF43A047)),
                                            ),
                                          ],
                                        ),
                                      ))
                                    : Expanded(
                                        child: Container(
                                        height: 75,
                                        padding: const EdgeInsets.all(10),
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
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Text(
                                              "Fund Received",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF5A5F5C)),
                                            ),
                                            Text(
                                              NumberFormat.decimalPattern()
                                                  .format(fundModel
                                                      .received_amount),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF43A047)),
                                            ),
                                          ],
                                        ),
                                      ))
                              ],
                            ),
                          ),
                          fundModel.is_report == true
                              ? Container(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 75,
                                          padding: const EdgeInsets.all(10),
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
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Text(
                                                "Last Year Balance",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFF5A5F5C)),
                                                textAlign: TextAlign.end,
                                              ),
                                              Text(
                                                NumberFormat.decimalPattern()
                                                    .format(fundModel
                                                        .closing_fund
                                                        .round()),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFBC1E3D)),
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
                                        padding: const EdgeInsets.all(10),
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
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Text(
                                              "Current Fund",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF5A5F5C)),
                                            ),
                                            Text(
                                              NumberFormat.decimalPattern()
                                                  .format(fundModel.closing_fund
                                                      .round()),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF43A047)),
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                          fundModel.is_report == true
                              ? ListView.builder(
                                  shrinkWrap:
                                      true, // Ensures that the inner ListView uses only as much space as necessary
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: fypList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
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
                                      child: ExpansionTile(
                                        shape: const Border(),
                                        backgroundColor:
                                            const Color(0xFFFFFFFF),
                                        collapsedBackgroundColor:
                                            const Color(0xFFFFFFFF),
                                        title: Text(
                                          'Financial Details for FY ${getLastTwoDigitsOfYear(fypList[index].fiscal_year_start)}/ ${getLastTwoDigitsOfYear(fypList[index].fiscal_year_end)} (PKR)',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF467EAD)),
                                        ),
                                        subtitle: Text(
                                          'Fund Position Till  ${getDateFormate(fypList[index].fiscal_year_end)}',
                                          style: const TextStyle(
                                              color: Color(0xffb545463)),
                                        ),
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors
                                                  .white, // Background color for the ListTile container
                                              border: Border(
                                                top: BorderSide(
                                                    color: Color(0xFF5A5F5C),
                                                    width: 0.2), // Top border
                                                bottom: BorderSide(
                                                    color: Color(0xFF5A5F5C),
                                                    width:
                                                        0.2), // Bottom border
                                              ),
                                            ),
                                            child: ListTile(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Expanded(
                                                    child: Text(
                                                      'Donation Received',
                                                      maxLines:
                                                          2, // Allows text to wrap to the next line if needed
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                              0xFF5A5F5C)),
                                                    ),
                                                  ),
                                                  Text(
                                                      NumberFormat
                                                              .decimalPattern()
                                                          .format(fypList[index]
                                                              .donation_received
                                                              .round()),
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xFF43A047))),
                                                ],
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'Income During FY',
                                                    maxLines:
                                                        2, // Allows text to wrap to the next line if needed
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xffb545463)),
                                                  ),
                                                ),
                                                Text(
                                                    NumberFormat
                                                            .decimalPattern()
                                                        .format(fypList[index]
                                                            .income_during_fy
                                                            .round()),
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        fontSize: 16)),
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'Shared Service Cost',
                                                    maxLines:
                                                        2, // Allows text to wrap to the next line if needed
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xffb545463)),
                                                  ),
                                                ),
                                                Text(
                                                    "(${NumberFormat.decimalPattern().format(fypList[index].shared_service_cost.abs().round())})",
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xFFBC1E3D))),
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'Scholarship Paid',
                                                    maxLines:
                                                        2, // Allows text to wrap to the next line if needed
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xffb545463)),
                                                  ),
                                                ),
                                                Text(
                                                    "(${NumberFormat.decimalPattern().format(fypList[index].scholarship_paid.abs().round())})",
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xFFBC1E3D))),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors
                                                  .white, // Background color for the ListTile container
                                              border: Border(
                                                top: BorderSide(
                                                    color: Color(0xFF5A5F5C),
                                                    width: 0.2), // Top border
                                                bottom: BorderSide(
                                                    color: Color(0xFF5A5F5C),
                                                    width:
                                                        0.2), // Bottom border
                                              ),
                                            ),
                                            child: ListTile(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      fypList[index]
                                                                  .net_surplus <
                                                              0
                                                          ? 'Net Deficit'
                                                          : 'Net Surplus',
                                                      maxLines:
                                                          2, // Allows text to wrap to the next line if needed
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: fypList[index]
                                                                    .net_surplus <
                                                                0
                                                            ? const Color(
                                                                0xFFBC1E3D)
                                                            : const Color(
                                                                0xFF43A047),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                      fypList[index]
                                                                  .net_surplus <
                                                              0
                                                          ? '(${NumberFormat.decimalPattern().format(fypList[index].net_surplus.abs().round())})'
                                                          : NumberFormat
                                                                  .decimalPattern()
                                                              .format(fypList[
                                                                      index]
                                                                  .net_surplus
                                                                  .round()),
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: fypList[index]
                                                                    .net_surplus <
                                                                0
                                                            ? const Color(
                                                                0xFFBC1E3D)
                                                            : const Color(
                                                                0xFF43A047),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors
                                                  .white, // Background color for the ListTile container
                                              border: Border(
                                                top: BorderSide(
                                                    color: Color(0xFF5A5F5C),
                                                    width: 0.2), // Top border
                                                bottom: BorderSide(
                                                    color: Color(0xFF5A5F5C),
                                                    width:
                                                        0.2), // Bottom border
                                              ),
                                            ),
                                            child: ListTile(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Expanded(
                                                    child: Text(
                                                      'Balance after surplus/(deficit)',
                                                      maxLines:
                                                          2, // Allows text to wrap to the next line if needed
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                      NumberFormat
                                                              .decimalPattern()
                                                          .format(fypList[index]
                                                              .deficit
                                                              .round()),
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'Closing Fund',
                                                    maxLines:
                                                        2, // Allows text to wrap to the next line if needed
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xFF467EAD)),
                                                  ),
                                                ),
                                                Text(
                                                  NumberFormat.decimalPattern()
                                                      .format(fypList[index]
                                                          .closing_fund
                                                          .round()),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xFF467EAD)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                              : const SizedBox.shrink(),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                            child: const Text(
                              " Beneficiary",
                              style: TextStyle(
                                  color: Color(0xFF5A5F5C),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 79,
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        fundModel.adopted_students,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF467EAD)),
                                      ),
                                      const Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
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
                                  height: 79,
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        fundModel.active_students,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF467EAD)),
                                      ),
                                      const Text(
                                        "Student",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
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
                                height: 79,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      fundModel.alumni_students,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF467EAD)),
                                    ),
                                    const Text(
                                      "Alumni",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF5A5F5C)),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 20, 15, 15),
                            child: const Text(
                              " Fund Information",
                              style: TextStyle(
                                  color: Color(0xFF5A5F5C),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ]),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _TabBarDelegate(
                    TabBar(
                      controller: _tabController,
                      dividerColor: const Color(0xFFF0F3F5),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 9),
                      tabs: <Widget>[
                        Tab(
                            height: MediaQuery.of(context).size.height * 0.085,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/adoption.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const Text(
                                    "Beneficiary",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF5A5F5C)),
                                  ),
                                ],
                              ),
                            )),
                        Tab(
                            height: MediaQuery.of(context).size.height * 0.085,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(5),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/alumni.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const Text(
                                    "Alumni",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF5A5F5C)),
                                  ),
                                ],
                              ),
                            )),
                        Tab(
                            height: MediaQuery.of(context).size.height * 0.085,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/tansaction.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const Text(
                                    "Pledges",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF5A5F5C)),
                                  ),
                                ],
                              ),
                            )),
                        Tab(
                            height: MediaQuery.of(context).size.height * 0.085,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/activeFund.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const Text(
                                    "Transaction",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF5A5F5C)),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: Container(
              margin: const EdgeInsets.only(top: 20),
              child: TabBarView(
                controller: _tabController,
                children: [
                  studentList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          //  shrinkWrap: true,
                          itemCount: studentList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentProfile(
                                        studentId:
                                            studentList[index].student_id,
                                        fundModel: fundModel),
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
                          physics: const NeverScrollableScrollPhysics(),
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
                                      fundName: fundModel.name,
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
                  pledgeList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          //shrinkWrap: true,
                          itemCount: pledgeList[0].pledgeCycleList!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PledgeDetail(
                                      pledgeModel:
                                          pledgeList[0].pledgeCycleList![index],
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
                                      offset: const Offset(0, 3),
                                    ),
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
                                          const Text(
                                            "Pledge Date",
                                            style: TextStyle(
                                              color: Color(0xFF5A5F5C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            NumberFormat.decimalPattern()
                                                .format(double.parse(pledgeList[
                                                            0]
                                                        .pledgeCycleList![index]
                                                        .total_amount)
                                                    .round()),
                                            style: const TextStyle(
                                              color: Color(0xFF5A5F5C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
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
                                          getDateFormate(pledgeList[0]
                                              .pledgeCycleList![index]
                                              .amount_due_date),
                                          style: const TextStyle(
                                            color: Color(0xff43A047),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        const Text(
                                          "Pledge Amount",
                                          style: TextStyle(
                                            color: Color(0xFF5A5F5C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
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
                  transactionList.isNotEmpty
                      ? ListView.builder(
                          itemCount: transactionList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TransationDetail(
                                        transactionModel:
                                            transactionList[index],
                                        fundData: fundModel),
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
                                      offset: const Offset(0, 3),
                                    ),
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
                                            transactionList[index]
                                                .transaction!
                                                .receipt_number,
                                            style: const TextStyle(
                                              color: Color(0xFF5A5F5C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            getDateFormate(
                                                transactionList[index]
                                                    .transaction!
                                                    .transaction_date),
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
                                          NumberFormat.decimalPattern().format(
                                              transactionList[index]
                                                  .transactionDetail!
                                                  .assigned_amount
                                                  .round()),
                                          style: const TextStyle(
                                            color: Color(0xffBC1E3D),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          transactionList[index]
                                              .transaction!
                                              .mode
                                              .toString(),
                                          style: const TextStyle(
                                            color: Color(0xFF5A5F5C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
    /*    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fund Overview",
          style: TextStyle(
            color: Colors.white, // Text color
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // Back button color
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
            );
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/fundAppbar.jpg'), // Your image asset path
              fit: BoxFit.cover, // Make the image cover the entire AppBar
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home,
              size: 35,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavBar(),
                ),
              );
            },
          ),
        ],
      ),
      body: DefaultTabController(
          length: 4,
          initialIndex: _selectedIndex,
          child: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          fundModel.name,
                          style: const TextStyle(
                              color: Color(0xFF467EAD),
                              fontWeight: FontWeight.w600,
                              fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${fundModel.fund_type_desc} (PKR)",
                          style: const TextStyle(
                              color: Color(0xFF5A5F5C),
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      fundModel.is_report == false
                          ? Container(
                              alignment: Alignment.center,
                              child: Text(
                                "$currentYear FY Report",
                                style: const TextStyle(
                                    color: Color(0xFF5A5F5C),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Container(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 75,
                                padding: const EdgeInsets.all(10),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Created on",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF5A5F5C)),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      getDateFormate(
                                          fundModel.fund_creation_date),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF467EAD)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            fundModel.is_report == true
                                ? Expanded(
                                    child: Container(
                                    height: 75,
                                    padding: const EdgeInsets.all(10),
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Initial Fund",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF5A5F5C)),
                                        ),
                                        Text(
                                          NumberFormat.decimalPattern().format(
                                              double.parse(
                                                      fundModel.funding_amount)
                                                  .round()),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF43A047)),
                                        ),
                                      ],
                                    ),
                                  ))
                                : Expanded(
                                    child: Container(
                                    height: 75,
                                    padding: const EdgeInsets.all(10),
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
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Fund Received",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF5A5F5C)),
                                        ),
                                        Text(
                                          '---',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF43A047)),
                                        ),
                                      ],
                                    ),
                                  ))
                          ],
                        ),
                      ),
                      fundModel.is_report == true
                          ? Container(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 75,
                                      padding: const EdgeInsets.all(10),
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text(
                                            "Last Year Balance",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF5A5F5C)),
                                            textAlign: TextAlign.end,
                                          ),
                                          Text(
                                            NumberFormat.decimalPattern()
                                                .format(fundModel.closing_fund
                                                    .round()),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFFBC1E3D)),
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
                                    padding: const EdgeInsets.all(10),
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Current Fund",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF5A5F5C)),
                                        ),
                                        Text(
                                          NumberFormat.decimalPattern().format(
                                              fundModel.closing_fund.round()),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF43A047)),
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      fundModel.is_report == true
                          ? ListView.builder(
                              shrinkWrap:
                                  true, // Ensures that the inner ListView uses only as much space as necessary
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: fypList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
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
                                  child: ExpansionTile(
                                    shape: const Border(),
                                    backgroundColor: const Color(0xFFFFFFFF),
                                    collapsedBackgroundColor:
                                        const Color(0xFFFFFFFF),
                                    title: Text(
                                      'Financial Details for FY ${getLastTwoDigitsOfYear(fypList[index].fiscal_year_start)}/ ${getLastTwoDigitsOfYear(fypList[index].fiscal_year_end)} (PKR)',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF467EAD)),
                                    ),
                                    subtitle: Text(
                                      'Fund Position Till  ${getDateFormate(fypList[index].fiscal_year_end)}',
                                      style: const TextStyle(
                                          color: Color(0xffb545463)),
                                    ),
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors
                                              .white, // Background color for the ListTile container
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0xFF5A5F5C),
                                                width: 0.2), // Top border
                                            bottom: BorderSide(
                                                color: Color(0xFF5A5F5C),
                                                width: 0.2), // Bottom border
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Expanded(
                                                child: Text(
                                                  'Donation Received',
                                                  maxLines:
                                                      2, // Allows text to wrap to the next line if needed
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xFF5A5F5C)),
                                                ),
                                              ),
                                              Text(
                                                  NumberFormat.decimalPattern()
                                                      .format(fypList[index]
                                                          .donation_received
                                                          .round()),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          Color(0xFF43A047))),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Income During FY',
                                                maxLines:
                                                    2, // Allows text to wrap to the next line if needed
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xffb545463)),
                                              ),
                                            ),
                                            Text(
                                                NumberFormat.decimalPattern()
                                                    .format(fypList[index]
                                                        .income_during_fy
                                                        .round()),
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Shared Service Cost',
                                                maxLines:
                                                    2, // Allows text to wrap to the next line if needed
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xffb545463)),
                                              ),
                                            ),
                                            Text(
                                                "(${NumberFormat.decimalPattern().format(fypList[index].shared_service_cost.abs().round())})",
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFFBC1E3D))),
                                          ],
                                        ),
                                      ),
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Scholarship Paid',
                                                maxLines:
                                                    2, // Allows text to wrap to the next line if needed
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xffb545463)),
                                              ),
                                            ),
                                            Text(
                                                "(${NumberFormat.decimalPattern().format(fypList[index].scholarship_paid.abs().round())})",
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFFBC1E3D))),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors
                                              .white, // Background color for the ListTile container
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0xFF5A5F5C),
                                                width: 0.2), // Top border
                                            bottom: BorderSide(
                                                color: Color(0xFF5A5F5C),
                                                width: 0.2), // Bottom border
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Expanded(
                                                child: Text(
                                                  'Net Surplus',
                                                  maxLines:
                                                      2, // Allows text to wrap to the next line if needed
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xFF43A047)),
                                                ),
                                              ),
                                              Text(
                                                  NumberFormat.decimalPattern()
                                                      .format(fypList[index]
                                                          .net_surplus
                                                          .round()),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          Color(0xFF43A047))),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors
                                              .white, // Background color for the ListTile container
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0xFF5A5F5C),
                                                width: 0.2), // Top border
                                            bottom: BorderSide(
                                                color: Color(0xFF5A5F5C),
                                                width: 0.2), // Bottom border
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Expanded(
                                                child: Text(
                                                  'Balance after surplus/(deficit)',
                                                  maxLines:
                                                      2, // Allows text to wrap to the next line if needed
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                  NumberFormat.decimalPattern()
                                                      .format(fypList[index]
                                                          .deficit
                                                          .round()),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Closing Fund',
                                                maxLines:
                                                    2, // Allows text to wrap to the next line if needed
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF467EAD)),
                                              ),
                                            ),
                                            Text(
                                              NumberFormat.decimalPattern()
                                                  .format(fypList[index]
                                                      .closing_fund
                                                      .round()),
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF467EAD)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : const SizedBox.shrink(),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 40, 15, 15),
                        child: const Text(
                          " Beneficiary",
                          style: TextStyle(
                              color: Color(0xFF5A5F5C),
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 79,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    fundModel.adopted_students,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF467EAD)),
                                  ),
                                  const Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
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
                              height: 79,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    fundModel.active_students,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF467EAD)),
                                  ),
                                  const Text(
                                    "Student",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
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
                            height: 79,
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
                                  offset: const Offset(0,
                                      3), // changes the position of the shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  fundModel.alumni_students,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF467EAD)),
                                ),
                                const Text(
                                  "Alumni",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF5A5F5C)),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 40, 15, 15),
                        child: const Text(
                          " Fund Information",
                          style: TextStyle(
                              color: Color(0xFF5A5F5C),
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TabBar(
                        controller: _tabController,
                        dividerColor: const Color(0xFFF0F3F5),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 9),
                        tabs: <Widget>[
                          Tab(
                              height: 72,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    0.4, // 40% of screen width
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/adoption.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    const Text(
                                      "Beneficiary",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF5A5F5C)),
                                    ),
                                  ],
                                ),
                              )),
                          Tab(
                              height: 72,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    0.4, // 40% of screen width
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/alumni.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    const Text(
                                      "Alumni",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF5A5F5C)),
                                    ),
                                  ],
                                ),
                              )),
                          Tab(
                              height: 72,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    0.4, // 40% of screen width
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/tansaction.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    const Text(
                                      "Pledges",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF5A5F5C)),
                                    ),
                                  ],
                                ),
                              )),
                          Tab(
                              height: 72,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    0.4, // 40% of screen width
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/activeFund.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    const Text(
                                      "Transaction",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF5A5F5C)),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            studentList.length != 0
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    //  shrinkWrap: true,
                                    itemCount: studentList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  StudentProfile(
                                                      studentId:
                                                          studentList[index]
                                                              .student_id,
                                                      fundModel: fundModel),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      studentList[index]
                                                          .student_name,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF5A5F5C),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      studentList[index]
                                                          .school_name,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xffA7A8BB),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                    "${studentList[index].current_semester}th",
                                                    style: const TextStyle(
                                                      color: Color(0xffBC1E3D),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                  const Text(
                                                    "Semester",
                                                    style: TextStyle(
                                                      color: Color(0xFF5A5F5C),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            alumniList.length != 0
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    //shrinkWrap: true,
                                    itemCount: alumniList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AlumniProfile(
                                                alumni: alumniList[index],
                                                fundName: fundModel.name,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
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
                                                      alumniList[index]
                                                          .student_name,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF5A5F5C),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      alumniList[index]
                                                          .school_name,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xffA7A8BB),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    alumniList[index]
                                                        .passing_year,
                                                    style: const TextStyle(
                                                      color: Color(0xff7209B7),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            pledgeList.length != 0
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    //shrinkWrap: true,
                                    itemCount: pledgeList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AlumniProfile(
                                        alumni: alumniList[index],
                                        fundName: fundModel.name,
                                      ),
                                    ),
                                  ); */
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
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
                                                    const Text(
                                                      "Due Date",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5A5F5C),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      pledgeList[index]
                                                          .pledge_amount,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xffA7A8BB),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                    pledgeList[index]
                                                        .transaction_date,
                                                    style: const TextStyle(
                                                      color: Color(0xffBC1E3D),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  const Text(
                                                    "Due Pledge",
                                                    style: TextStyle(
                                                      color: Color(0xFF5A5F5C),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            const Column(
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
                          ],
                        ),
                      ),
                    ]),
              ))),
    );
  */
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _TabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
