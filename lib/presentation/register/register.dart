import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/square_button_widget.dart';
import 'package:boilerplate/presentation/register/email_verification.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(),
      body: PageView(
        children: [
          _buildEmailPage(),
        ],
      ),
    );
  }

  Widget _buildEmailPage() {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 32.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Enter your email"),
                  ),
                ),
                SizedBox(height: 16.0),
                SquareButtonWidget(
                  buttonColor: Colors.red,
                  buttonText: "Next",
                  onPressed: () {
                    // TODO check if email is taken, if not send
                    // verification and redirect to verification page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmailVerificationScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
