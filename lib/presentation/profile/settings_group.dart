// grabbed from https://github.com/GAM3RG33K/flutter_settings_screens/
// broken in current SDK

import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  /// title string for the tile
  final String title;

  /// subtitle string for the tile
  final String subtitle;

  /// title text style
  final TextStyle? titleTextStyle;

  /// subtitle text style
  final TextStyle? subtitleTextStyle;

  /// List of the widgets which are to be shown under the title as a group
  final List<Widget> children;

  final Alignment titleAlignment;

  const SettingsGroup({
    super.key,
    required this.title,
    required this.children,
    this.subtitle = '',
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.titleAlignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    var elements = <Widget>[
      Container(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 22.0),
        child: Align(
          alignment: titleAlignment,
          child: Text(
            title.toUpperCase(),
            style: titleTextStyle ?? groupStyle(context),
          ),
        ),
      ),
    ];

    if (subtitle.isNotEmpty) {
      elements.addAll([
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              subtitle,
              style: subtitleTextStyle,
            ),
          ),
        ),
        _SettingsTileDivider(),
      ]);
    }
    elements.addAll(children);
    return Wrap(
      children: <Widget>[
        Column(
          children: elements,
        )
      ],
    );
  }

  TextStyle groupStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).colorScheme.secondary,
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
    );
  }
}

/// [_SettingsTileDivider] is widget which is used as a Divide various settings
/// tile in a list
class _SettingsTileDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0.0,
    );
  }
}
