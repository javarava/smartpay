import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/src/theme.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          width: double.infinity,
          //height: double.infinity,
          alignment: const Alignment(0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const SizedBox(height: 80),
              const SizedBox(
                width: double.infinity,
                height: 150,
                child: Image(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/smartpay.png'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'The safest and most trusted finance app',
                  style: AppTheme.text22ExtraBold(),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: Text(
                  'Your finance work starts here. We are here to help you track and deal with speeding up your transactions.',
                  style: AppTheme.text14(),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              //REGISTER
              InkWell(
                child: AppTheme.blackContainer(
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Register',
                      style: AppTheme.text16InvertedBold(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  context.go('/welcome/register');
                },
              ),

              const SizedBox(height: 20),

              //SIGNIN
              InkWell(
                child: AppTheme.greyGradientContainer(
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Sign In',
                      style: AppTheme.text16Bold(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  context.go('/welcome/signin');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
