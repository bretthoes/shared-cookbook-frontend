import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/cookbook/store/cookbook_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  //stores:-----------------------------------------------  ----------------------
  final CookbookStore _cookbookStore = getIt<CookbookStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        //_handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _cookbookStore.loading
            ? CustomProgressIndicatorWidget()
            : Material();
      },
    );
  }

  // Widget _handleErrorMessage() {
  //   return Observer(
  //     builder: (context) {
  //       if (_cookbookStore.errorStore.errorMessage.isNotEmpty) {
  //         return _showErrorMessage(_cookbookStore.errorStore.errorMessage);
  //       }

  //       return SizedBox.shrink();
  //     },
  //   );
  // }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}
