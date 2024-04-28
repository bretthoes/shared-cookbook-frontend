import 'package:boilerplate/presentation/login/store/person_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('add_cookbook')),
      ),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: _buildColumn(),
      ),
    );
  }

  Widget _buildColumn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildPreviewText(),
          _buildCookbookPreview(),
          SizedBox(height: 16),
          _buildCoverSelect(),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child:
                Text("2. Enter a title:"), // TODO localize, refactor to widget
          ),
          _buildTitleSelect(),
          _buildTitleFontSelect(),
          _buildTitleColorSelect(),
          _buildSaveButton(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPreviewText() {
    return Text(
      'Preview:', // TODO localize
    );
  }

  Widget _buildCookbookPreview() {
    return Stack(
      children: [
        ClipRRect(child: _getPreviewImage()),
      ],
    );
  }

  Widget _getPreviewImage() {
    var defaultImage = _filenames[0];
    return Observer(builder: (context) {
      return Image.asset(
        _cookbookStore.newCover ?? defaultImage,
        fit: BoxFit.cover,
      );
    });
  }

  final List<String> _filenames = [
    'assets/images/covers/beige-orange-corners.png',
    'assets/images/covers/blue-pink-stripes.png',
    'assets/images/covers/blue-purple-stripes.png',
    'assets/images/covers/blue-yellow-stripes.png',
    'assets/images/covers/green-yellow-stripes.png',
    'assets/images/covers/light-green-purple-stripes.png',
    'assets/images/covers/light-green-purple-white-stripes.png',
    'assets/images/covers/orange-white-stripes.png',
    'assets/images/covers/purple-brown-corners.png',
    'assets/images/covers/yellow-green-stripes.png',
  ];

  // Widget _buildCoverSelect() {
  //   return Column(
  //     children: [
  //       DropdownButton<String>(
  //         items: _filenames.map((String value) {
  //           return DropdownMenuItem<String>(
  //             value: value,
  //             child: Text(value.split('/').last), // Display filename
  //           );
  //         }).toList(),
  //         onChanged: (String? newValue) {
  //           if (newValue != null) {
  //             setState(() {
  //               _imageFile = File(newValue);
  //             });
  //           }
  //         },
  //         hint: Text('Select from predefined images'),
  //         isExpanded: true,
  //       ),
  //       SizedBox(height: 16.0),
  //       if (_imageFile != null)
  //         Image.file(
  //           _imageFile!,
  //           height: 200,
  //           width: double.infinity,
  //           fit: BoxFit.cover,
  //         ),
  //       ElevatedButton(
  //         onPressed: () => _getImage(ImageSource.gallery),
  //         child: Text('Select Image from Gallery'),
  //       ),
  //       ElevatedButton(
  //         onPressed: () => _getImage(ImageSource.camera),
  //         child: Text('Take a Picture'),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildCoverSelect() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
          items: _filenames.map((i) {
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
      ],
    );
  }

  Widget _buildListItem(String fileName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _cookbookStore.newCover = fileName;
        });
      },
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              child: Image.asset(
                fileName,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        //_cookbookStore.cookbookToAdd?.imagePath = File(pickedFile.path);
      });
    }
  }

  Widget _buildTitleSelect() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          icon: Icons.lock,
          iconColor: _getThemeColor(),
          textController: _titleController,
          errorText: _cookbookStore.errorStore.errorMessage,
          onChanged: (value) {
            _cookbookStore.setTitle(_titleController.text);
          },
        );
      },
    );
  }

  Widget _buildTitleFontSelect() {
    return Container();
  }

  Widget _buildTitleColorSelect() {
    return Container();
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
  Future<void> _tryAddCookbook() async {
    DeviceUtils.hideKeyboard(context);
    _cookbookStore.validateAddCookbook();
    if (_cookbookStore.errorStore.errorMessage.isEmpty) {
      _cookbookStore.addCookbook(
        _personStore.person?.personId ?? 0,
        _cookbookStore.newTitle ?? "",
        _cookbookStore.newCover ?? "",
      );
      if (_cookbookStore.errorStore.errorMessage.isEmpty) {
        // TODO indicate success and redirect back to cookbookpage
      }
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
