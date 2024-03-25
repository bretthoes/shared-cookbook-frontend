import 'package:boilerplate/core/widgets/square_button_widget.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/register/set_email.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
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
                  buttonText: AppLocalizations.of(context).translate('sign_in'),
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
                  buttonText: AppLocalizations.of(context)
                      .translate('create_an_account'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SetEmailScreen()),
                    );
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  AppLocalizations.of(context).translate('skip'),
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
