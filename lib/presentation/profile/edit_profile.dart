import 'dart:io';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/core/extensions/string_extension.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/person_store.dart';
import 'package:boilerplate/presentation/profile/custom_settings_group.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

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
  final PersonStore _personStore = getIt<PersonStore>();

  @override
  void initState() {
    super.initState();
    _nameController.text = _personStore.person?.displayName ?? '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(
        title: AppLocalizations.of(context).translate('edit_profile'),
      ),
      body: _buildBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: _buildSaveButton(),
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _nameController.dispose();
    super.dispose();
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _handleErrorMessage(),
              CustomSettingsGroup(
                title: AppLocalizations.of(context)
                    .translate('edit_profile_picture'),
                children: <Widget>[
                  SizedBox(height: 16),
                  _buildProfileImage(),
                ],
              ),
              CustomSettingsGroup(
                title:
                    AppLocalizations.of(context).translate('edit_display_name'),
                children: <Widget>[
                  SizedBox(height: 8),
                  _buildNameField(),
                ],
              ),
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
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: _getProfileImage(_imagePath ?? ''),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.edit, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('set_your_name'),
          inputType: TextInputType.name,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _nameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setName(_nameController.text);
          },
          errorText: _getTranslatedErrorText(_formStore.formErrorStore.name),
        );
      },
    );
  }

  String? _imagePath;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
      // TODO: Upload the image to your server or storage
    }
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        DeviceUtils.hideKeyboard(context);
        _formStore.validateName(_nameController.text);
        if (_formStore.formErrorStore.name != null) {
          // TODO update error message
          return;
        }
        if (true) {
          var personId = _personStore.person?.personId ?? 0;
          if (personId > 0) {
            await _personStore.updatePerson(
              personId,
              _nameController.text,
              null,
              null,
            );
            // TODO api call to update person
            // TODO display save successful
            return;
          }
        }
      },
      child: Text(
        AppLocalizations.of(context).translate('save'),
      ),
    );
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
          title: AppLocalizations.of(context).translate('error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  _getTranslatedErrorText(String? errorKey) {
    return errorKey.isNullOrWhitespace
        ? ''
        : AppLocalizations.of(context).translate(errorKey!);
  }

  _getProfileImage(String image) {
    if (image.isNullOrWhitespace) {
      return Image.asset('assets/images/blank-profile-picture.png',
          width: 120, height: 120, fit: BoxFit.cover);
    }

    if (image.contains('data')) {
      return Image.file(File(image),
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
