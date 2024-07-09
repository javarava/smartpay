import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/src/widgets.dart';
import '/src/theme.dart';
import '/src/emails.dart';
import '/routes/signupotp.dart';

Map? loggedinUser;
String? userEmail;
String? userID;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Define variables
  final signUpFormKey = GlobalKey<FormBuilderState>();
  final signUpEmailFieldKey = GlobalKey<FormBuilderFieldState>();

  bool emailHasError = false;

  String email = '';

  @override
  Widget build(BuildContext context) {
    //Get email from email text file using Provider
    String initialEmail = context.watch<UserProvider>().emailFF;

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
                    'Create a ',
                    'Smartpay \n',
                    'account',
                  ),

                  const SizedBox(height: 30),

                  FormBuilder(
                    key: signUpFormKey,
                    child: Column(
                      children: [
                        SizedBox(
                          child: FormBuilderTextField(
                            key: signUpEmailFieldKey,
                            name: 'email',
                            initialValue: initialEmail,
                            style: AppTheme.text16(),
                            decoration:
                                AppTheme.smartpayInputDecoration('Email'),

                            //Validates email
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText:
                                        'Please provide your email address'),
                                FormBuilderValidators.email(),
                              ],
                            ),
                            onChanged: (val) {
                              //Check if email supplied is valid
                              setState(
                                () {
                                  emailHasError = !(signUpFormKey
                                          .currentState?.fields['email']
                                          ?.validate() ??
                                      false);
                                },
                              );
                            },
                            // Set keyboard style
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                        ),

                        const SizedBox(height: 30),

                        //SIGN IN BUTTON
                        InkWell(
                          child: AppTheme.blackContainer(
                            Text(
                              'Sign Up',
                              style: AppTheme.text18InvertedBold(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () async {
                            //Dismiss keyboard
                            FocusManager.instance.primaryFocus?.unfocus();

                            //Check internet connection
                            await checkConn(context);

                            if (signUpFormKey.currentState?.saveAndValidate() ??
                                false) {
                              //debugPrint('Valid');

                              //Show Loading Dialog
                              //check if mounted
                              if (!context.mounted) return;
                              showLoaderDialog(context);

                              email = signUpFormKey.currentState!.value['email']
                                  .toString();

                              try {
                                //Request a token to verify a new email address
                                var headers = {'Accept': 'application/json'};
                                var request = http.Request(
                                    'POST', Uri.parse('${apiURL}auth/email'));
                                request.bodyFields = {'email': email};
                                request.headers.addAll(headers);

                                http.StreamedResponse response =
                                    await request.send();

                                if (response.statusCode == 200) {
                                  String responseStream =
                                      await response.stream.bytesToString();
                                  debugPrint(
                                      'Response Stream = $responseStream');

                                  Map responseJson =
                                      json.decode(responseStream);

                                  debugPrint('Response JSON = $responseJson');

                                  String token = responseJson['data']['token'];

                                  //Send Email to user
                                  sendNewUserTokenMail(email, token);

                                  //check if mounted
                                  if (!context.mounted) return;

                                  //Close Progress Dialog
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();

                                  //PUSH TO SIGNUP OTP

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          SignUpOtp(email, token),
                                    ),
                                  );
                                } else {
                                  debugPrint(response.reasonPhrase);

                                  //Close Progress Dialog
                                  //check if mounted
                                  if (!context.mounted) return;
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                }
                              } catch (e) {
                                //check if mounted
                                if (!context.mounted) return;

                                //Close Progress Dialog
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

                                debugPrint('Error: ${e.toString()}');
                              }
                            } else {
                              debugPrint('Invalid');
                            }
                          },
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: AppTheme.fadeGradientDivider(
                          Alignment.centerRight,
                          Alignment.centerLeft,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'OR',
                        style: AppTheme.text16(),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: AppTheme.fadeGradientDivider(
                          Alignment.centerLeft,
                          Alignment.centerRight,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: AppTheme.outlinedContainer(
                          const Image(
                            width: 30,
                            height: 30,
                            image: AssetImage('assets/icons/google.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: AppTheme.outlinedContainer(
                          const Image(
                            width: 30,
                            height: 30,
                            image: AssetImage('assets/icons/apple.png'),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),
                  SizedBox(
                    height: 20,
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: AppTheme.text18(),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: AppTheme.text18BlueBold(),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.go('/welcome/signin'),
                          ),
                        ],
                      ),
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
