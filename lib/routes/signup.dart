import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/src/widgets.dart';
import '/src/theme.dart';
import '/src/datastorage.dart';
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
  final signUpFormKey = GlobalKey<FormBuilderState>();
  final signUpEmailFieldKey = GlobalKey<FormBuilderFieldState>();

  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  bool emailHasError = false;
  bool passwordHasError = false;

  final passwordController = TextEditingController();
  bool passwordVisible = true;

  String email = '';
  String password = '';

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
                  SizedBox(
                    width: double.infinity,
                    child: RichText(
                      text: TextSpan(
                        text: 'Create a ',
                        style: AppTheme.text28ExtraBold(),
                        children: [
                          TextSpan(
                            text: 'Smartpay \n',
                            style: AppTheme.text28BlueExtraBold(),
                          ),
                          const TextSpan(
                            text: 'account',
                          ),
                        ],
                      ),
                    ),
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
                              //Check if email is valid
                              setState(
                                () {
                                  emailHasError = !(signUpFormKey
                                          .currentState?.fields['email']
                                          ?.validate() ??
                                      false);
                                },
                              );
                            },
                            // set keyboard tyle
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                        ),

                        const SizedBox(height: 30),

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

                            if (signUpFormKey.currentState?.saveAndValidate() ??
                                false) {
                              //debugPrint('Valid');

                              //Show Loading Dialog
                              //check if mounted
                              if (!context.mounted) return;
                              showLoaderDialog(context);

                              email = signUpFormKey.currentState!.value['email']
                                  .toString();

                              password = signUpFormKey
                                  .currentState!.value['password']
                                  .toString();

                              try {} catch (e) {
                                //Close Progress Dialog
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

                                debugPrint('Error: ${e.toString()}');
                              }
                            } else {
                              debugPrint('Invalid');
                            }

                            //TODO: REMOVE TEMP PUSHS
                            Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  const SignUpOtp(),
                                            ),
                                          );
                          },
                        ),

                        const SizedBox(height: 40),

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
                      ],
                    ),
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
