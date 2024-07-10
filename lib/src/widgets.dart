import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '/src/theme.dart';

var nf = NumberFormat('###,###,##0.00');

String apiURL = 'https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1/';

NumberFormat usFormat = NumberFormat.decimalPatternDigits(
  locale: 'en_us',
  decimalDigits: 2,
);

NumberFormat usFormatInt = NumberFormat.decimalPatternDigits(
  locale: 'en_us',
  decimalDigits: 0,
);

var ldf = DateFormat('MMMM d, yyyy');

DateFormat df = DateFormat('dd/MM/yyyy hh:mm a');
DateFormat dt = DateFormat('hh:mm a');
DateFormat dd = DateFormat('E');
DateFormat ddm = DateFormat('d/M');
DateFormat ddmy = DateFormat('d/M/y');
DateFormat mrdOnly = DateFormat('a');
DateFormat yearOnly = DateFormat('a');

//Return date in format 'MMMM d, yyyy'
String displayMediumDate(date) {
  try {
    DateTime? finalDate;

    if (date.runtimeType == String) {
      finalDate = DateTime.tryParse(date);
    } else if (date.runtimeType == DateTime) {
      finalDate = date;
    } else {
      finalDate = date.toDate();
    }

    return ldf.format(finalDate!);
  } catch (e) {
    debugPrint('An error occurred! $e');
    return '';
  }
}

//Return date in format 'dd/MM/yyyy hh:mm a'
String displayLongDate(date) {
  try {
    DateTime? finalDate;

    if (date.runtimeType == String) {
      finalDate = DateTime.tryParse(date);
    } else if (date.runtimeType == DateTime) {
      finalDate = date;
    } else {
      finalDate = date.toDate();
    }

    return df.format(finalDate!);
  } catch (e) {
    debugPrint('An error occurred! $e');
    return '';
  }
}

//1 SEC DELAY
oneSecDelay(context) async {
  await Future.delayed(const Duration(seconds: 1));
}

//2 SEC DELAY
twoSecDelay(context) async {
  await Future.delayed(const Duration(seconds: 2));
}

//3 SEC DELAY
threeSecDelay(context) async {
  await Future.delayed(const Duration(seconds: 3));
}

//CHECK INTERNET CONNECTION

checkConn(context) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      debugPrint('Connected!');
    }
  } on SocketException catch (_) {
    debugPrint('Not connected!');

    toastInfoShort('No Internet connection.');

    return;
  }
}

//SHOW LONG TOAST MESSAGE
toastInfoLong(String info) {
  Fluttertoast.showToast(
      msg: info,
      backgroundColor: smartpayBlack.shade800,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG);
}

//SHOW SHORT TOAST MESSAGE
toastInfoShort(String info) {
  Fluttertoast.showToast(
      msg: info,
      backgroundColor: smartpayBlack.shade800,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT);
}

//To show loader dialog, use
//Show Loading Dialog
//showLoaderDialog(context);

//To hide loader dialog, use
//Close Progress Dialog
//Navigator.of(context, rootNavigator: true).pop();

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      width: 60,
      height: 115,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: smartpayBlack.shade800,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(0),
              child: const Text("Please Wait..."),
            ),
          ],
        ),
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//Alert box with one button
oneButtonAlertDialog(BuildContext context, String continueText, var pageToPush,
    String alertTitle, String alertContent) {
  // Set up the buttons

  Widget continueButton = TextButton(
    child: Text(
      continueText,
      style: AppTheme.text16Bold(),
    ),
    onPressed: () async {
      Navigator.of(context, rootNavigator: true).pop();

      Navigator.pushNamed(context, pageToPush);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      alertTitle,
      style: AppTheme.text20Bold(),
    ),
    content: Text(
      alertContent,
      style: AppTheme.text16(),
    ),
    actions: [
      continueButton,
    ],
  ); // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//Alert box with one button
oneButtonReturnAlertDialog(
    BuildContext context, String alertTitle, String alertContent) {
  // Set up the buttons

  Widget continueButton = TextButton(
    child: Text(
      'OK',
      style: AppTheme.text16Bold(),
    ),
    onPressed: () async {
      Navigator.of(context, rootNavigator: true).pop();
      return;
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      alertTitle,
      style: AppTheme.text20Bold(),
    ),
    content: Text(
      alertContent,
      style: AppTheme.text14(),
    ),
    actions: [
      continueButton,
    ],
  ); // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//Alert box with two buttons
twoButtonsAlertDialog(
    BuildContext context,
    String cancelText,
    String continueText,
    var pageToPush,
    String alertTitle,
    String alertContent) {
  // Set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      cancelText,
      style: AppTheme.text16Bold(),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
      return;
    },
  );
  Widget continueButton = TextButton(
    child: Text(
      continueText,
      style: AppTheme.text16Bold(),
    ),
    onPressed: () async {
      Navigator.of(context, rootNavigator: true).pop();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pageToPush,
        ),
      );
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      alertTitle,
      style: AppTheme.text20Bold(),
    ),
    content: Text(
      alertContent,
      style: AppTheme.text16(),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  ); // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//Alert box with Action buttons
