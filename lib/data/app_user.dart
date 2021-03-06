import 'package:cannlytics_app/_utils/string_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  static String kDefaultImageUrl = "https://cannlytics.page.link/cannbot";
  const AppUser._();
  factory AppUser({
    @nullable String documentId,
    required String email,
    required String fireId,
    String firstName,
    String lastName,
    String imageUrl,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  String getDisplayName() {
    String? result = firstName;
    if (StringUtils.isNotEmpty(lastName)) result += " $lastName";
    return result;
  }
}
