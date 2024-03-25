import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/cookbook/cookbook_details.dart';
import 'package:boilerplate/presentation/cookbook/store/cookbook_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CookbookListScreen extends StatefulWidget {
  @override
  _CookbookListScreenState createState() => _CookbookListScreenState();
}

class _CookbookListScreenState extends State<CookbookListScreen> {
  //stores:---------------------------------------------------------------------
  final CookbookStore _cookbookStore = getIt<CookbookStore>();
  final UserStore _loginStore = getIt<UserStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    if (!_cookbookStore.loading) {
      var personId = _loginStore.person?.personId ?? 0;
      if (personId > 0) {
        _cookbookStore.getCookbooks(personId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _cookbookStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildListView());
      },
    );
  }

  Widget _buildListView() {
    return _cookbookStore.cookbookList?.cookbooks != null
        ? ListView.separated(
            itemCount: _cookbookStore.cookbookList!.cookbooks.length,
            separatorBuilder: (context, position) {
              return Divider();
            },
            itemBuilder: (context, position) {
              return _buildListItem(position);
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('no_cookbooks_yet'),
            ),
          );
  }

  Widget _buildListItem(int position) {
    return ListTile(
      dense: true,
      leading: Icon(Icons.cloud_circle),
      title: Text(
        '${_cookbookStore.cookbookList?.cookbooks[position].title}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CookbookDetailsPage(
                    cookbookId: _cookbookStore
                            .cookbookList?.cookbooks[position].cookbookId ??
                        0)));
      },
      // subtitle: Text(
      //   '${_cookbookStore.cookbookList?.cookbooks?[position].body}',
      //   maxLines: 1,
      //   overflow: TextOverflow.ellipsis,
      //   softWrap: false,
      // ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_cookbookStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_cookbookStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

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
