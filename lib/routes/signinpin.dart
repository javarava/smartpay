import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/src/datastorage.dart';
import '/providers/user_provider.dart';
import '/src/widgets.dart';
import '/src/theme.dart';

Map? loggedinUser;
String? userEmail;
String? userID;

String? pinSupplied;
String? userPin;

class SignInPin extends StatefulWidget {
  final Map userData;
  const SignInPin(this.userData, {super.key});

  @override
  State<SignInPin> createState() => _SignInPinState();
}

class _SignInPinState extends State<SignInPin> {
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
    //Get passed parameter
    Map? userData = widget.userData;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onChanged: (s) {
                        setState(() {
                          pinCorrect = false;
                        });
                      },
                      onCompleted: (pin) {
                        debugPrint('Pin: $pin');

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

                            //read pin from file
                            String? pinFromFile = await readPinFile();

                            debugPrint('Pin from file: $pinFromFile');

                            if (pinFromFile == pinSupplied) {
                              debugPrint('Pin Correct');

                              //check if mounted
                              if (!context.mounted) return;

                              //Save user data in Provider
                              context.read<UserProvider>().setUser(userData);

                              //write user detail in file
                              writeDetails(userData);

                              //PUSH TO HOME
                              context.go('/');
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
  }
}
