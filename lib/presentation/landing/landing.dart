import 'package:boilerplate/core/widgets/square_button_widget.dart';
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
                SquareButtonWidget(
                  buttonColor: Colors.red,
                  buttonText: "Sign in",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
                SizedBox(height: 16.0),
                SquareButtonWidget(
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  buttonText: "Create an account",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  "Skip",
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
