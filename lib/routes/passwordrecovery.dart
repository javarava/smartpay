import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/src/widgets.dart';
import '/src/theme.dart';
import '/routes/passwordrecoverymethod.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  //Define variables
  final passwordRecoveryFormKey = GlobalKey<FormBuilderState>();
  final passwordRecoveryEmailFieldKey = GlobalKey<FormBuilderFieldState>();

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
                //title: const Text('Password Recovery'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  const SizedBox(
                    width: 100,
                    height: 100,
                    child: Image(
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/icons/account-lock-icon.png'),
                    ),
                  ),

                  const SizedBox(height: 30),

                  //Rich header text
                  richHeaderTextBlueMiddle(
                    'Password Recovery',
                    null,
                    null,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Enter your registered email below to receive password instructions.',
                      style: AppTheme.text16Grey400(),
                    ),
                  ),
                  const SizedBox(height: 30),

                  FormBuilder(
                    key: passwordRecoveryFormKey,
                    child: Column(
                      children: [
                        SizedBox(
                          child: FormBuilderTextField(
                            key: passwordRecoveryEmailFieldKey,
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
                                  emailHasError = !(passwordRecoveryFormKey
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
                              'Send me email',
                              style: AppTheme.text18InvertedBold(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () async {
                            //Dismiss keyboard
                            FocusManager.instance.primaryFocus?.unfocus();

                            //Check internet connection
                            await checkConn(context);

                            if (passwordRecoveryFormKey.currentState
                                    ?.saveAndValidate() ??
                                false) {
                              //debugPrint('Valid');

                              //check if mounted
                              if (!context.mounted) return;

                              //Show Loading Dialog
                              showLoaderDialog(context);

                              email = passwordRecoveryFormKey
                                  .currentState!.value['email']
                                  .toString();

                              try {
                                //Request a new email address from API
                                //API does not have an endpoint to request for a new password
                                //This cound me an edge case in the authentication flow

                                //check if mounted
                                if (!context.mounted) return;

                                //Close Progress Dialog
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

                                //PUSH TO PASSWORD RECOVERY
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        PasswordRecoveryMethod(email),
                                  ),
                                );
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
