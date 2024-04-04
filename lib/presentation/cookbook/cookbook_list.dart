import 'dart:math';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/cookbook/add_cookbook.dart';
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
        _buildMainContent(),
        _buildAddCookbookButton(),
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
        ? SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: _cookbookStore.cookbookList!.cookbooks.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _buildListItem(index);
              },
            ),
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('no_cookbooks_yet'),
            ),
          );
  }

  Widget _buildListItem(int index) {
    var cookbook = _cookbookStore.cookbookList?.cookbooks[index];
    var cookbookId = cookbook?.cookbookId ?? 0;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CookbookDetailsScreen(cookbookId: cookbookId),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              getRandomFilename(),
              width: 160,
              height: 225,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 4),
            Text(
              cookbook?.title ?? '',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO remove, only used temporarily to simulate displaying covers in list
  String getRandomFilename() {
    var filenames = [
      'assets/images/covers/beige-orange-corners.png',
      'assets/images/covers/blue-pink-stripes.png',
      'assets/images/covers/blue-purple-stripes.png',
      'assets/images/covers/blue-yellow-stripes.png',
      'assets/images/covers/green-yellow-stripes.png',
      'assets/images/covers/light-green-purple-stripes.png',
      'assets/images/covers/light-green-purple-white-stripes.png',
      'assets/images/covers/orange-white-stripes.png',
      'assets/images/covers/purple-brown-corners.png',
      'assets/images/covers/yellow-green-stripes.png',
    ];
    Random random = Random();
    int randomIndex = random.nextInt(filenames.length);
    return filenames[randomIndex];
  }

  Widget _buildAddCookbookButton() {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 16.0, right: 16.0), // Adjust padding as needed
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            // Handle onPressed action here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddCookbookScreen()),
            );
          },
          child: Icon(Icons.add, color: Colors.white), // Make the icon white
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Make it circular
          ),
        ),
      ),
    );
  }
}
