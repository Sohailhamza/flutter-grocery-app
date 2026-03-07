import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
   const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [

          Image.asset(
            "assets/images/signup.png",
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                const Text(
                  "Create account",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height:20),

                TextField(
                  decoration: InputDecoration(
                    hintText: "Email Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height:15),

                TextField(
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height:15),

                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height:20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity,50),
                  ),
                  onPressed: () {},
                  child: const Text("Signup"),
                )

              ],
            ),
          )

        ],
      ),
    );
  }
}