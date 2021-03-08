# <img height="32" alt="" src="https://cannlytics.com/static/cannlytics_website/images/logos/cannlytics_calyx_detailed.svg"> The Cannlytics App

[![license](https://img.shields.io/badge/License-MIT-brightgreen.svg)](https://opensource.org/licenses/MIT)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](https://github.com/cannlytics/cannlytics-console/fork)

Cannlytics is a modern cannabis-testing engine made with love, tried-and-true, and ready to help you superpower your lab or get your lab data quickly and easily. The Cannlytics platform comes with **batteries included**, but you are always welcome to supercharge your setup with modifications and custom components.

- [Introduction](#introduction)
- [Features](#features)
- [Contributing](#contributing)
- [Installation](#installation)
- [Authentication](#authentication)
- [Development](#development)
- [Testing](#testing)
- [Publishing](#publishing)
- [Resources](#resources)
- [License](#license)

## Introduction <a name="introduction"></a>

Cannlytics is a healthy mix of user friendly interfaces and software that you can use in your cannabis-testing lab. Users do not have to have any advanced knowledge and can jump in at any point. There are many advanced features that people with background in the web stack, Python or Flutter, or your favorite programming language can jump right into. The Cannlytics Website provides people with information about Cannlytics. The Cannlytics Engine is a mobile, desktop, and web app that provides administrators, laboratory staff, laboratory clients, and client integrators to interact with laboratory information.

## Features <a name="features"></a>

### 🧪 Labs

| Package     | Details               | Status         |
| ----------- | --------------------- | --------------- |
| Dashboard   | Welcome tutorial, placeholders, and analytics for users with data. | 🟡 In-progress |
| Analysis    |                       | ❌ Not started |
| Clients     |                       | ❌ Not started |
| Intake      |                       | ❌ Not started |
| Logistics   |                       | ❌ Not started |
| Settings    |                       | ❌ Not started |
| Help        | Provide minimal support options, including a feedback form. | ❌ Not started |

### 🌱 Cultivators / Manufacturers

| Package     | Details               | Status         |
| ----------- | --------------------- | --------------- |
| Dashboard   |                       | ❌ Not started |
| Results     |                       | ❌ Not started |
| Scheduling  |                       | ❌ Not started |
| Analytics   |                       | ❌ Not started |

### 🛍️ Retailers / Consumers

| Package     | Details               | Status         |
| ----------- | --------------------- | --------------- |
| Dashboard   |                       | ❌ Not started |
| Results     |                       | ❌ Not started |
| Purchases   |                       | ❌ Not started |
| Analytics   |                       | ❌ Not started |

## Contributing <a name="contributing"></a>

Contributions are always welcome! You are encouraged to submit issues, functionality, and features that you want to be addressed. See [the contributing guide](/contributing.md) to get started. Anyone is welcome to contribute anything. Currently, the Cannlytics Console would love:

* Art;
* More completed code;
* More documentation;
* Ideas and feedback.

## Installation <a name="installation"></a>

First, clone the repository.

```bash
git clone https://github.com/cannlytics/cannlytics-app.git
```

If you're new to Flutter, then you can follow the [Flutter setup instructions](https://flutter.dev/docs/get-started/install). Once you have Flutter setup, then you can use the default `stable` channel, or switch to the latest `dev` version to get the most current fixes for desktop/web:
 * Run `flutter channel dev`
 * Run `flutter upgrade`

You will also need to setup building for your desired platform. If you've never run a desktop build before, then you will need to enable it with a one-time command for your current platform:
* `flutter config --enable-macos-desktop`
* `flutter config --enable-windows-desktop`
* `flutter config --enable-linux-desktop`

## Architecture <a name="architecture"></a>

The architecture of the Cannlytics app is as follows. In general, a model-view-controller (MVC) architecture is followed for user-interface code and business-logic components (BLoC) architecture is followed for the functional services that are used in the MVC user-interface code.

```bash
├── assets
│   └── images
│       ├── icons
│       └── emoji
├── docs
├── lib
│   ├── _utils
│   ├── _widgets
│   ├── commands
│   ├── data
│   ├── models
│   ├── routing
│   ├── services
│   ├── styled_widgets
│   ├── views
│   ├── app_keys.dart
│   ├── core_packages.dart
│   ├── generated_plugin_registrant.dart
│   ├── main_app_scaffold.dart
│   ├── styles.dart
|   └── themes.dart
├── tests
├── web
├── .firebasesrc
├── firebase.json
├── LICENSE
├── pubspec.yaml
└── README.md
```

Helpful resources:

- [Software Architecture Guide](https://martinfowler.com/architecture/)
- [The MVC Architecture](https://www.tripled.io/08/11/2017/mvc-architecture/)

## Authentication <a name="authentication"></a>

The Cannlytics App leverages [Firebase Authentication](https://firebase.google.com/docs/auth). You will need to set your Firebase config in `web/index.html` and in `lib/app_keys.dart`.

## Development <a name="development"></a>

The Cannlytics App began with [Flutter Folio](https://github.com/gskinnerTeam/flutter-folio) as a template, overhauling the state, potentially routing, and dependency management framework to utilize [GetX](https://pub.dev/packages/get).

You can run your app locally for development, adding tags as needed depending on your desired platform.

**Web**

```bash
flutter run -d chrome --no-sound-null-safety
```

**Windows**

```bash
flutter run -d windows --no-sound-null-safety
```

> On windows, you will need to enable developer mode.

```bash
start ms-settings:developers
```

## Testing <a name="testing"></a>

[TODO: Implement testing]

## Publishing <a name="publishing"></a>

You can build the app for the web.

```bash
flutter build web --no-sound-null-safety
```

You can then publish to the web.

```bash
firebase deploy --project cannlytics --only hosting:production
```

## Resources <a name="resources"></a>

- [Flutter Folio - Example Flutter App](https://github.com/gskinnerTeam/flutter-folio)

## License <a name="license"></a>

Copyright (c) 2021 Cannlytics and Cannlytics contributors.

This application is released under the [MIT license](LICENSE.md). You can use the code for any purpose, including commercial projects.

[![license](https://img.shields.io/badge/License-MIT-brightgreen.svg)](https://opensource.org/licenses/MIT)

Made with 💖
