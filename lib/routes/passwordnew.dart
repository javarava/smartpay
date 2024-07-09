import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '/src/widgets.dart';
import '/src/theme.dart';
import '/routes/signin.dart';

Map? loggedinUser;
String? userEmail;
String? userID;

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  //Define variables
  final setPasswordFormKey = GlobalKey<FormBuilderState>();
  final passwordOneFieldKey = GlobalKey<FormBuilderFieldState>();
  final passwordTwoFieldKey = GlobalKey<FormBuilderFieldState>();

  bool passwordOneHasError = false;
  bool passwordTwoHasError = false;

  final passwordOneController = TextEditingController();
  final passwordTwoController = TextEditingController();

  bool passwordVisible = true;

  bool formValid = false;

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
                    'Create New Password',
                    null,
                    null,
                  ),

                  const SizedBox(height: 30),

                  FormBuilder(
                    key: setPasswordFormKey,
                    child: Column(
                      children: [
                        //PASSWORD ONE

                        SizedBox(
                          child: FormBuilderTextField(
                            name: 'passwordone',
                            controller: passwordOneController,
                            obscureText: passwordVisible,
                            obscuringCharacter: '•',
                            style: AppTheme.text16(),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Password',
                              border: AppTheme.noInputBorder(),
                              enabledBorder: AppTheme.noInputBorder(),
                              focusedBorder: AppTheme.smartpayFocusedBorder(),
                              errorBorder: AppTheme.errorBorderRed(),
                              focusedErrorBorder: AppTheme.errorBorderRed(),
                              contentPadding: const EdgeInsets.all(16),
                              filled: true,
                              fillColor: smartpayBlack.shade50,
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(
                                    () {
                                      passwordVisible = !passwordVisible;
                                    },
                                  );
                                },
                              ),
                              alignLabelWithHint: false,
                            ),

                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: 'Please provide a password'),
                              ],
                            ),

                            //Using TextEditingCotrollers to enable Continue button
                            onChanged: (value) {
                              setState(() {
                                if ((passwordOneController.text.isNotEmpty &&
                                        passwordTwoController
                                            .text.isNotEmpty) ||
                                    (passwordOneController.text ==
                                        passwordTwoController.text)) {
                                  formValid = true;
                                } else {
                                  formValid = false;
                                }
                              });
                            },
                            // Set keyboard style
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),

                        const SizedBox(height: 20),

                        //PASSWORD TWO

                        SizedBox(
                          child: FormBuilderTextField(
                            name: 'passwordtwo',
                            controller: passwordTwoController,
                            obscureText: passwordVisible,
                            obscuringCharacter: '•',
                            style: AppTheme.text16(),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Confirm password',
                              border: AppTheme.noInputBorder(),
                              enabledBorder: AppTheme.noInputBorder(),
                              focusedBorder: AppTheme.smartpayFocusedBorder(),
                              errorBorder: AppTheme.errorBorderRed(),
                              focusedErrorBorder: AppTheme.errorBorderRed(),
                              contentPadding: const EdgeInsets.all(16),
                              filled: true,
                              fillColor: smartpayBlack.shade50,
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(
                                    () {
                                      passwordVisible = !passwordVisible;
                                    },
                                  );
                                },
                              ),
                              alignLabelWithHint: false,
                            ),

                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: 'Please provide a password'),
                              ],
                            ),

                            //Using TextEditingCotrollers to enable Continue button
                            onChanged: (value) {
                              setState(() {
                                if ((passwordOneController.text.isNotEmpty &&
                                        passwordTwoController
                                            .text.isNotEmpty) &&
                                    (passwordOneController.text ==
                                        passwordTwoController.text)) {
                                  formValid = true;
                                } else {
                                  formValid = false;
                                }
                              });
                            },
                            // Set keyboard style
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),

                        const SizedBox(height: 80),

                        //CONTINUE BUTTON
                        formValid == true
                            ? InkWell(
                                child: AppTheme.blackContainer(
                                  Text(
                                    'Create new password',
                                    style: AppTheme.text18InvertedBold(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onTap: () async {
                                  //Dismiss keyboard
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  //Check internet connection
                                  await checkConn(context);

                                  if (setPasswordFormKey.currentState
                                          ?.saveAndValidate() ??
                                      false) {
                                    //debugPrint('Valid');

                                    //Show Loading Dialog
                                    //check if mounted
                                    if (!context.mounted) return;
                                    showLoaderDialog(context);

                                    String passwordOne = setPasswordFormKey
                                        .currentState!.value['passwordone']
                                        .toString();

                                    String passwordTwo = setPasswordFormKey
                                        .currentState!.value['passwordtwo']
                                        .toString();

                                    //PUSH TO SIGN IN
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const SignIn(),
                                      ),
                                    );
                                  } else {
                                    debugPrint('Invalid');
                                  }
                                },
                              )
                            : AppTheme.grayContainer(
                                Text(
                                  'Create new password',
                                  style: AppTheme.text18InvertedBold(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
