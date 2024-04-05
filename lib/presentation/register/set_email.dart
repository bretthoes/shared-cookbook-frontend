import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/core/extensions/string_extension.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/enums/http_code.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/person_store.dart';
import 'package:boilerplate/presentation/register/set_password.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SetEmailScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<SetEmailScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final FormStore _formStore = getIt<FormStore>();
  final PersonStore _personStore = getIt<PersonStore>();

  //focus node:-----------------------------------------------------------------
  late FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(),
      body: PageView(
        children: [
          _buildBody(),
        ],
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 32,
            left: 16,
            right: 16,
            child: Column(
              children: [
                _buildEmailField(),
                SizedBox(height: 16.0),
                _buildNextButton(),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return Observer(
      builder: (context) {
        return Container(
          child: TextFieldWidget(
            hint: AppLocalizations.of(context).translate('enter_email'),
            padding: EdgeInsets.only(top: 16.0),
            inputType: TextInputType.emailAddress,
            icon: Icons.email,
            iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
            textController: _userEmailController,
            focusNode: _emailFocusNode,
            inputAction: TextInputAction.next,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setEmail(_userEmailController.text);
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_emailFocusNode);
            },
            errorText: _getTranslatedErrorText(_formStore.formErrorStore.email),
          ),
        );
      },
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () async {
        DeviceUtils.hideKeyboard(context);
        _formStore.validateEmail(_formStore.email);
        if (!_formStore.emailValid) {
          return;
        }
        if (!await _emailIsAvailable()) {
          _formStore.formErrorStore.email = 'email_already_taken';
          return;
        }
        _navigateNext();
      },
      child: Text(
        AppLocalizations.of(context).translate('next'),
      ),
    );
  }

  // Private:-------------------------------------------------------------------
  Future<bool> _emailIsAvailable() async {
    await _personStore.getPersonByEmail(_userEmailController.text);
    // a response of 'not found' indicates email is available
    return _personStore.errorStore.errorCode == HttpCode.notFound.value;
  }

  void _navigateNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPasswordScreen(email: _formStore.email),
      ),
    );
  }

  _getTranslatedErrorText(String? errorKey) {
    return errorKey.isNullOrWhitespace
        ? ''
        : AppLocalizations.of(context).translate(errorKey!);
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _userEmailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}
