import 'package:flutter/material.dart';
import 'package:grocery_app/screens/welcome_screen.dart';
import '../models/onboarding_model.dart';
import '../widgets/onboarding_page.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<OnboardingModel> data = [
    OnboardingModel(
      image: "assets/images/splash1.png",
      title: "Welcome to Big Cart",
      desc:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy",
    ),
    OnboardingModel(
      image: "assets/images/splash2.png",
      title: "Buy Quality Dairy Products",
      desc:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy",
    ),
    OnboardingModel(
      image: "assets/images/splash3.png",
      title: "Buy Premium Quality Fruits",
      desc:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy",
    ),
    OnboardingModel(
      image: "assets/images/splash4.png",
      title: "Get Discounts On All Products",
      desc:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: data.length,
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemBuilder: (context, index) {
              return OnboardingPage(model: data[index]);
            },
          ),

          // Dots Indicator
          Positioned(
            bottom: 115,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                data.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? const Color(0xFF7CC344)
                        : const Color(0xFFE0E0E0),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),

          // Action Button
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                if (currentIndex == data.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  );
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFAEDC81), Color(0xFF7CC344)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Text(
                  "Get started",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
