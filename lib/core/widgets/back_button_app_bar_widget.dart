import 'package:flutter/material.dart';

class BackButtonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  BackButtonAppBar({this.title = ''});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
