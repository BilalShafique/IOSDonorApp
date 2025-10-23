import 'package:donor_app/Shared/Utils/GeneralFuncation.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact us", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/contactusBG.jpg'), // Your image asset path
              fit: BoxFit.cover, // Make the image cover the entire AppBar
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // Back button color
          onPressed: () {
            Navigator.pop(context);
          },
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
        // Back button (default or manually added)
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Contact us!",
              style: TextStyle(
                  color: Color(0xFF467EAD),
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
            const Text(
              "Please call us or send an email to get access to your account",
              style: TextStyle(
                  color: Color(0xFF5A5F5C),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          'assets/Email.png',
                          width: 44,
                          height: 44,
                        ),
                      ),
                      InkWell(
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email ID",
                                style: TextStyle(
                                    color: Color(0xFF5A5F5C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            Text(
                              "Advancement@nust.edu.pk",
                              style: TextStyle(
                                  color: Color(0xFF5A5F5C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        onTap: () => sendEmail(
                          'advancement@nust.edu.pk',
                          'Greetings',
                          'Hello, I hope this email finds you well!',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          'assets/phone.png',
                          width: 44,
                          height: 44,
                        ),
                      ),
                      InkWell(
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Phone No",
                                style: TextStyle(
                                    color: Color(0xFF5A5F5C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            Text(
                              "+92 (51) 8866820",
                              style: TextStyle(
                                  color: Color(0xFF5A5F5C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        onTap: () => makePhoneCall('+92518866820'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
