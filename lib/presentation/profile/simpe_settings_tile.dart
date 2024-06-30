// grabbed from https://github.com/GAM3RG33K/flutter_settings_screens/
// broken in current SDK

import 'package:flutter/material.dart';

class SimpleSettingsTile extends StatelessWidget {
  /// title string for the tile
  final String title;

  /// subtitle string for the tile
  final String? subtitle;

  /// title text style
  final TextStyle? titleTextStyle;

  /// subtitle text style
  final TextStyle? subtitleTextStyle;

  /// widget to be placed at first in the tile
  final Widget? leading;

  /// flag which represents the state of the settings, if false the the tile will
  /// ignore all the user inputs, default = true
  final bool enabled;

  /// widget that will be displayed on tap of the tile
  final Widget? child;

  final VoidCallback? onTap;

  final bool showDivider;

  const SimpleSettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.child,
    this.enabled = true,
    this.leading,
    this.onTap,
    this.showDivider = true,
  });

  Widget getIcon(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.navigate_next),
      onPressed: enabled ? () => _handleTap(context) : null,
    );
  }

  void _handleTap(BuildContext context) {
    onTap?.call();

    if (child != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => child!,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _SettingsTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      titleTextStyle: titleTextStyle,
      subtitleTextStyle: subtitleTextStyle,
      enabled: enabled,
      onTap: () => _handleTap(context),
      showDivider: showDivider,
      child: child != null ? getIcon(context) : const Text(''),
    );
  }
}

/// [_SettingsTile] is a Basic Building block for Any Settings widget.
///
/// This widget is container for any widget which is to be used for setting.
class _SettingsTile extends StatefulWidget {
  /// title string for the tile
  final String title;

  /// widget to be placed at first in the tile
  final Widget? leading;

  /// subtitle string for the tile
  final String? subtitle;

  /// title text style
  final TextStyle? titleTextStyle;

  /// subtitle text style
  final TextStyle? subtitleTextStyle;

  /// flag to represent if the tile is accessible or not, if false user input is ignored
  final bool enabled;

  /// widget which is placed as the main element of the tile as settings UI
  final Widget child;

  /// call back for handling the tap event on tile
  final GestureTapCallback? onTap;

  // /// flag to show the child below the main tile elements
  // final bool showChildBelow;

  final bool showDivider;

  const _SettingsTile({
    required this.title,
    required this.child,
    this.subtitle = '',
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.onTap,
    this.enabled = true,
    // this.showChildBelow = false,
    this.leading,
    this.showDivider = true,
  });

  @override
  __SettingsTileState createState() => __SettingsTileState();
}

class __SettingsTileState extends State<_SettingsTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            leading: widget.leading,
            title: Text(
              widget.title,
              style: widget.titleTextStyle ?? headerTextStyle(context),
            ),
            subtitle: widget.subtitle?.isEmpty ?? true
                ? null
                : Text(
                    widget.subtitle!,
                    style:
                        widget.subtitleTextStyle ?? subtitleTextStyle(context),
                  ),
            enabled: widget.enabled,
            onTap: widget.onTap,
            // trailing: Visibility(
            //   visible: !widget.showChildBelow,
            //   child: widget.child,
            // ),
            trailing: widget.child,
            dense: true,
            // wrap only if the subtitle is longer than 70 characters
            isThreeLine: (widget.subtitle?.isNotEmpty ?? false) &&
                widget.subtitle!.length > 70,
          ),
          // Visibility(
          //   visible: widget.showChildBelow,
          //   child: widget.child,
          // ),
          if (widget.showDivider) _SettingsTileDivider(),
        ],
      ),
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

TextStyle? headerTextStyle(BuildContext context) =>
    Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16.0);

TextStyle? subtitleTextStyle(BuildContext context) => Theme.of(context)
    .textTheme
    .titleSmall
    ?.copyWith(fontSize: 13.0, fontWeight: FontWeight.normal);
