//import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

//Write user details in a text file on user's device
Future<File> writeDetails(Map<String, dynamic> detailsMap) async {
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
