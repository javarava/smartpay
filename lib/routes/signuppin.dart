import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/src/widgets.dart';
import '/src/theme.dart';
import '/routes/signupabout.dart';

Map? loggedinUser;
String? userEmail;
String? userID;

class SignUpPin extends StatefulWidget {
  const SignUpPin({super.key});

  @override
  State<SignUpPin> createState() => _SignUpPinState();
}

class _SignUpPinState extends State<SignUpPin> {
 

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                //title: const Text('Sign Up'),
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
                    'Set your PIN code',
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
                      validator: (s) {
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
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onChanged: (s) {
                        setState(() {
                          pinCorrect = false;
                        });
                      },
                      onCompleted: (pin) {
                        debugPrint('Pin: $pin');
                      },
                    ),
                  ),

                  const SizedBox(height: 80),

                  //Confirm Button
                  pinCorrect == true
                      ? InkWell(
                          child: AppTheme.blackContainer(
                            Text(
                              'Create PIN',
                              style: AppTheme.text18InvertedBold(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () async {
                            //Dismiss keyboard
                            FocusManager.instance.primaryFocus?.unfocus();

                            //Check internet connection
                            await checkConn(context);

                            //PUSH TO SIGNUP OTP
                            //check if mounted
                            if (!context.mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const SignUpAbout(),
                              ),
                            );
                          },
                        )
                      : AppTheme.grayContainer(
                          Text(
                            'Create PIN',
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
  }
}
