import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/square_button_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _nameController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final FormStore _formStore = getIt<FormStore>();
  final UserStore _userStore = getIt<UserStore>();

  @override
  void initState() {
    super.initState();
    _nameController.text = _userStore.person?.displayName ?? "";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: BackButtonAppBar(),
      body: _buildBody(),
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
      child: Stack(
        children: <Widget>[
          _handleErrorMessage(),
          _buildMainContent(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Material(child: _buildListView());
  }

  Widget _buildListView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //_buildProfileImage(),
            _buildNameField(),
            SizedBox(height: 16),
            _buildSaveButton()
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Set your name',
          inputType: TextInputType.name,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _nameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setName(_nameController.text);
          },
          errorText: _formStore.formErrorStore.name,
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return SquareButtonWidget(
        buttonText: 'Save',
        buttonColor: Colors.red,
        textColor: Colors.white,
        onPressed: () async {
          DeviceUtils.hideKeyboard(context);
          _formStore.validateName(_nameController.text);
          if (_formStore.formErrorStore.name != null) {
            // TODO update error message
            return;
          }
          if (true) {
            var personId = _userStore.person?.personId ?? 0;
            if (personId > 0) {
              await _userStore.updatePerson(
                personId,
                _nameController.text,
                null,
                null,
              );
              //TODO api call to update person
              // TODO display save successful
              return;
            }
          }
        });
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_formStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_formStore.errorStore.errorMessage);
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
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}
