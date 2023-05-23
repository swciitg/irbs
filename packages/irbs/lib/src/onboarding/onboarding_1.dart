import 'package:flutter/material.dart';
import 'package:irbs/widgets/nav_dots.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

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

    ImageProvider img = AssetImage('assets/onboarding_${activeIndex + 1}.png', package: 'irbs');

    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 28, 30, 1),
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Montserrat',
                        package: 'irbs',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      textList[activeIndex],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        package: 'irbs',
                        color: Colors.white,
                        fontSize: 14, 
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.52,
              child: Image(
                image: img,
                
              ),
            ),
            SizedBox(height: 0.04 * MediaQuery.of(context).size.height,),
            SizedBox(
              height: 0.07 * MediaQuery.of(context).size.height,
              width: 0.75 * MediaQuery.of(context).size.width,
              child: (activeIndex != 4)
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: (){
                      setState(() {
                        activeIndex = 4;
                      });
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Raleway',
                        package: 'irbs',
                        fontStyle: FontStyle.normal,
                        color: Color.fromRGBO(110, 119, 138, 1),
                      ),
                    )
                  ),
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
                    onPressed: (){
                      setState(() {
                        activeIndex++;
                      });
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Raleway',
                        package: 'irbs',
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                    )
                  )
                ],
              )
              : Center(
                child: SizedBox(
                  width: 0.5 * MediaQuery.of(context).size.width,
                  height: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(118, 172, 255, 1)),
                      foregroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 27, 62, 1)),
                    ),
                    child: const Text(
                      "Start Booking",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        package: 'irbs',
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}