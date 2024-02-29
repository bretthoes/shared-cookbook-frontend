import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/register/register.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  // TODO update page to use all app styles, fonts, colors, and localizations
  // Possibly
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/background_image.png',
            fit: BoxFit.cover,
          ),

          Positioned(
            top: 64.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Continue as guest",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
