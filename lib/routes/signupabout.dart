import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/scheduler.dart';
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

class SignUpAbout extends StatefulWidget {
  const SignUpAbout({super.key});

  @override
  State<SignUpAbout> createState() => _SignUpAboutState();
}

class _SignUpAboutState extends State<SignUpAbout> {
  //Define variables
  final signUpAboutFormKey = GlobalKey<FormBuilderState>();
  final signUpFullNameFieldKey = GlobalKey<FormBuilderFieldState>();
  final signUpUserameFieldKey = GlobalKey<FormBuilderFieldState>();

  bool fullNameHasError = false;
  bool usernameHasError = false;
  bool countryHasError = false;
  bool passwordHasError = false;

  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisible = true;

  bool formValid = false;

  String fullName = '';
  String username = '';
  String country = '';
  String password = '';

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        //Get current address coords
        setProviders();
      },
    );
  }

  void setProviders() async {
    context.read<UserProvider>().setNewCountry({});
  }

  @override
  Widget build(BuildContext context) {
    //Get data from provider
    Map providerCountry = context.watch<UserProvider>().country;

    final ccountry = TextEditingController(text: providerCountry['country']);

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
                    'Hey there! Tell us a bit about ',
                    'yourself',
                    null,
                  ),

                  const SizedBox(height: 30),

                  FormBuilder(
                    key: signUpAboutFormKey,
                    child: Column(
                      children: [
                        //FULL NAME
                        SizedBox(
                          child: FormBuilderTextField(
                            key: signUpFullNameFieldKey,
                            controller: fullNameController,
                            name: 'fullname',
                            style: AppTheme.text16(),
                            decoration:
                                AppTheme.smartpayInputDecoration('Full name'),

                            //Validates email
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: 'Please provide your full name'),
                                FormBuilderValidators.required(),
                              ],
                            ),
                            //Using TextEditingCotrollers to enable Continue button
                            onChanged: (value) {
                              setState(() {
                                if (fullNameController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty &&
                                    providerCountry.isNotEmpty) {
                                  formValid = true;
                                } else {
                                  formValid = false;
                                }
                              });
                            },

                            // set keyboard tyle
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),

                        const SizedBox(height: 20),

                        //USERNAME
                        SizedBox(
                          child: FormBuilderTextField(
                            key: signUpUserameFieldKey,
                            controller: usernameController,
                            name: 'username',

                            style: AppTheme.text16(),
                            decoration:
                                AppTheme.smartpayInputDecoration('Username'),

                            //Validates email
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: 'Please provide a username'),
                                FormBuilderValidators.required(),
                              ],
                            ),
                            //Using TextEditingCotrollers to enable Continue button
                            onChanged: (value) {
                              setState(() {
                                if (fullNameController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty &&
                                    providerCountry.isNotEmpty) {
                                  formValid = true;
                                } else {
                                  formValid = false;
                                }
                              });
                            },

                            // set keyboard tyle
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),

                        const SizedBox(height: 20),

                        //COUNTRY
                        //TODO: CHANGE COUNTRY TEXTFIELD TO A CONTAINER OF ROWS TO ACCOMODATE FLAG
                        SizedBox(
                          width: double.infinity,
                          child: FormBuilderTextField(
                            name: 'country',
                            style: AppTheme.text16(),
                            decoration:
                                AppTheme.smartpayInputDecorationWithSuffix(
                              'Select Country',
                              Icon(
                                MdiIcons.fromString('chevron_down'),
                                size: 28,
                                color: smartpayBlack.shade300,
                              ),
                            ),
                            controller: ccountry,
                            enableInteractiveSelection: false,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              setState(() {
                                if (fullNameController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty &&
                                    providerCountry.isNotEmpty) {
                                  formValid = true;
                                } else {
                                  formValid = false;
                                }
                              });
                            },
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());

                              //Display ButtomSheet
                              showCountriesButtomSheet(context);
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        //PASSWORD

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

                            //Using TextEditingCotrollers to enable Continue button
                            onChanged: (value) {
                              setState(() {
                                if (fullNameController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
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

                        const SizedBox(height: 30),

                        //CONTINUE BUTTON
                        formValid == true
                            ? InkWell(
                                child: AppTheme.blackContainer(
                                  Text(
                                    'Continue',
                                    style: AppTheme.text18InvertedBold(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onTap: () async {
                                  //Dismiss keyboard
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  //Check internet connection
                                  await checkConn(context);

                                  if (signUpAboutFormKey.currentState
                                          ?.saveAndValidate() ??
                                      false) {
                                    //debugPrint('Valid');

                                    //Show Loading Dialog
                                    //check if mounted
                                    if (!context.mounted) return;
                                    showLoaderDialog(context);

                                    fullName = signUpAboutFormKey
                                        .currentState!.value['fullname']
                                        .toString();

                                    username = signUpAboutFormKey
                                        .currentState!.value['username']
                                        .toString();

                                    password = signUpAboutFormKey
                                        .currentState!.value['password']
                                        .toString();

                                    //Close Progress Dialog
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();

                                    //PUSH TO SIGNUP OTP
                                    //check if mounted
                                    if (!context.mounted) return;
                                    /* Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      SignUpOtp(email),
                                ),
                              ); */

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
                              )
                            : AppTheme.grayContainer(
                                Text(
                                  'Continue',
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

//Countries ButtomSheet

showCountriesButtomSheet(context) {
  TextEditingController searchController = TextEditingController();

  String searchText = '';

  return showModalBottomSheet<void>(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // implement the search field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          height: 60,
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                            style: AppTheme.text16(),
                            decoration:
                                AppTheme.smartpayInputDecorationWithPrefix(
                                    'Search', const Icon(Icons.search)),
                            onSubmitted: (value) {
                              //perform search
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // This button is used to close the modal
                      InkWell(
                          onTap: () {
                            //Close buttom sheet
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: AppTheme.text18Bold(),
                          )),
                      //const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        countryRow(
                          context,
                          const AssetImage('assets/icons/flag_us.png'),
                          'US',
                          'United States',
                        ),
                        countryRow(
                          context,
                          const AssetImage('assets/icons/flag_gb.png'),
                          'GB',
                          'United Kingdom',
                        ),
                        countryRow(
                          context,
                          const AssetImage('assets/icons/flag_sg.png'),
                          'SG',
                          'Singapore',
                        ),
                        countryRow(
                          context,
                          const AssetImage('assets/icons/flag_cn.png'),
                          'CN',
                          'China',
                        ),
                        countryRow(
                          context,
                          const AssetImage('assets/icons/flag_nl.png'),
                          'NL',
                          'Netherland',
                        ),
                        countryRow(
                          context,
                          const AssetImage('assets/icons/flag_id.png'),
                          'ID',
                          'Indonesia',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

//Display countries
//Using StatefullBuilder to setState
countryRow(context, AssetImage flag, String countryCode, String country) {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      String selectedCountry = context.read<UserProvider>().country['code'];
      return InkWell(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: selectedCountry == countryCode
              ? BoxDecoration(
                  color: smartpayBlack.shade100,
                  borderRadius: BorderRadius.circular(15),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
          width: double.infinity,
          child: Row(
            children: [
              Image(
                width: 30,
                height: 30,
                image: flag,
              ),
              const SizedBox(width: 20),
              Text(countryCode, style: AppTheme.text18Grey400()),
              const SizedBox(width: 20),
              Expanded(
                child: Text(country, style: AppTheme.text18Bold()),
              ),
              //Display check if country is selected
              selectedCountry == countryCode
                  ? const Icon(
                      Icons.check,
                      size: 26,
                      color: Colors.green,
                    )
                  : const SizedBox(),
              const SizedBox(width: 10),
            ],
          ),
        ),
        onTap: () {
          //Close buttomsheet
          Navigator.pop(context);

          //Set country in Provider
          setState(() {
            context.read<UserProvider>().setNewCountry({
              'flag': flag,
              'code': countryCode,
              'country': country,
            });
          });
        },
      );
    },
  );
}