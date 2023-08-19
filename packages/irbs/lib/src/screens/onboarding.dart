import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irbs/src/globals/my_fonts.dart';
import '../globals/colors.dart';
import '../globals/styles.dart';
import '../widgets/onboarding/nav_dots.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int activeIndex = 0;

  List<String> headingList = [
    "IRBS",
    "Select a Room",
    "Book a Room",
    "Manage Your\nBookings",
    "You're Ready to Go!"
  ];
  List<String> textList = [
    "book rooms for your club meetings\nand events hassle-free.",
    "Explore a wide range of rooms\navailable for booking, including\nclub rooms and common rooms.",
    "Select your desired room, choose\nthe date and time, and provide the\npurpose of your booking.",
    "Track the status of your booking\nrequests, view approved bookings.",
    "Start booking rooms for your club\nevents and meetings with ease."
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.29,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    headingList[activeIndex],
                    textAlign: TextAlign.center,
                    style: MyFonts.w700.size(28).setColor(Themes.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    textList[activeIndex],
                    textAlign: TextAlign.center,
                    style: MyFonts.w400.size(14).setColor(Themes.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.52,
            // child: Image(
            //   image: ResizeImage(img,height: (MediaQuery.of(context).size.height * 0.52).toInt(),),
            // ),
            child: SvgPicture.asset('assets/onboarding_${activeIndex + 1}.svg', package: 'irbs'),
          ),
          SizedBox(
            height: 0.04 * MediaQuery.of(context).size.height,
          ),
          SizedBox(
            height: 0.07 * MediaQuery.of(context).size.height,
            width: 0.75 * MediaQuery.of(context).size.width,
            child: (activeIndex != 4)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              activeIndex = 4;
                            });
                          },
                          child: Text(
                            'Skip',
                            style: MyFontsRaleway.w400.size(12).setColor(Themes.blueGrey),
                          )),
                      SizedBox(
                        height: 6,
                        width: 72,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NavDot(isActive: activeIndex == 0),
                            NavDot(isActive: activeIndex == 1),
                            NavDot(isActive: activeIndex == 2),
                            NavDot(isActive: activeIndex == 3),
                            NavDot(isActive: activeIndex == 4),
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              activeIndex++;
                            });
                          },
                          child: Text(
                            'Next',
                            // style: textButtonStyle1,
                            style: MyFontsRaleway.w400.size(12).setColor(Themes.white),
                          ))
                    ],
                  )
                : Center(
                    child: SizedBox(
                      width: 0.5 * MediaQuery.of(context).size.width,
                      height: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/irbs/home');
                          },
                          style: elevatedButtonStyle,
                          child: Text(
                            "Start Booking",
                            style: MyFontsRaleway.w700.size(16),
                          )),
                    ),
                  ),
          )
        ],
      )),
    );
  }
}
