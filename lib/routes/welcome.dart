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
  int current = 0;
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    //Carousel Slider list
    final List<Widget> widgetSliders = scrollItems
        .map(
          (item) => item,
        )
        .toList();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Skip button
                InkWell(
                  child: Padding(
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
                  onTap: () {
                    context.go('/welcome/signin');
                  },
                ),

                //Using Carousel Sliders to display onboarding widgets

                SizedBox(
                  height: 600,
                  child: CarouselSlider(
                    items: widgetSliders,
                    carouselController: controller,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: false,
                      aspectRatio: 1.0,
                      viewportFraction: 1.0,
                      autoPlayInterval: const Duration(seconds: 8),
                      //clipBehavior: Clip.none,
                      disableCenter: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          current = index;
                        });
                      },
                    ),
                  ),
                ),
                //Carousel indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: scrollItems.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () => controller.animateToPage(entry.key),
                        child: current == entry.key //Check if entry is the current slide
                            ? Container(
                                width: 30.0,
                                height: 6.0,
                                decoration: BoxDecoration(
                                  //shape: BoxShape.circle,
                                  color: smartpayBlack.shade700,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 2.0),
                              )
                            : Container(
                                width: 6.0,
                                height: 6.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: smartpayBlack.shade200,
                                ),
                              ),
                      );
                    },
                  ).toList(),
                ),

                const SizedBox(height: 50),

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
                      context.go('/welcome/signin');
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Define list of scrollable items
final List<Widget> scrollItems = [
  scrollItem1(),
  scrollItem2(),
];

//Scrollable item 1
scrollItem1() {
  return Column(
    children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 400,
        //alignment: const Alignment(0, 0),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              width: 300,
              height: 400,
              //color: smartpayCream.shade300,
              child: const Image(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/images/onboarding1-phone1.png'),
              ),
            ),
            Positioned(
              bottom: 30,
              child: Container(
                width: 300,
                height: 80,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(0, 253, 252, 252),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const SizedBox(height: 80),
              ),
            ),
            const Positioned(
              top: 45.0,
              child: SizedBox(
                width: 380,
                height: 380,
                child: Image(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/onboarding1-charts.png'),
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
      //const SizedBox(height: 20),
    ],
  );
}

scrollItem2() {
  return Column(
    children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 400,
        //alignment: const Alignment(0, 0),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              width: 300,
              height: 400,
              //color: smartpayCream.shade300,
              child: const Image(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/images/onboarding2-phone1.png'),
              ),
            ),
            Positioned(
              bottom: 30,
              child: Container(
                width: 300,
                height: 80,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(0, 253, 252, 252),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const SizedBox(height: 80),
              ),
            ),
            const Positioned(
              top: 45.0,
              child: SizedBox(
                width: 380,
                height: 380,
                child: Image(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/onboarding2-charts.png'),
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
            'Your transactions processed faster than ever',
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
            'Pay all your bills effortlessly in just a few steps. Paying your bills has never been faster or more efficient.',
            style: AppTheme.text16GraySpaced(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      //const SizedBox(height: 20),
    ],
  );
}
