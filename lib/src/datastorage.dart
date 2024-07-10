//import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

//Write user details in a text file on user's device
Future<File> writeDetails(Map<dynamic, dynamic> detailsMap) async {
  final directory = await getApplicationDocumentsDirectory();
  final localPath = directory.path;
  final file = File('$localPath/details.txt');
  final jsonStr = jsonEncode(detailsMap);
  //debugPrint('Details written to file! $jsonStr');
  // Write the file
  return file.writeAsString(jsonStr);
}

//Read user details from details.txt file on user's device
Future<Map<String, dynamic>> readDetailsFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final localPath = directory.path;
  final file = File('$localPath/details.txt');
  //debugPrint('Details File Path: $localPath/details.txt');
  final jsonStr = await file.readAsString();
  return jsonDecode(jsonStr) as Map<String, dynamic>;
}

//Write user email in a text file on user's device
Future<File> writeEmail(String email) async {
  final directory = await getApplicationDocumentsDirectory();
  final localPath = directory.path;
  final file = File('$localPath/email.txt');
  final jsonStr = jsonEncode(email);
  //debugPrint('Address written to file!');
  // Write the file
  return file.writeAsString(jsonStr);
}

//Read user email from email.txt file on user's device
Future<String> readEmailFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final localPath = directory.path;
  final file = File('$localPath/email.txt');
  //debugPrint('Email File Path: $localPath/email.txt');
  final jsonStr = await file.readAsString();
  return jsonDecode(jsonStr);
}

//Write user pin in a text file on user's device
Future<File> writePin(String pin) async {
  final directory = await getApplicationDocumentsDirectory();
  final localPath = directory.path;
  final file = File('$localPath/pin.txt');
  final jsonStr = jsonEncode(pin);
  //debugPrint('Pin written to file!');
  // Write the file
  return file.writeAsString(jsonStr);
}

//Read user pin from pin.txt file on user's device
Future<String> readPinFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final localPath = directory.path;
  final file = File('$localPath/pin.txt');
  //debugPrint('Pin File Path: $localPath/pin.txt');
  final jsonStr = await file.readAsString();
  return jsonDecode(jsonStr);
}

//Write user token in a text file on user's device
Future<File> writeTokenFile(String token) async {
  final directory = await getApplicationDocumentsDirectory();
  final localPath = directory.path;
  final file = File('$localPath/token.txt');
  final jsonStr = jsonEncode(token);
  //debugPrint('Token written to file!');
  // Write the file
  return file.writeAsString(jsonStr);
}

//Read user token from token.txt file on user's device
Future<String> readToken() async {
  final directory = await getApplicationDocumentsDirectory();
  final localPath = directory.path;
  final file = File('$localPath/token.txt');
  //debugPrint('Token File Path: $localPath/pin.txt');
  final jsonStr = await file.readAsString();
  return jsonDecode(jsonStr);
}

//Write user password in a text file on user's device
//This is a possible edge case because it could be a vulnerability to save user password in a text file
//A possible work around is to encrypt the password upon save and decrypt upon request
Future<File> writePasswordFile(String password) async {
  final directory = await getApplicationDocumentsDirectory();
  final localPath = directory.path;
  final file = File('$localPath/password.txt');
  final jsonStr = jsonEncode(password);
  //debugPrint('Password written to file!');
  // Write the file
  return file.writeAsString(jsonStr);
}

//Read user token from token.txt file on user's device
Future<String> readPassword() async {
  final directory = await getApplicationDocumentsDirectory();
  final localPath = directory.path;
  final file = File('$localPath/password.txt');
  //debugPrint('Password File Path: $localPath/pin.txt');
  final jsonStr = await file.readAsString();
  return jsonDecode(jsonStr);
}
