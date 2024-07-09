
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

class SignUpOtp extends StatefulWidget {
  final String email;
  const SignUpOtp(this.email, {super.key});

  @override
  State<SignUpOtp> createState() => _SignUpOtpState();
}

class _SignUpOtpState extends State<SignUpOtp> {
  final signUpOtpFormKey = GlobalKey<FormBuilderState>();

  bool pinCorrect = false;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: smartpayBlack.shade100),
      borderRadius: BorderRadius.circular(15),
      color: smartpayBlack.shade100,
    ),
  );

  final focusedPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        color: smartpayBlue.shade600,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(15),
      color: smartpayBlack.shade100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    //Get email from passed parameter
    String email = widget.email;

    //User String split to get email doman
    String emailDomain = email.split("@").last;

    //Mask email
    String maskedEmail = "*****@$emailDomain";

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
                    'Verify it\'s you',
                    null,
                    null,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: RichText(
                      text: TextSpan(
                        text: 'We sent a code to (',
                        style: AppTheme.text16Grey400(),
                        children: [
                          TextSpan(
                            text: maskedEmail,
                            style: AppTheme.text16(),
                          ),
                          const TextSpan(
                            text: '). Enter it here to verify your identity.',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: Pinput(
                      length: 5,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: focusedPinTheme,
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
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Resend code in 30 secs',
                      style: AppTheme.text18GrayExtraBold(),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 80),

                  //Confirm Button
                  pinCorrect == true
                      ? InkWell(
                          child: AppTheme.blackContainer(
                            Text(
                              'Confirm',
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
                            'Confirm',
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
