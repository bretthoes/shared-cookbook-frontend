import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/enums/http_code.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/person_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate/core/extensions/string_extension.dart';

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
  final PersonStore _personStore = getIt<PersonStore>();

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
                _buildRegisterButton(),
                SizedBox(height: 8.0),
                _buildPasswordText(),
              ],
            ),
          ),
          Observer(
            builder: (context) {
              return _personStore.success ? navigate(context) : Container();
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _personStore.isLoading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Text _buildPasswordText() {
    return Text(
      AppLocalizations.of(context)
          .translate('use_6_20_chars_with_a_mix_of_letters_and_numbers'),
      style: TextStyle(
        color: Colors.black54,
        fontSize: 12.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  ElevatedButton _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () async => await _tryRegister(),
      child: Text(
        AppLocalizations.of(context).translate('done'),
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
          errorText:
              _getTranslatedErrorText(_formStore.formErrorStore.password),
          onChanged: (value) {
            _formStore.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget navigate(BuildContext context) {
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
      await _personStore.register(_formStore.email, _passwordController.text);
      if (_personStore.errorStore.errorMessage.isNotEmpty) {
        _updateErrorMessage();
      }
    }
  }

  void _updateErrorMessage() {
    if (_personStore.errorStore.errorCode == HttpCode.conflict.value) {
      _formStore.formErrorStore.password = 'email_already_taken';
    } else {
      _formStore.formErrorStore.password = 'error_occurred';
    }
  }

  String _getTranslatedErrorText(String? errorKey) {
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
