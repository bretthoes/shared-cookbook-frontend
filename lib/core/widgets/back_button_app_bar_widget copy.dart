import 'package:flutter/material.dart';

class NavigateToAppBar extends StatelessWidget implements PreferredSizeWidget {
  NavigateToAppBar({this.destinationPage});

  final Widget? destinationPage;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage!),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
