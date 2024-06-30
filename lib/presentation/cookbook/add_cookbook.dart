import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/presentation/login/store/person_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/images.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/cookbook/store/cookbook_store.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddCookbookScreen extends StatefulWidget {
  @override
  State<AddCookbookScreen> createState() => _AddCookbookScreenState();
}

class _AddCookbookScreenState extends State<AddCookbookScreen> {
  //stores:---------------------------------------------------------------------
  final CookbookStore _cookbookStore = getIt<CookbookStore>();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final PersonStore _personStore = getIt<PersonStore>();

  TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    _cookbookStore.setCover(Images.coverImages[0]);
    _cookbookStore.cookbookErrorStore.resetError();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: BackButtonAppBar(
        title: AppLocalizations.of(context).translate('add_cookbook'),
      ),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: _buildColumn(),
      ),
    );
  }

  Widget _buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildPreviewText(),
        _buildCookbookPreview(),
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("1. Select a cover:"), // TODO localize
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 80,
            viewportFraction: 0.19,
            pageSnapping: false,
            enableInfiniteScroll: false,
            initialPage: 2,
          ),
          items: Images.coverImages.map((i) {
            return _buildListItem(i);
          }).toList(),
        ),
        Text("or"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space evenly
          children: [
            OutlinedButton(
              onPressed: () => _getImage(ImageSource.gallery),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: _getThemeColor(),
                ), // Outline color
              ),
              child: Icon(
                Icons.add_to_photos,
                color: _getThemeColor(),
              ),
            ),
            OutlinedButton(
              onPressed: () => _getImage(ImageSource.camera),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: _getThemeColor(),
                ), // Outline color
              ),
              child: Icon(
                Icons.photo_camera,
                color: _getThemeColor(),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("2. Enter a title:"), // TODO localize, refactor to widget
        ),
        _buildTitleSelect(),
        _buildSaveButton(),
        SizedBox(height: 32),
      ],
    );
  }

  Widget _buildPreviewText() {
    return Text(
      'Preview:', // TODO localize
    );
  }

  Widget _buildCookbookPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.0),
      child: Observer(
        builder: (context) {
          return Container(
            width: 180.0,
            height: 260.0,
            child: Images.getCoverImage(_cookbookStore.newCover),
          );
        },
      ),
    );
  }

  Widget _buildListItem(String fileName) {
    return GestureDetector(
      onTap: () {
        _cookbookStore.setCover(fileName);
      },
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              child: Images.getCoverImage(fileName),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSelect() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          padding: const EdgeInsets.only(bottom: 8.0),
          isIcon: false,
          icon: Icons.lock,
          iconColor: _getThemeColor(),
          textController: _titleController,
          errorText: _cookbookStore.cookbookErrorStore.error,
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async => await _tryAddCookbook(),
      child: Text(
        AppLocalizations.of(context).translate('save'),
      ),
    );
  }

  // General Methods:-----------------------------------------------------------
  Future _tryAddCookbook() async {
    DeviceUtils.hideKeyboard(context);
    await _cookbookStore.addCookbook(
      _personStore.person?.personId ?? 0,
      _titleController.text,
      _cookbookStore.newCover,
    );
    if (_cookbookStore.cookbookErrorStore.error.isEmpty) {
      _showToastMessage("Success!"); // TODO localize
      Navigator.pop(context);
    } else {
      _cookbookStore.errorStore.errorMessage;
    }
  }

  _showToastMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: 'cookbook added.',
          title: message,
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(
        () {
          _cookbookStore.setCover(pickedFile.path);
        },
      );
    }
  }

  Color _getThemeColor() {
    return _themeStore.darkMode ? Colors.white70 : Colors.black54;
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
