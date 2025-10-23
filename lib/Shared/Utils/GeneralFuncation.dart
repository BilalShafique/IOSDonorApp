import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String getDateTimeFormate(String date) {
  DateTime now = DateTime.parse(date);
  String formattedDate = DateFormat('MMM dd, yyyy hh:mm:ss').format(now);
  return formattedDate;
}

String getDateFormate(String date) {
  DateTime now = DateTime.parse(date);
  String formattedDate = DateFormat('dd MMM, yyyy').format(now);
  return formattedDate;
}

String getLastTwoDigitsOfYear(String date) {
  DateTime now = DateTime.parse(date);
  return (now.year % 100).toString().padLeft(2, '0');
}

String getDateMonthFormate(String date) {
  DateTime now = DateTime.parse(date);
  String formattedDate = DateFormat('MMM').format(now);
  return formattedDate;
}

String getTimeFormate(String time) {
  DateTime now = DateTime.parse(time);
  String formattedTime = DateFormat('hh:mm a').format(now);
  return formattedTime;
}

String getUserFirstLetetrs(String text) {
  String userShortName = "";
  var data = text.split(" ");

  int counter = data.length > 1 ? 2 : 1;
  for (int i = 0; i < counter; i++) {
    if (data[i].isNotEmpty) {
      userShortName = userShortName + data[i][0];
    }
  }
  return userShortName;
}

/* class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
} */

String capitalize(String value) {
  if (value.trim().isEmpty) {
    return "";
  }
  var data = value.split(" ");

  String reply = "";

  for (int i = 0; i < data.length; i++) {
    reply = reply +
        ("${data[i][0].toUpperCase()}${data[i].substring(1).toLowerCase()}");
  }
  return reply;
  // return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}

String formatAmount(double amount) {
  if (amount >= 1e9) {
    return '${(amount / 1e9).toStringAsFixed(1)}B'; // For billions
  } else if (amount >= 1e6) {
    return '${(amount / 1e6).toStringAsFixed(1)}M'; // For millions
  } else {
    return amount.toString(); // For amounts less than a million
  }
}

void makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch $phoneUri';
  }
}

void sendEmail(String email, String subject, String body) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {
      'subject': subject,
      'body': body,
    },
  );
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not launch $emailUri';
  }
}
