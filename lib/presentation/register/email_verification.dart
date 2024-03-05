import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/square_button_widget.dart';
import 'package:boilerplate/presentation/register/set_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// OBSOLETE this is an intermittent class for register workflow that is not
//currently functional. to be rewritten when sending emails is viable
class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(),
      body: PageView(
        children: [
          _buildVerificationCodePage(),
        ],
      ),
    );
  }

  Widget _buildVerificationCodePage() {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 32,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.0),
                Container(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      // You can add more formatters or constraints as needed
                    ],
                    decoration: InputDecoration(
                      labelText: 'Enter verification code',
                      hintText: '000000', // Optional placeholder text
                    ),
                    onChanged: (value) {
                      // Handle the value change
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                SquareButtonWidget(
                  buttonColor: Colors.red,
                  buttonText: "Next",
                  onPressed: () {
                    //  validate code sent via email
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetPasswordScreen(email: "")),
                    );
                  },
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
