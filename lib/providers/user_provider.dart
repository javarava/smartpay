import 'package:flutter/material.dart';
import 'dart:async';
import '/src/datastorage.dart';

class UserProvider with ChangeNotifier {
  Map? loggedinUser;
  String? userID;

  String userFullName = '';
  String userEmail = '';

  var userDetails = List<Map<String, dynamic>?>.filled(1, {});

  String emailFromFile = '';
  int? pin;

  Map newCountry = {};

  UserProvider() {
    readDetailsFromFile();
    readEmailFromFile();
    readPinFromFile();
  }

  //Read user details from text file on device
  Future<void> readDetailsFromFile() async {
    try {
      final detailsFile = await readDetailsFile();
      if (detailsFile.isEmpty) {
        debugPrint('User details file does not exist or empty');
        loggedinUser = null;
      } else {
        loggedinUser = detailsFile;
        //debugPrint('User details from file: $detailsFile');
      }
    } catch (e) {
      debugPrint("An error occurred! Error: ${e.toString()}");
    }

    notifyListeners();
  }

  //Read email from text file on device
  Future<void> readEmailFromFile() async {
    try {
      final emailFile = await readEmailFile();
      if (emailFile.isEmpty) {
        debugPrint('Email file does not exist or empty');
        emailFromFile = '';
      } else {
        emailFromFile = emailFile;
        //debugPrint('Email from file: $emailFromFile');
      }
    } catch (e) {
      debugPrint("An error occurred! Error: ${e.toString()}");
    }

    notifyListeners();
  }

  //Read pin from text file on device
  Future<void> readPinFromFile() async {
    try {
      final pinFile = await readPinFile();
      if (pinFile.isEmpty) {
        debugPrint('Pin file does not exist or empty');
        pin = 0;
      } else {
        pin = int.tryParse(pinFile);
        //debugPrint('Pin from file: $pin');
      }
    } catch (e) {
      debugPrint("An error occurred! Error: ${e.toString()}");
    }

    notifyListeners();
  }

  Map? get lUser => loggedinUser;

  bool get isLoggedIn => loggedinUser != null;

  String get fullname => userFullName;

  List<Map<String, dynamic>?> get details => userDetails;

  String get email => userEmail;

  String get emailFF => emailFromFile;

  Map get country => newCountry;

  //Set user
  void setUser(Map? user) {
    loggedinUser = user;
    userID = user!['id'];
    userFullName = user['full_name'];
    userEmail = user['email'];
    notifyListeners();
  }

  //Logout User
  void logOut() async {
    loggedinUser = null;
    userID = null;
    userDetails[0] = {};

    notifyListeners();
  }

  //Set user first name
  void addUserFullName(String item) {
    userFullName = (item);
    notifyListeners();
  }

  //Set user details
  void addUserDetails(Map<String, dynamic>? item) {
    userDetails[0] = (item);

    notifyListeners();
  }

  //Update user details
  void updateUserDetails(key, newvalue) {
    userDetails[0]!.update(key, (value) => newvalue);
    notifyListeners();
  }

  //Set user email
  void addUserEmail(String item) {
    userEmail = (item);
    notifyListeners();
  }

  //Set country
  void setNewCountry(Map item) {
    newCountry = (item);
    notifyListeners();
  }
}
