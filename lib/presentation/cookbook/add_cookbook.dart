import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class AddCookbookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('add_cookbook')),
      ),
      body: Center(),
    );
  }
}
