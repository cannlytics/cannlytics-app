// import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:cannlytics_app/_utils/input_utils.dart';
import 'package:cannlytics_app/_widgets/animated/animated_fractional_offset.dart';
import 'package:cannlytics_app/_widgets/popover/popover_notifications.dart';
import 'package:cannlytics_app/commands/app/set_current_user_command.dart';
import 'package:cannlytics_app/commands/app/update_user_command.dart';
import 'package:cannlytics_app/commands/pick_images_command.dart';
import 'package:cannlytics_app/core_packages.dart';
import 'package:cannlytics_app/data/app_user.dart';
import 'package:cannlytics_app/models/app_model.dart';
import 'package:cannlytics_app/services/cloudinary/cloud_storage_service.dart';

class ProfileEditorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return GestureDetector(
      onTap: InputUtils.unFocus,
      child: Container(
          width: 280,
          height: 380,
          child: Stack(
            children: [
              Positioned.fill(
                  child: AnimatedFractionalOffset(
                duration: Times.medium,
                curve: Curves.easeOut,
                begin: Offset(0, -1),
                end: Offset(0, 0),
                child: Container(
                  padding: EdgeInsets.only(
                      left: Insets.lg, right: Insets.lg, top: Insets.med),
                  decoration: BoxDecoration(
                    color: theme.surface1,
                    borderRadius:
                        BorderRadius.vertical(bottom: Corners.smRadius),
                  ),
                  child: _ProfileEditorCardContent(),
                ),
              )),
              _TopShadow(),
            ],
          )),
    );
  }
}

class BottomSheetProfileEditorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Insets.xl),
      child: _ProfileEditorCardContent(bottomSheet: true),
    );
  }
}

class _ProfileEditorCardContent extends StatefulWidget {
  _ProfileEditorCardContent({this.bottomSheet = false});

  final bool bottomSheet;

  @override
  State createState() => _ProfileEditorCardContentState();
}

class _ProfileEditorCardContentState extends State<_ProfileEditorCardContent> {
  AppUser _user;

  @override
  Widget build(BuildContext context) {
    _user = context.select((AppModel m) => m.currentUser);
    AppTheme theme = context.watch();

    if (_user == null) return Container();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SimpleBtn(
            onPressed: _handleProfileImgPressed,
            child: SizedBox(
              height: 80,
              child: StyledCircleImage(
                  url: _user.imageUrl ?? AppUser.kDefaultImageUrl),
            ),
          ),

          /// Upload PhotoBtn
          SimpleBtn(
            onPressed: _handleProfileImgPressed,
            child: Padding(
              padding: EdgeInsets.all(Insets.sm),
              child: Text(
                "Update Photo",
                style: TextStyles.caption.copyWith(
                    color: theme.mainTextColor,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          VSpace.lg,

          /// TextInputs
          LabeledTextInput(
              label: "First Name",
              text: _user.firstName,
              onChanged: _handleFirstNameChanged),
          VSpace.lg,
          LabeledTextInput(
              label: "Last Name",
              text: _user.lastName,
              onChanged: _handleLastNameChanged),
          VSpace.lg,

          /// Account
          Container(
              width: double.infinity,
              child: Text("Account", style: TextStyles.caption)),
          Row(
            children: [
              Expanded(child: Text(_user.email, style: TextStyles.body3)),
              PrimaryBtn(
                  icon: Icons.logout,
                  leadingIcon: false,
                  label: "LOGOUT",
                  isCompact: true,
                  onPressed: _handleLogoutPressed)
            ],
          ),
        ],
      ),
    );
  }

  void _handleProfileImgPressed() async {
    List<String> paths = await PickImagesCommand().run();
    // CloudStorageService cloudStorage = context.read<CloudStorageService>();
    // List<CloudinaryResponse> uploads =
    //     await cloudStorage.multiUpload(urls: paths);
    // uploads.forEach((u) => safePrint(u.secureUrl));
    // FIXME: Use Firebase Storage instead.
    // Update firebase
    List<Map> uploads = [
      {'secureUrl': 'https//robohash.org/wizard@cannlytics.com.png'},
    ];
    if (uploads?.isNotEmpty ?? false) {
      AppModel m = context.read();
      UpdateUserCommand()
          .run(m.currentUser.copyWith(imageUrl: uploads[0]['secureUrl']));
      m.scheduleSave();
    }
  }

  void _handleFirstNameChanged(String value) {
    AppModel m = context.read();
    m.currentUser = _user.copyWith(firstName: value);
    UpdateUserCommand().run(m.currentUser);
    m.scheduleSave();
  }

  void _handleLastNameChanged(String value) {
    AppModel m = context.read();
    m.currentUser = _user.copyWith(lastName: value);
    UpdateUserCommand().run(m.currentUser);
    m.scheduleSave();
  }

  void _handleLogoutPressed() {
    if (widget.bottomSheet) {
      Navigator.pop(context);
    } else {
      ClosePopoverNotification().dispatch(context);
    }
    SetCurrentUserCommand().run(null);
  }
}

class _TopShadow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRect(
        child: FractionalTranslation(
            translation: Offset(0, -1),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.red, boxShadow: Shadows.universal))),
      ),
    );
  }
}
