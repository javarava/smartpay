import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            width: double.infinity,
            //height: double.infinity,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //const SizedBox(height: 80),
                /*const SizedBox(
                width: double.infinity,
                height: 150,
                child: Image(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/onboarding1-phone1.png'),
                ),
              ),
              const SizedBox(height: 20),*/
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Text(
                      'Skip',
                      style: AppTheme.text18BlueBold(),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),

                //Stacked images

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: const Alignment(0, 0),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        width: 300,
                        height: 400,
                        //color: smartpayCream.shade300,
                        child: const Image(
                          fit: BoxFit.fitWidth,
                          image: AssetImage(
                              'assets/images/onboarding1-phone1.png'),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        child: Container(
                          width: 300,
                          height: 80,
                          
                          decoration: const BoxDecoration(
                            
                            gradient:  LinearGradient(
                              colors: [
                                Color.fromARGB(0, 253, 252, 252),
                                Color.fromARGB(255, 255, 255, 255),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child:  const SizedBox(height: 80),
                        ),
                      ),
                      const Positioned(
                        top: 45.0,
                        child: SizedBox(
                          width: 380,
                          height: 380,
                          child: Image(
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                                'assets/images/onboarding1-charts.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'The safest and most trusted finance app',
                      style: AppTheme.text28ExtraBold(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Your finance work starts here. We are here to help you track and deal with speeding up your transactions.',
                      style: AppTheme.text16GraySpaced(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                //REGISTER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    child: AppTheme.blackContainer(
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        child: Text(
                          'Get Started',
                          style: AppTheme.text18InvertedBold(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onTap: () {
                      context.go('/welcome/register');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
