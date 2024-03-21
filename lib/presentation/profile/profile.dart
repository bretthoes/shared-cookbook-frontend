import 'package:boilerplate/core/widgets/square_button_widget.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/language/language_store.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/presentation/profile/custom_settings_group.dart';
import 'package:boilerplate/presentation/profile/edit_profile.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //stores:---------------------------------------------------------------------
  final UserStore _loginStore = getIt<UserStore>();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: BackButtonAppBar(),
      body: PageView(
        children: [
          _buildBody(),
        ],
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    super.dispose();
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: ListView(
        children: <Widget>[
          Positioned(
            top: 32,
            left: 16,
            right: 16,
            child: Column(
              children: [
                _buildProfileImage(),
                const SizedBox(height: 10),
                Text(
                  _loginStore.person?.displayName ?? "No name yet!",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  _loginStore.person?.email ?? "email",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                _buildEditButton(),
                const Divider(),
                CustomSettingsGroup(title: 'Preferences', children: <Widget>[
                  _buildLanguage(),
                  _buildDarkMode(),
                ]),
                CustomSettingsGroup(title: 'Profile', children: <Widget>[
                  _buildFavorites(),
                  _buildPrint(),
                  _buildEdit(),
                  _buildLogout(),
                  _buildDeleteAccount(),
                ]),
                CustomSettingsGroup(title: 'Feedback', children: <Widget>[
                  _buildReportBug(),
                  _buildFeedback(),
                ]),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return SquareButtonWidget(
      buttonColor: Colors.black,
      buttonText: "Edit Profile",
      buttonTextSize: 12,
      height: 30,
      width: 124,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditProfileScreen(),
          ),
        );
      },
    );
  }

  Widget _buildProfileImage() {
    return SizedBox(
      width: 120,
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image(
            image: isNullOrWhitespace(_loginStore.person?.imagePath)
                ? AssetImage('assets/images/blank-profile-picture.png')
                : AssetImage(_loginStore.person!.imagePath!) // TODO load url
            ),
      ),
    );
  }

  _buildLanguage() {
    return SimpleSettingsTile(
      title: 'Language',
      leading: Icon(Icons.language),
      onTap: () {
        _buildLanguageDialog();
      },
    );
  }

  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.language,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).primaryColor
                        : _themeStore.darkMode
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change user language based on selected locale
                  _languageStore.changeLanguage(object.locale);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }

  _buildDarkMode() {
    return SimpleSettingsTile(
      title: 'Dark Mode',
      leading: Icon(
        _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
      ),
      onTap: () {
        _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
      },
    );
  }

  _buildFavorites() {
    return SimpleSettingsTile(
      title: 'Favorites',
      leading: Icon(Icons.favorite),
      onTap: () {},
    );
  }

  _buildPrint() {
    return SimpleSettingsTile(
      title: 'Print',
      leading: Icon(Icons.print),
      onTap: () {},
    );
  }

  _buildEdit() {
    return SimpleSettingsTile(
      title: 'Edit profile',
      leading: Icon(Icons.edit),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditProfileScreen(),
          ),
        );
      },
    );
  }

  _buildLogout() {
    return SimpleSettingsTile(
      title: 'Logout',
      leading: Icon(Icons.logout),
      onTap: () {
        SharedPreferences.getInstance().then(
          (preference) {
            preference.setBool(Preferences.is_logged_in, false);
            Navigator.of(context).pushReplacementNamed(Routes.login);
          },
        );
      },
    );
  }

  _buildDeleteAccount() {
    // TODO implement deactivating account; currently just logs out
    return SimpleSettingsTile(
      title: 'Delete Account',
      leading: Icon(Icons.delete_forever),
      onTap: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.landing);
        });
      },
    );
  }

  _buildReportBug() {
    return SimpleSettingsTile(
      title: 'Report Bug',
      leading: Icon(Icons.bug_report),
      onTap: () {},
    );
  }

  _buildFeedback() {
    return SimpleSettingsTile(
      title: 'Send Feedback',
      leading: Icon(Icons.thumb_up),
      onTap: () {},
    );
  }

  bool isNullOrWhitespace(String? input) {
    return input == null || input.trim().isEmpty;
  }
}
