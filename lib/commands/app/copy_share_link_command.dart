import 'package:flutter/services.dart';
import 'package:cannlytics_app/_utils/device_info.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/routing/app_link.dart';
import 'package:share/share.dart';

class CopyShareLinkCommand extends BaseAppCommand {
  String get baseUrl => "https://cannlytics.com/#";

  Future<void> run(String bookId, {String pageId}) async {
    // Form a url using an AppLink
    String url = baseUrl +
        AppLink(
          user: appModel.currentUser.email,
          bookId: bookId,
          pageId: pageId,
        ).toLocation();

    // Device clipboard
    if (DeviceInfo.isDesktopOrWeb) {
      showToast("Share link copied!");
      Clipboard.setData(ClipboardData(text: url));
    }
    // Mobile share sheet
    else {
      Share.share(url);
    }
  }
}
