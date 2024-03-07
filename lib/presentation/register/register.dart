import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/square_button_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/enums/http_code.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/presentation/register/set_password.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final FormStore _formStore = getIt<FormStore>();
  final UserStore _userStore = getIt<UserStore>();

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
      child: Column(
        children: <Widget>[
          _buildEmailField(),
          SizedBox(height: 16.0),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return Observer(
      builder: (context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double buttonWidthPercentage = 0.9;

        return Container(
          width: screenWidth * buttonWidthPercentage,
          child: TextFieldWidget(
            hint: AppLocalizations.of(context).translate('login_et_user_email'),
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
            errorText: _formStore.formErrorStore.email,
          ),
        );
      },
    );
  }

  Widget _buildNextButton() {
    return SquareButtonWidget(
        buttonText: AppLocalizations.of(context).translate('register_next'),
        buttonColor: Colors.red,
        textColor: Colors.white,
        onPressed: () async {
          DeviceUtils.hideKeyboard(context);
          _formStore.validateEmail(_formStore.email);
          if (!_formStore.emailValid) {
            return;
          }
          if (!await _emailIsAvailable()) {
            _formStore.formErrorStore.email =
                AppLocalizations.of(context).translate('register_email_taken');
            return;
          }
          _navigateNext();
        });
  }

  // Private:-------------------------------------------------------------------
  Future<bool> _emailIsAvailable() async {
    await _userStore.getPersonByEmail(_userEmailController.text);
    // a response of 'not found' indicates email is available
    return _userStore.errorStore.errorCode == HttpCode.notFound.value;
  }

  void _navigateNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPasswordScreen(email: _formStore.email),
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _userEmailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}
