import 'package:flutter/material.dart';

class SquareButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color buttonColor;
  final Color textColor;
  final FontWeight fontWeight;
  final Color? borderColor;
  final String? imagePath;
  final double buttonTextSize;
  final double? height;
  final VoidCallback? onPressed;
  final ShapeBorder shape;
  final double width;

  // TODO add default styles that are darkmode compatible
  const SquareButtonWidget({
    Key? key,
    this.buttonText,
    required this.buttonColor,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.onPressed,
    this.imagePath,
    this.borderColor,
    this.shape = const StadiumBorder(),
    this.buttonTextSize = 16.0,
    this.height = 56,
    this.width = 600,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        key: this.key,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(this.buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            imagePath != null
                ? Image.asset(
                    imagePath!,
                    height: 15.0,
                  )
                : SizedBox.shrink(),
            SizedBox(width: 5.0),
            Text(
              buttonText!,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: textColor,
                fontWeight: fontWeight,
                fontSize: buttonTextSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
