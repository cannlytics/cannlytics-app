import 'package:cannlytics_app/_utils/string_utils.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/app_user.dart';

import 'refresh_menubar_command.dart';

class SetCurrentUserCommand extends BaseAppCommand {
  Future<void> run(AppUser user) async {
    safePrint("SetCurrentUserCommand: $user");
    // Update appController with new user. If user is null, this acts as a logout command.
    firebase.userId = user?.email;
    appModel.currentUser = user;
    if (StringUtils.isNotEmpty(firebase.userId)) {
      AppUser user = await firebase.getUser();
      if (user != null) {
        appModel.currentUser = user;
        safePrint("User loaded from firebase: ${user.toJson()}");
      }
    }
    // If currentUser is null here, then we've either logged out, or auth failed.
    if (appModel.currentUser == null) {
      appModel.reset();
      booksModel.reset();
    }
    RefreshMenuBarCommand().run();
    appModel.save();
  }
}
