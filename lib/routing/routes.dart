import 'package:get/get.dart';
import 'package:cannlytics_consumer/ui/auth/sign_in_ui.dart';
import 'package:cannlytics_consumer/ui/auth/reset_password_ui.dart';
import 'package:cannlytics_consumer/ui/home/home.dart';
import 'package:cannlytics_consumer/ui/settings/settings.dart';

class Routes {
  Routes._(); // Prevent anyone from instantiating this object

  static final routes = [
    GetPage(
      name: '/',
      page: () => HomeUI(),
    ),
    GetPage(
      name: '/HomeUI',
      page: () => HomeUI(),
    ),
    GetPage(
        name: '/ResetPasswordUI',
        page: () => ResetPasswordUI(),
        transition: Transition.cupertino),
    GetPage(
      name: '/SignInUI',
      page: () => SignInUI(),
    ),
    GetPage(
      name: '/SettingsUI',
      page: () => SettingsUI(),
    ),
  ];
}
