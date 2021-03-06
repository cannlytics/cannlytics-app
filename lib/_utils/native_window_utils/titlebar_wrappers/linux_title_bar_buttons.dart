import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import 'linux_title_bar_icons.dart';

class _LinuxWindowButton extends WindowButton {
  _LinuxWindowButton({
    required Key key,
    required WindowButtonColors colors,
    required WindowButtonIconBuilder iconBuilder,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          colors: colors,
          iconBuilder: iconBuilder,
          builder: _linuxWindowButtonBuilder,
          onPressed: onPressed,
        );
}

class LinuxMinimizeButton extends _LinuxWindowButton {
  LinuxMinimizeButton({
    required Key key,
    required WindowButtonColors colors,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          colors: colors,
          iconBuilder: (buttonContext) =>
              LinuxMinimizeIcon(color: buttonContext.iconColor),
          onPressed: onPressed,
        );
}

class LinuxMaximizeButton extends _LinuxWindowButton {
  LinuxMaximizeButton(
      {required Key key,
      required WindowButtonColors colors,
      required VoidCallback onPressed})
      : super(
          key: key,
          colors: colors,
          iconBuilder: (buttonContext) =>
              LinuxMaximizeIcon(color: buttonContext.iconColor),
          onPressed: onPressed,
        );
}

class LinuxUnmaximizeButton extends _LinuxWindowButton {
  LinuxUnmaximizeButton({
    required Key key,
    required WindowButtonColors colors,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          colors: colors,
          iconBuilder: (buttonContext) =>
              LinuxUnmaximizeIcon(color: buttonContext.iconColor),
          onPressed: onPressed,
        );
}

class LinuxCloseButton extends _LinuxWindowButton {
  LinuxCloseButton({
    required Key key,
    required WindowButtonColors colors,
    required VoidCallback onPressed,
  }) : super(
            key: key,
            colors: colors,
            iconBuilder: (buttonContext) =>
                LinuxCloseIcon(color: buttonContext.iconColor),
            onPressed: onPressed);
}

Widget _linuxWindowButtonBuilder(WindowButtonContext context, Widget icon) {
  return Container(
    margin: EdgeInsets.all(5),
    decoration: ShapeDecoration(
      shape: CircleBorder(),
      color: context.backgroundColor,
    ),
    child: icon,
  );
}
