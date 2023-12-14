import 'package:flutter/material.dart';

import 'package:CareCompanion/screens/home_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: slidesList.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardContent(
                      image: slidesList[index].image,
                      title: slidesList[index].title,
                      description: slidesList[index].description,
                      buttonText: slidesList[index].buttonText,
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(100, 0, 100, 100),
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            _pageController.nextPage(
                                curve: Curves.ease,
                                duration: const Duration(milliseconds: 450));

                            print('Onboarding Screen $_pageIndex pressed');

                            if (_pageIndex == slidesList.length - 1) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Onboard {
  final String image, title, description, buttonText;

  Onboard({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}

final List<Onboard> slidesList = [
  Onboard(
    image: 'assets/images/beatrizHeadshot.png',
    title: 'Hola! My name is Beatriz',
    description:
        'I’m part of a family of virtual caregivers at Embodied Labs, where we’re transforming the way you care.',
    buttonText: 'Next',
  ),
  Onboard(
    image: 'assets/images/alfredHeadshot.png',
    title: 'We’re here to connect',
    description:
        'Speaking with you and your loved ones to help answer questions during periods of transitional care.',
    buttonText: 'Next',
  ),
  Onboard(
    image: 'assets/images/dimaHeadshot.png',
    title: 'Join our growing family',
    description:
        'We cover an ever-expanding range of topics from healthcare to government services.',
    buttonText: 'Next',
  ),
  Onboard(
    image: 'assets/images/clayHeadshot.png',
    title: 'Let’s get started',
    description: 'But before we begin, I would love to learn more about you!',
    buttonText: 'Let’s go!',
  ),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  final String image, title, description, buttonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            image,
            width: 180,
          ),
          //const Spacer(),\
          const SizedBox(height: 40),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(
            height: 20,
          ),
          Text(description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              )),
          const Spacer(),
        ],
      ),
    );
  }
}
