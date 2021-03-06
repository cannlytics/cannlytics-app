import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cannlytics_app/commands/app/set_current_user_command.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/app_user.dart';

class AuthenticateUserCommand extends BaseAppCommand {
  Future<bool> run(
      {@required String email,
      @required String pass,
      @required bool createNew}) async {
    AppUser user;
    try {
      // Authenticate user
      user = await firebase.signIn(
          email: email, password: pass, createAccount: createNew);
      // If they are new, create a database record to hold their content
      if (user != null && createNew) {
        user = user.copyWith(documentId: email, firstName: "", lastName: "");
        // Set the userId here, so firebase can update this new users data, this is also set in [SetCurrentUserCommand]
        firebase.userId = email;
        await firebase.addUser(user);
      }
      safePrint("Authentication complete, user=$user");
    } on Exception catch (e) {
      safePrint(e.toString());
    }
    //}
    // Login??
    if (user != null) {
      SetCurrentUserCommand().run(user);
      return true;
    }
    return false;
  }
}
