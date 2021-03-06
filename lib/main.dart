import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// import 'package:cannlytics_app/routing/routes.dart';
import 'package:cannlytics_app/views/splash_screen.dart';

// import 'package:cannlytics_app/commands/app/bootstrap_command.dart';
// import 'package:cannlytics_app/models/app_model.dart';
// import 'package:cannlytics_app/models/books_model.dart';
// import 'package:cannlytics_app/routing/app_route_parser.dart';
// import 'package:cannlytics_app/routing/app_router.dart';
// import 'package:cannlytics_app/services/cloudinary/cloud_storage_service.dart';
// import 'package:cannlytics_app/services/firebase/firebase_service.dart';
// import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Status bar style on Android/iOS
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());

  if (kIsWeb) {
    // Increase Skia cache size to support bigger images.
    const int megabyte = 1000000;
    SystemChannels.skia
        .invokeMethod('Skia.setResourceCacheMaxBytes', 512 * megabyte);
    // Hot-fix: cant' await on invokeMethod due to
    // https://github.com/flutter/flutter/issues/77018
    // so awaiting on Future.delayed instead.
    await Future<void>.delayed(Duration.zero);
  }

  // TODO: Handle dependecy injection with GetX
  await Firebase.initializeApp();
  // Get.put<AuthController>(AuthController());
  // Get.put<ThemeController>(ThemeController());

  // Create core models and services.
  // FirebaseService firebase = FirebaseFactory.create();
  // BooksModel booksModel = BooksModel();
  // AppModel appModel = AppModel(booksModel, firebase);

  // Run the app.
  runApp(MainApp());
  // runApp(MultiProvider(
  //   providers: [
  //     Provider.value(value: firebase),
  //     // Provider(create: (_) => CloudStorageService()),
  //     ChangeNotifierProvider.value(value: appModel),
  //     ChangeNotifierProvider.value(value: booksModel),
  //   ],
  //   child: _AppBootstrapper(),
  // ));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determine the initial theme.
    // ThemeController.to.getThemeMode();
    // AppTheme _theme = AppTheme.fromType(ThemeType.CannlyticsColors);

    /// Main application
    return GetMaterialApp(
      title: 'Cannlytics',
      debugShowCheckedModeBanner: false,
      // getPages: Routes.routes,
      home: SplashScreen(),
      // home: GetBuilder<AuthController>(
      //   init: AuthController(),
      //   builder: (controller) => controller.loading
      //       ? SplashScreen()
      //       : (controller.signedIn)
      //           ? HomeUI()
      //           : WelcomeUI(),
      // ),
      // initialRoute: '/',
      // navigatorObservers: [AnalyticsService().getAnalyticsObserver()],
      // theme: _theme.themeData,
      // darkTheme: AppThemes.darkTheme,
      // themeMode: Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
  }
}

// // Bootstrap the app, initializing all Controllers and Services.
// class _AppBootstrapper extends StatefulWidget {
//   @override
//   _AppBootstrapperState createState() => _AppBootstrapperState();
// }

// class _AppBootstrapperState extends State<_AppBootstrapper> {
//   AppRouteParser routeParser = AppRouteParser();
//   AppRouterDelegate router;
//   @override
//   void initState() {
//     // Create the appRouter, and inject it with the models/services it needs.
//     router = AppRouterDelegate(
//       context.read<AppModel>(),
//       context.read<BooksModel>(),
//       context.read<FirebaseService>(),
//     );
//     // Run Bootstrap with scheduleMicrotask to avoid triggering any builds from init()
//     scheduleMicrotask(() {
//       // Bootstrap. This will initialize services, load saved data,
//       // determine initial navigation state and anything else
//       // that needs to get done at startup
//       BootstrapCommand().run(context);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       // Convert appState to (and from) a string "location"
//       routeInformationParser: routeParser,
//       // Builds a stack that represents your appState.
//       routerDelegate: router,
//       // Disable debug banner
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
