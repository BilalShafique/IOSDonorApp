import 'package:flutter/material.dart';

class FundSummary extends StatefulWidget {
  const FundSummary({Key? key}) : super(key: key);

  @override
  FundSummaryState createState() => FundSummaryState();
}

class FundSummaryState extends State<FundSummary> {
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
        title: const Text(
          "Funds Summary",
          style: TextStyle(
            color: Colors.white, // Text color
          ),
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
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/tansaction.png',
                      height: 44,
                      width: 44,
                    ),
                    const Text(
                      " Funds State",
                      style: TextStyle(
                        color: Color(0xFF467EAD),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
              height: 200), // Adjust the height as needed to center it
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Currently, No Stats found!",
                  style: TextStyle(
                    color: Color(0xffA7A8BB),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
