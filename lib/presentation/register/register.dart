import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/widgets/app_icon_widget.dart';
import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/core/widgets/rounded_button_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/service_locator.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  PageController _pageController = PageController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _verificationCodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          _buildEmailPage(),
          _buildVerificationCodePage(),
          _buildPasswordPage(),
        ],
      ),
    );
  }

  Widget _buildEmailPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16.0),
        Container(
          width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Enter your email"),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Add logic to send verification code to email
            // Move to the next page
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Text("Next"),
        ),
      ],
    );
  }

  Widget _buildVerificationCodePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16.0),
        Text("Check your email for the verification code"),
        Container(
          width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
          child: TextField(
            controller: _verificationCodeController,
            decoration: InputDecoration(labelText: "Enter verification code"),
          ),
        ),
        Spacer(), // Add Spacer to push the button to the bottom
        ElevatedButton(
          onPressed: () {
            // Add logic to verify the code
            // Move to the next page
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Text("Continue"),
        ),
      ],
    );
  }

  Widget _buildPasswordPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: "Set your password"),
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () {
            // Add logic to complete registration with the password
            // For simplicity, navigate to home page after registration
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Text("Register"),
        ),
      ],
    );
  }
}
