import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/square_button_widget.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:flutter/material.dart';

class SetPasswordScreen extends StatefulWidget {
  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(),
      body: PageView(
        children: [
          _buildPasswordPage(),
        ],
      ),
    );
  }

  Widget _buildPasswordPage() {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 32,
            left: 16,
            right: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Set your password"),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                SquareButtonWidget(
                  buttonColor: Colors.red,
                  buttonText: "Done",
                  onPressed: () {
                    // TODO validate password, send to register endpoint
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
                SizedBox(height: 8.0),
                Text(
                  "Use 6-20 characters with a mix of letters and numbers",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
