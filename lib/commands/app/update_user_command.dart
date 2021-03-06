import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/app_user.dart';

class UpdateUserCommand extends BaseAppCommand {
  Future<void> run(AppUser user) async {
    appModel.currentUser = user;
    await firebase.setUserData(user);
  }
}
