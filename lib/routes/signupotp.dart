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

Map? loggedinUser;
String? userEmail;
String? userID;

class SignUpOtp extends StatefulWidget {
  const SignUpOtp({super.key});

  @override
  State<SignUpOtp> createState() => _SignUpOtpState();
}

class _SignUpOtpState extends State<SignUpOtp> {
  final signUpOtpFormKey = GlobalKey<FormBuilderState>();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
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
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Verify it\'s you',
                      style: AppTheme.text28ExtraBold(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Pinput(
                    length: 5,
                    defaultPinTheme: defaultPinTheme,
                    //focusedPinTheme: focusedPinTheme,
                    //submittedPinTheme: submittedPinTheme,
                    validator: (s) {
                      return s == '2222' ? null : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) {
                      debugPrint('Pin: $pin');
                    },
                  ),
                  const SizedBox(height: 30),
                  FormBuilder(
                    key: signUpOtpFormKey,
                    child: Column(
                      children: [
                        //SIGN IN BUTTON
                        InkWell(
                          child: AppTheme.blackContainer(
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              child: Text(
                                'Sign Up',
                                style: AppTheme.text18InvertedBold(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          onTap: () async {
                            //Dismiss keyboard
                            FocusManager.instance.primaryFocus?.unfocus();

                            //Check internet connection
                            await checkConn(context);
                          },
                        ),

                        const SizedBox(height: 40),
                      ],
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
