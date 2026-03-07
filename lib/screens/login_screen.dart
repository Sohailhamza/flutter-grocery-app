import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [

          Image.asset(
            "assets/images/login.png",
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                const Text(
                  "Welcome back!",
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
                  child: const Text("Login"),
                )

              ],
            ),
          )

        ],
      ),
    );
  }
}