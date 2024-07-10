import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/src/datastorage.dart';
import '/providers/user_provider.dart';
import '/src/widgets.dart';
import '/src/theme.dart';
import '/src/globals.dart' as globals;

String? pinSupplied;
String? userPin;

class SignInPinVerify extends StatefulWidget {
  const SignInPinVerify({super.key});

  @override
  State<SignInPinVerify> createState() => _SignInPinVerifyState();
}

class _SignInPinVerifyState extends State<SignInPinVerify> {
  bool pinCorrect = false;

  final bottomOnlyPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
      fontSize: 20,
      color: smartpayBlack.shade900,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 2.0,
          color: smartpayBlack.shade900,
        ),
      ),
    ),
  );

  //get pin from file
  Future<String> getPinFromFile() async {
    userPin = await readPinFile();
    return userPin!;
  }

  @override
  Widget build(BuildContext context) {
    //get saved pin
    var uPin = getPinFromFile();

    return FutureBuilder(
      future: uPin,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      //title: const Text('Sign In'),
                      expandedHeight: 46,
                      toolbarHeight: 46,
                      floating: true,
                      snap: true,

                      leading: AppTheme.sliverAppBarBackLeading(context),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),

                        //Rich header text
                        richHeaderTextBlueMiddle(
                          'Provide your PIN code',
                          null,
                          null,
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'We use state-of-the-art security measures to protect your information at all times',
                            style: AppTheme.text16Grey400(),
                          ),
                        ),

                        const SizedBox(height: 30),

                        //Using Pinput package for Pin
                        SizedBox(
                          width: double.infinity,
                          child: Pinput(
                            length: 5,
                            defaultPinTheme: bottomOnlyPinTheme,
                            focusedPinTheme: bottomOnlyPinTheme,
                            submittedPinTheme: bottomOnlyPinTheme,
                            inputFormatters: integerOnlyTextFormatter(),
                            obscureText: true,
                            obscuringWidget: Text(
                              '•',
                              style: AppTheme.text28ExtraBold(),
                            ),
                            /* validator: (s) {
                        if (s == '22222') {
                          setState(() {
                            pinCorrect = true;
                          });
                          return null;
                        } else {
                          setState(() {
                            pinCorrect = false;
                          });
                          return 'Pin is incorrect';
                        } 
                      },*/
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onChanged: (s) {
                              setState(() {
                                pinCorrect = false;
                              });
                            },
                            onCompleted: (pin) {
                              //debugPrint('Pin: $pin');

                              setState(() {
                                pinCorrect = true;
                                pinSupplied = pin;
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 80),

                        //Confirm Button
                        pinCorrect == true
                            ? InkWell(
                                child: AppTheme.blackContainer(
                                  Text(
                                    'Sign In',
                                    style: AppTheme.text18InvertedBold(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onTap: () async {
                                  //Dismiss keyboard
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  try {
                                    if (userPin == pinSupplied) {
                                      //debugPrint('Pin Correct');

                                      //get user detail from detail file
                                      Map? userData = await readDetailsFile();

                                      //read password from file
                                      String? password = await readPassword();

                                      //Login user with api
                                      var headers = {
                                        'Accept': 'application/json'
                                      };
                                      var request = http.Request('POST',
                                          Uri.parse('${apiURL}auth/login'));
                                      request.bodyFields = {
                                        'email': userData['email'],
                                        'password': password,
                                        'device_name': 'mobile'
                                      };
                                      request.headers.addAll(headers);

                                      //debugPrint('Body fields: ${request.bodyFields}');

                                      http.StreamedResponse response =
                                          await request.send();

                                      if (response.statusCode == 200) {
                                        String responseStream = await response
                                            .stream
                                            .bytesToString();

                                        //debugPrint('Response Stream = $responseStream');

                                        //convert response to JSON format
                                        Map responseJson =
                                            json.decode(responseStream);

                                        //debugPrint('Response JSON = $responseJson');

                                        Map? userData =
                                            responseJson['data']['user'];
                                        String? token =
                                            responseJson['data']['token'];

                                        //check if mounted
                                        if (!context.mounted) return;

                                        //set user in provider
                                        context
                                            .read<UserProvider>()
                                            .setUser(userData);

                                        //write user details in file
                                        writeDetails(userData!);

                                        //set secret token
                                        context
                                            .read<UserProvider>()
                                            .setToken(token);

                                        //write token to file
                                        writeTokenFile(token!);

                                        setState(() {
                                          //set global isLoggedIn
                                          globals.isLoggedIn = true;
                                        });

                                        //check if mounted
                                        if (!context.mounted) return;

                                        //PUSH TO HOME
                                        context.replace('/');
                                      } else {
                                        //debugPrint(response.reasonPhrase);

                                        String responseStream = await response
                                            .stream
                                            .bytesToString();

                                        //convert response to JSON format
                                        Map responseJson =
                                            json.decode(responseStream);

                                        //debugPrint('Reponse: $responseJson');

                                        if (responseJson['errors']['email']
                                            .contains(
                                                'These credentials do not match our records.')) {
                                          toastInfoLong(
                                              'Wrong password provided. Please try again.');
                                        } else {
                                          toastInfoLong(
                                              'An error occurred! Please try again.');
                                        }

                                        return;
                                      }
                                    } else {
                                      //check if mounted
                                      if (!context.mounted) return;

                                      //show error dialog
                                      oneButtonReturnAlertDialog(
                                        context,
                                        'Invalid PIN',
                                        'The PIN your provided does not match. Please try again',
                                      );
                                    }
                                  } on PathNotFoundException catch (e) {
                                    debugPrint('Error Message: ${e.message}');

                                    return;
                                  }
                                },
                              )
                            : AppTheme.grayContainer(
                                Text(
                                  'Sign In',
                                  style: AppTheme.text18InvertedBold(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
