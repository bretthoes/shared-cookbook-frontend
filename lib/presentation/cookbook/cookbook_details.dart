import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/presentation/cookbook/store/cookbook_store.dart';
import 'package:boilerplate/presentation/login/store/person_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class CookbookDetailsScreen extends StatefulWidget {
  final Cookbook cookbook;
  CookbookDetailsScreen({required this.cookbook});

  @override
  _CookbookDetailsScreenState createState() => _CookbookDetailsScreenState();
}

class _CookbookDetailsScreenState extends State<CookbookDetailsScreen> {
  //stores:---------------------------------------------------------------------
  final CookbookStore _cookbookStore = getIt<CookbookStore>();
  final PersonStore _personStore = getIt<PersonStore>();
  // TODO add recipe store

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    var cookbookId = widget.cookbook.cookbookId ?? 0;
    if (!_cookbookStore.loading) {
      if (cookbookId > 0) {
        // _cookbookStore.getCookbook(widget.cookbookId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: BackButtonAppBar(
          //title: AppLocalizations.of(context).translate('add_cookbook'),
          ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: _buildColumn(),
      ),
    );
  }

  Widget _buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('Here!'),
        SizedBox(height: 32),
      ],
    );
  }
}
