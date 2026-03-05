import 'package:flutter/material.dart';
import '../models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Background Image (Figma ke mutabiq full screen)
        Positioned.fill(
          child: Image.asset(
            model.image,
            fit: BoxFit.cover, // Ye image ko poori screen pe phela dega
          ),
        ),

        // 2. Content Overlay (Text section)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(height: 80), // Top margin for Status Bar
              
              if (model.title.contains("Big Cart"))
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D1D1D),
                      height: 1.2,
                    ),
                    children: [
                      TextSpan(text: "Welcome to\n"),
                      TextSpan(
                        text: "BIG CART",
                        style: TextStyle(color: Color(0xFF7CC344)),
                      ),
                    ],
                  ),
                )
              else
                Text(
                  model.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D1D1D),
                    height: 1.2,
                  ),
                ),
              
              const SizedBox(height: 15),
              
              Text(
                model.desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF868686),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}