import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cannlytics_app/_utils/native_window_utils/titlebar_wrappers/linux_title_bar_buttons.dart';
import 'package:cannlytics_app/themes.dart';
import 'package:provider/provider.dart';

/// Native TitleBar for Linux, uses BitDojo platform
class LinuxTitleBar extends StatelessWidget {
  const LinuxTitleBar(this.child, {required Key key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    final WindowButtonColors btnColors = WindowButtonColors(
      iconNormal: Colors.black,
      mouseOver: Colors.black.withOpacity(.1),
      mouseDown: Colors.black.withOpacity(.2),
      normal: Colors.transparent,
    );
    final WindowButtonColors closeBtnColors = WindowButtonColors(
      normal: theme.accent1,
      iconNormal: theme.surface1,
    );

    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          MoveWindow(),
          child,
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LinuxMinimizeButton(
                  key: GlobalKey<ScaffoldState>(),
                  colors: btnColors,
                  onPressed: () => appWindow.minimize(),
                ),
                appWindow.isMaximized
                    ? LinuxUnmaximizeButton(
                        key: GlobalKey<ScaffoldState>(),
                        colors: btnColors,
                        onPressed: () => appWindow.maximizeOrRestore(),
                      )
                    : LinuxMaximizeButton(
                        key: GlobalKey<ScaffoldState>(),
                        colors: btnColors,
                        onPressed: () => appWindow.maximizeOrRestore(),
                      ),
                LinuxCloseButton(
                  key: GlobalKey<ScaffoldState>(),
                  colors: closeBtnColors,
                  onPressed: () => appWindow.close(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