twoButtonsActionAlertDialog(
    BuildContext context,
    String cancelText,
    String continueText,
    var action,
    var pageToPush,
    String alertTitle,
    String alertContent) {
  // Set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      cancelText,
      style: AppTheme.text16Bold(),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
      return;
    },
  );
  Widget continueButton = TextButton(
    child: Text(
      continueText,
      style: AppTheme.text16Bold(),
    ),
    onPressed: () async {
      Navigator.of(context, rootNavigator: true).pop();

      action;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pageToPush,
        ),
      );
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      alertTitle,
      style: AppTheme.text20Bold(),
    ),
    content: Text(
      alertContent,
      style: AppTheme.text16(),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  ); // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//Alert box with two buttons
twoButtonsContinueAlertDialog(
    BuildContext context, String alertTitle, String alertContent) {
  // Set up the buttons
  Widget cancelButton = TextButton(
    child: const Text('Cancel'),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
      return;
    },
  );
  Widget continueButton = TextButton(
    child: const Text('Continue'),
    onPressed: () async {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      alertTitle,
      style: const TextStyle(fontSize: 16),
    ),
    content: Text(
      alertContent,
      style: const TextStyle(fontSize: 15),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  ); // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//Display greeting message based on device time
String displayGreeting() {
  try {
    int hours = DateTime.now().hour;

    //debugPrint('Meridian = $meridian');

    if (hours >= 0 && hours <= 12) {
      return "Good morning";
    } else if (hours >= 12 && hours <= 16) {
      return "Good afternoon";
    } else if (hours >= 12 && hours <= 24) {
      return "Good evening";
    } else {
      return 'Hi';
    }
  } catch (e) {
    debugPrint('An error occurred! $e');
    return '';
  }
}

integerOnlyTextFormatter() {
  return [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    FilteringTextInputFormatter.deny(RegExp(r'[a-zA-Z]')),
    FilteringTextInputFormatter.deny(RegExp(r'[\n]')),
    FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
    FilteringTextInputFormatter.deny(RegExp(r'[-]')),
    //LengthLimitingTextInputFormatter(3),
  ];
}

richHeaderTextBlueMiddle(String startText, String? blueText, String? endText) {
  return SizedBox(
    width: double.infinity,
    child: RichText(
      text: TextSpan(
        text: startText,
        style: AppTheme.text28ExtraBold(),
        children: [
          blueText != null
              ? TextSpan(
                  text: blueText,
                  style: AppTheme.text28BlueExtraBold(),
                )
              : const TextSpan(),
          endText != null
              ? TextSpan(
                  text: endText,
                )
              : const TextSpan()
        ],
      ),
    ),
  );
}

//Return tabs
tabWithIconTitleDesc(var icon, String title, String desc) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    width: double.infinity,
    decoration: AppTheme.grey1cir10BoxDecoration(),
    child: Row(
      children: [
        SizedBox(
          child: Icon(
            icon,
            size: 28,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.text16Bold(),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: AppTheme.text12(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 22,
            color: Color.fromARGB(255, 95, 95, 95),
          ),
        ),
      ],
    ),
  );
}
