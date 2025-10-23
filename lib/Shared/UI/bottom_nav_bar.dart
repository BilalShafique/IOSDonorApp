import 'package:donor_app/Modules/Dashboard/UI/home.dart';
import 'package:donor_app/Modules/Fund/UI/fund.dart';
import 'package:donor_app/Modules/Profile/UI/profile.dart';
import 'package:donor_app/Modules/StudentProfile/UI/beneficiary_list.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  int selectedIndex;
  BottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex = 0;

  // List of widgets to be displayed when a tab is selected
  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const Fund(),
    // FundSummary(),
    BeneficiaryList(selectedIndex: 0),
    const Profile(),
  ];
  @override
  void initState() {
    super.initState();
    // Initialize _selectedIndex with the value passed from the parent widget
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined),
              label: 'Funds',
            ),
            /* BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: '360 View',
            ), */
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Beneficiaries',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF467EAD),
          unselectedItemColor: const Color(0xFFA5A8A6),
          showUnselectedLabels: true),
    );
  }
}
