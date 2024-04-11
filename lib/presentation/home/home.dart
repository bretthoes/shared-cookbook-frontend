import 'package:boilerplate/presentation/feed/feed.dart';
import 'package:boilerplate/presentation/cookbook/cookbook_list.dart';
import 'package:boilerplate/presentation/profile/profile.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------

  final screens = [
    FeedScreen(),
    CookbookListScreen(),
    ProfileScreen(),
  ];

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _page,
        children: screens,
      ),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildNavBar() {
    return BottomNavigationBar(
      currentIndex: _page,
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppLocalizations.of(context).translate('home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_stories),
          label: AppLocalizations.of(context).translate('cookbooks'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: AppLocalizations.of(context).translate('profile'),
        )
      ],
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('shared_cookbook')),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildNotificationButton(),
    ];
  }

  Widget _buildNotificationButton() {
    return Container(
      padding: EdgeInsets.all(6),
      child: IconButton(
        onPressed: () {
          // TODO add notif page/pop up
          // TODO add number indicator of unread notifs
        },
        icon: Icon(
          Icons.notifications,
        ),
      ),
    );
  }
}
