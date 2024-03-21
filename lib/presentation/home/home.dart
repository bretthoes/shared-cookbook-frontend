import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/feed/feed.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/cookbook/cookbook_list.dart';
import 'package:boilerplate/presentation/profile/profile.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();

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

  // nav bar methods:-----------------------------------------------------------
  Widget _buildNavBar() {
    return Container(
      color: _themeStore.darkMode ? Colors.black : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 16,
        ),
        child: GNav(
          selectedIndex: _page,
          onTabChange: (index) {
            setState(() {
              _page = index;
            });
          },
          backgroundColor: _themeStore.darkMode ? Colors.black : Colors.white,
          color: _themeStore.darkMode ? Colors.white : Colors.black,
          activeColor: _themeStore.darkMode ? Colors.black : Colors.white,
          tabBackgroundColor:
              _themeStore.darkMode ? Colors.white : Colors.black,
          padding: EdgeInsets.all(8),
          gap: 8,
          tabs: [
            GButton(
              icon: Icons.home,
              text: AppLocalizations.of(context).translate('home_tv_home'),
            ),
            GButton(
              icon: Icons.cookie,
              text: AppLocalizations.of(context).translate('home_tv_cookbooks'),
            ),
            GButton(
              icon: Icons.person,
              text: AppLocalizations.of(context).translate('home_tv_profile'),
            )
          ],
        ),
      ),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Shared Cookbook'),
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
          color: Colors.black,
        ),
      ),
    );
  }
}
