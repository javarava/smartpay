import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '/src/theme.dart';

Map? loggedinUser;
String? userEmail;
String? userID;

class SignUpComplete extends StatefulWidget {
  const SignUpComplete({super.key});

  @override
  State<SignUpComplete> createState() => _SignUpCompleteState();
}

class _SignUpCompleteState extends State<SignUpComplete>{
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          //height:double.infinity,
          //Align container vertically to center of screen
          alignment: const Alignment(0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Lottie Animation
              SizedBox(
                width: double.infinity,
                child: Lottie.asset(
                  'assets/animations/thumbs-up.json',
                  width: 200,
                  height: 200,
                  animate: true,
                  repeat: false,
                  
                
                ),
              ),
              const SizedBox(height: 20),

              //TODO: GET NAME FROM PROVIDER
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Congratulations, ',
                  style: AppTheme.text28ExtraBold(),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: Text(
                  'You\'ve completed the onboarding. You can start using ${AppTheme.appTitle()}.',
                  style: AppTheme.text16GraySpaced(),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 60),

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
    );
  }
}
