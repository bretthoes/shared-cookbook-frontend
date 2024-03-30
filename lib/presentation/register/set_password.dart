import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/core/widgets/square_button_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/enums/http_code.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boilerplate/core/extensions/string_extension.dart';

// TODO localize all strings in this file
// TODO handle auto sign in bug if user state remembered between session
class SetPasswordScreen extends StatefulWidget {
  final String email;

  SetPasswordScreen({required this.email});

  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formStore.setEmail(widget.email);
  }

  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final FormStore _formStore = getIt<FormStore>();
  final UserStore _userStore = getIt<UserStore>();

  @override
  Widget build(BuildContext context) {
    _formStore.email = widget.email;
    return Scaffold(
      appBar: BackButtonAppBar(),
      body: PageView(
        children: [
          _buildPasswordPage(),
        ],
      ),
    );
  }

  Widget _buildPasswordPage() {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 32,
            left: 16,
            right: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPasswordField(),
                SizedBox(height: 16.0),
                SquareButtonWidget(
                  buttonColor: Colors.red,
                  buttonText: AppLocalizations.of(context).translate('done'),
                  onPressed: () async {
                    await _tryRegister();
                  },
                ),
                SizedBox(height: 8.0),
                Text(
                  AppLocalizations.of(context).translate('use_6_20_chars_with_a_mix_of_letters_and_numbers'),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Observer(
            builder: (context) {
              return _userStore.success ? navigate(context) : Container();
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _userStore.isLoading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('enter_password'),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _passwordController,
          errorText: _getTranslatedErrorText(_formStore.formErrorStore.password),
          onChanged: (value) {
            _formStore.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // General Methods:-----------------------------------------------------------
  Future<void> _tryRegister() async {
    _formStore.validateAll();
    if (_formStore.canLogin) {
      DeviceUtils.hideKeyboard(context);
      await _userStore.register(_formStore.email, _passwordController.text);
      if (_userStore.errorStore.errorMessage.isNotEmpty) {
        _updateErrorMessage();
      }
    } 
  }

  void _updateErrorMessage() {
    if (_userStore.errorStore.errorCode == HttpCode.conflict.value) {
      _formStore.formErrorStore.password = 'email_already_taken';
    } else {
      _formStore.formErrorStore.password = 'error_occurred';
    }
  }

  _getTranslatedErrorText(String? errorKey) {
    return errorKey.isNullOrWhitespace
      ? ''
      : AppLocalizations.of(context).translate(errorKey!);
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
