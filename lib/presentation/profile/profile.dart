import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/core/extensions/string_extension.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/language/language_store.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/person_store.dart';
import 'package:boilerplate/presentation/profile/custom_settings_group.dart';
import 'package:boilerplate/presentation/profile/edit_profile.dart';
import 'package:boilerplate/presentation/profile/simpe_settings_tile.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //stores:---------------------------------------------------------------------
  final PersonStore _personStore = getIt<PersonStore>();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    super.dispose();
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileImage(),
              const SizedBox(height: 10),
              Observer(
                builder: (context) {
                  return Text(
                    _personStore.person?.displayName ??
                        AppLocalizations.of(context).translate('no_name_yet'),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              Text(
                _personStore.person?.email ??
                    AppLocalizations.of(context).translate('not_signed_in'),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              CustomSettingsGroup(
                title: AppLocalizations.of(context).translate('preferences'),
                children: <Widget>[
                  _buildLanguage(),
                  _buildDarkMode(),
                ],
              ),
              CustomSettingsGroup(
                  title: AppLocalizations.of(context).translate('content'),
                  children: <Widget>[
                    _buildFavorites(),
                    _buildPrint(),
                  ]),
              CustomSettingsGroup(
                  title: AppLocalizations.of(context).translate('profile'),
                  children: <Widget>[
                    _buildEdit(),
                    _buildLogout(),
                    _buildDeleteAccount(),
                  ]),
              CustomSettingsGroup(
                  title: AppLocalizations.of(context).translate('feedback'),
                  children: <Widget>[
                    _buildReportBug(),
                    _buildFeedback(),
                  ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return SizedBox(
      width: 120,
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: _getProfileImage(_personStore.person?.imagePath ?? ''),
      ),
    );
  }

  _buildLanguage() {
    return SimpleSettingsTile(
      title: AppLocalizations.of(context).translate('language'),
      leading: Icon(Icons.language),
      onTap: () {
        _buildLanguageDialog();
      },
    );
  }

  _buildLanguageDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context).translate('choose_language'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: _languageStore.supportedLanguages
                  .map(
                    (object) => ListTile(
                      dense: true,
                      title: Text(
                        object.language,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        _languageStore.changeLanguage(object.locale);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context).translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _buildDarkMode() {
    return SimpleSettingsTile(
      title: AppLocalizations.of(context).translate('dark_mode'),
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
      title: AppLocalizations.of(context).translate('favorites'),
      leading: Icon(Icons.favorite),
      onTap: () {},
    );
  }

  _buildPrint() {
    return SimpleSettingsTile(
      title: AppLocalizations.of(context).translate('print'),
      leading: Icon(Icons.print),
      onTap: () {},
    );
  }

  _buildEdit() {
    return SimpleSettingsTile(
      title: AppLocalizations.of(context).translate('edit_profile'),
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
      title: AppLocalizations.of(context).translate('sign_out'),
      leading: Icon(Icons.logout),
      onTap: () {
        _personStore.logout();
        Navigator.of(context).pushReplacementNamed(Routes.login);
      },
    );
  }

  _buildDeleteAccount() {
    // TODO implement deactivating account; currently just logs out
    return SimpleSettingsTile(
      title: AppLocalizations.of(context).translate('delete_account'),
      leading: Icon(Icons.delete_forever),
      onTap: () {
        _personStore.logout();
        Navigator.of(context).pushReplacementNamed(Routes.landing);
      },
    );
  }

  _buildReportBug() {
    return SimpleSettingsTile(
      title: AppLocalizations.of(context).translate('report_bug'),
      leading: Icon(Icons.bug_report),
      onTap: () {},
    );
  }

  _buildFeedback() {
    return SimpleSettingsTile(
      title: AppLocalizations.of(context).translate('send_feedback'),
      leading: Icon(Icons.thumb_up),
      onTap: () {},
    );
  }

  _getProfileImage(String image) {
    if (image.isNullOrWhitespace) {
      return Image.asset('assets/images/blank-profile-picture.png',
          width: 120, height: 120, fit: BoxFit.cover);
    }

    var bucketName = Strings.bucketName;
    var region = Strings.region;
    return CachedNetworkImage(
      imageUrl: 'https://$bucketName.s3.$region.amazonaws.com/$image',
      fit: BoxFit.cover,
      width: 120,
      height: 120,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
