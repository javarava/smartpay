import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/src/navigation.dart';
import '/src/widgets.dart';
import '/src/theme.dart';
import '/src/datastorage.dart';

Map? loggedinUser;
String? userEmail;
String? userID;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final signinFormKey = GlobalKey<FormBuilderState>();
  final signinEmailFieldKey = GlobalKey<FormBuilderFieldState>();

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
                //title: const Text('Signin'),
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
                      'Hi There 👋',
                      style: AppTheme.text28ExtraBold(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Welcome back. Sign in to your account.',
                      style: AppTheme.text16Grey400(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FormBuilder(
                    key: signinFormKey,
                    child: Column(
                      children: [
                        SizedBox(
                          child: FormBuilderTextField(
                            key: signinEmailFieldKey,
                            name: 'email',
                            initialValue: initialEmail,
                            style: AppTheme.text16(),
                            decoration:
                                AppTheme.smartpayInputDecoration('Email'),

                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText:
                                        'Please provide your email address'),
                                FormBuilderValidators.email(),
                              ],
                            ),
                            onChanged: (val) {
                              setState(
                                () {
                                  emailHasError = !(signinFormKey
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

                        const SizedBox(height: 20),
                        SizedBox(
                          child: FormBuilderTextField(
                            name: 'password',
                            controller: passwordController,
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
                            // Set keyboard style
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),

                        const SizedBox(height: 30),

                        //FORGOT PASSWORD
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            child: SizedBox(
                              child: Text(
                                'Forgot password?',
                                style: AppTheme.text18BlueBold(),
                              ),
                            ),
                            onTap: () async {
                              //Show Reset Password dialog
                            },
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
                                'Sign In',
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

                            if (signinFormKey.currentState?.saveAndValidate() ??
                                false) {
                              //debugPrint('Valid');

                              //Show Loading Dialog
                              //check if mounted
                              if (!context.mounted) return;
                              showLoaderDialog(context);

                              email = signinFormKey.currentState!.value['email']
                                  .toString();

                              password = signinFormKey
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
                        text: 'Don\'t have an account? ',
                        style: AppTheme.text18(),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: AppTheme.text18BlueBold(),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.go('/welcome/signup'),
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
