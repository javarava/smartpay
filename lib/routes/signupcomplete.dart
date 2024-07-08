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

class SignUpComplete extends StatefulWidget {
  const SignUpComplete({super.key});

  @override
  State<SignUpComplete> createState() => _SignUpCompleteState();
}

class _SignUpCompleteState extends State<SignUpComplete> {
  final signUpPinFormKey = GlobalKey<FormBuilderState>();

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
      border: Border.all(color: smartpayBlack.shade50),
      borderRadius: BorderRadius.circular(15),
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
                shadowColor: Colors.white,
                leading: AppTheme.sliverAppBarBackLeading(context),
              ),
            ];
          },
          body: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            //Align container vertically to center of screen
            alignment: const Alignment(0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                //Get Stated Button
                InkWell(
                  child: AppTheme.blackContainer(
                    Text(
                      'Get Started',
                      style: AppTheme.text18InvertedBold(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () async {
                    //PUSH TO HOME
                    //check if mounted
                    if (!context.mounted) return;

                    context.go('/');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
