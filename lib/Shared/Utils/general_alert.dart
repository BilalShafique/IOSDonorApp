import 'package:flutter/material.dart';

String showGeneralAlert(
    String title, String message, String icon, BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, height: 150, width: 150),
        Text(
          title,
          //style: Theme.of(context).textTheme.headline5,
        ),
      ],
    ),
    content: SizedBox(
        height: MediaQuery.of(context).size.width / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              //style: Theme.of(context).textTheme.headline6
            ),
          ],
        )),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
        return alertDialog;
      });
  return "1";
}

String showInfoAlert(
    String title, String message, String icon, BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    title: SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    ),
    content: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.06,
        padding: const EdgeInsets.all(2),
        child: Text(
          message,
          style: const TextStyle(fontSize: 14, color: Colors.black),
          textAlign: TextAlign.center,
        )),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
        return alertDialog;
      });
  return "1";
}
