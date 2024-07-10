import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/src/widgets.dart';
import '/src/theme.dart';
import '/src/datastorage.dart';
import '/routes/signupabout.dart';

class SignUpOtp extends StatefulWidget {
  final String email;
  final String token;
  const SignUpOtp(this.email, this.token, {super.key});

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

    //Get token from passed parameter
    String token = widget.token;

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
                        if (s == token) {
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
                      onCompleted: (pin) async {
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

                            //check if mounted
                            if (!context.mounted) return;

                            //Show Loading Dialog
                            showLoaderDialog(context);

                            //Verify email with api
                            await verifyPinCode(context, email, token);

                            //Write email in file
                            writeEmail(email);

                            //check if mounted
                            if (!context.mounted) return;

                            //Save email in Provider
                            context.read<UserProvider>().addUserEmail(email);

                            //check if mounted
                            if (!context.mounted) return;

                            //Close Progress Dialog
                            Navigator.of(context, rootNavigator: true).pop();

                            //PUSH TO SIGNUP OTP
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

  //Verify email with api
  verifyPinCode(context, email, token) async {
    try {
      //Request a token to verify a new email address
      var headers = {'Accept': 'application/json'};
      var request =
          http.Request('POST', Uri.parse('${apiURL}auth/email/verify'));
      request.bodyFields = {
        'email': email,
        'token': token,
      };
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseStream = await response.stream.bytesToString();
        debugPrint('Response Stream = $responseStream');

        Map responseJson = json.decode(responseStream);

        debugPrint('Response JSON = $responseJson');

        //String message = responseJson['message'];
      } else {
        debugPrint(response.reasonPhrase);

        //Close Progress Dialog
        //check if mounted
        if (!context.mounted) return;
        Navigator.of(context, rootNavigator: true).pop();

        //return so other processes won't run
        return;
      }
    } catch (e) {
      //check if mounted
      if (!context.mounted) return;

      //Close Progress Dialog
      Navigator.of(context, rootNavigator: true).pop();

      debugPrint('Error: ${e.toString()}');

      //return so other processes won't run
      return;
    }
  }
}
