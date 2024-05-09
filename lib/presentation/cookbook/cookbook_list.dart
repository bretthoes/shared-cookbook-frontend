import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/presentation/cookbook/add_cookbook.dart';
import 'package:boilerplate/presentation/cookbook/cookbook_details.dart';
import 'package:boilerplate/presentation/cookbook/store/cookbook_store.dart';
import 'package:boilerplate/presentation/login/store/person_store.dart';
import 'package:boilerplate/utils/images.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CookbookListScreen extends StatefulWidget {
  @override
  _CookbookListScreenState createState() => _CookbookListScreenState();
}

class _CookbookListScreenState extends State<CookbookListScreen> {
  //stores:---------------------------------------------------------------------
  final CookbookStore _cookbookStore = getIt<CookbookStore>();
  final PersonStore _personStore = getIt<PersonStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    if (!_cookbookStore.loading) {
      var personId = _personStore.person?.personId ?? 0;
      if (personId > 0) {
        _cookbookStore.getCookbooks(personId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _buildMainContent(),
        _buildAddCookbookButton(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _cookbookStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildListView());
      },
    );
  }

  Widget _buildListView() {
    return Observer(
      builder: (context) {
        var cookbooks = _cookbookStore.cookbookList.cookbooks;

        if (cookbooks.isEmpty) {
          return Center(
            child: Text(
              AppLocalizations.of(context).translate('no_cookbooks_yet'),
            ),
          );
        }

        final orientation = MediaQuery.of(context).orientation;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: orientation == Orientation.portrait ? 300 : 200,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                viewportFraction: 0.55,
                enableInfiniteScroll: false,
              ),
              items: cookbooks.map((i) {
                return _buildListItem(i);
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildListItem(Cookbook cookbook) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CookbookDetailsScreen(
              cookbook: cookbook,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Images.getCoverImage(cookbook.imagePath ?? ''),
            ),
          ),
          SizedBox(height: 8),
          Text(
            cookbook.title ?? 'No title', // TODO localize
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildAddCookbookButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCookbookScreen(),
              ),
            );
          },
          child: Icon(Icons.add, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
