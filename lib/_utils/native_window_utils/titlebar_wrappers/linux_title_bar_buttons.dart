import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import 'linux_title_bar_icons.dart';

class _LinuxWindowButton extends WindowButton {
  _LinuxWindowButton({Key key, WindowButtonColors colors, WindowButtonIconBuilder iconBuilder, VoidCallback onPressed})
      : super(
          key: key,
          colors: colors,
          iconBuilder: iconBuilder,
          builder: _linuxWindowButtonBuilder,
          onPressed: onPressed,
        );
}

class LinuxMinimizeButton extends _LinuxWindowButton {
  LinuxMinimizeButton({Key key, WindowButtonColors colors, VoidCallback onPressed})
      : super(
            key: key,
            colors: colors,
            iconBuilder: (buttonContext) => LinuxMinimizeIcon(color: buttonContext.iconColor),
            onPressed: onPressed ?? () => appWindow.minimize());
}

class LinuxMaximizeButton extends _LinuxWindowButton {
  LinuxMaximizeButton({Key key, WindowButtonColors colors, VoidCallback onPressed})
      : super(
            key: key,
            colors: colors,
            iconBuilder: (buttonContext) => LinuxMaximizeIcon(color: buttonContext.iconColor),
            onPressed: onPressed ?? () => appWindow.maximizeOrRestore());
}

class LinuxUnmaximizeButton extends _LinuxWindowButton {
  LinuxUnmaximizeButton({Key key, WindowButtonColors colors, VoidCallback onPressed})
      : super(
            key: key,
            colors: colors,
            iconBuilder: (buttonContext) => LinuxUnmaximizeIcon(color: buttonContext.iconColor),
            onPressed: onPressed ?? () => appWindow.maximizeOrRestore());
}

class LinuxCloseButton extends _LinuxWindowButton {
  LinuxCloseButton({Key key, WindowButtonColors colors, VoidCallback onPressed})
      : super(
            key: key,
            colors: colors,
            iconBuilder: (buttonContext) => LinuxCloseIcon(color: buttonContext.iconColor),
            onPressed: onPressed ?? () => appWindow.close());
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
