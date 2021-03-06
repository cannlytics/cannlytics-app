import 'package:flutter/material.dart';
import 'package:cannlytics_app/commands/books/delete_page_scrap_command.dart';
import 'package:cannlytics_app/commands/books/shift_placed_scraps_sort_order_command.dart';
import 'package:cannlytics_app/commands/books/update_current_book_cover_photo_command.dart';
import 'package:cannlytics_app/core_packages.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/models/books_model.dart';
import 'package:cannlytics_app/styled_widgets/context_menus/core/base_context_menu.dart';
import 'package:cannlytics_app/styled_widgets/context_menus/core/context_menu_button.dart';
import 'package:cannlytics_app/styled_widgets/context_menus/core/context_menu_card.dart';

class ScrapContextMenu extends BaseContextMenu {
  ScrapContextMenu({Key key, @required this.scrap}) : super(key: key);
  final PlacedScrapItem scrap;

  @override
  Widget build(BuildContext context) {
    // Declare btn handlers inside the build method to avoid boilerplate passing of context ref

    void _handleForwardPressed() =>
        ShiftPlacedScrapsSortOrderCommand().run(1, scrap);
    void _handleBackPressed() =>
        ShiftPlacedScrapsSortOrderCommand().run(-1, scrap);
    void _handleCoverPhotoPressed() async =>
        UpdateCurrentBookCoverPhotoCommand().run(scrap);

    void _handleDeletePressed() => DeletePageScrapCommand().run(scrap);

    String currentCoverPhoto =
        context.select((BooksModel m) => m.currentBook.imageUrl);
    bool isCoverPhoto = scrap.isPhoto && scrap.data == currentCoverPhoto;
    bool disableCoverPhotoBtn = isCoverPhoto || scrap.isPhoto == false;
    AppTheme theme = context.watch();
    return ContextMenuCard(
      children: [
        ContextMenuBtn("Move forward",
            icon: AppIcons.move_forward,
            shortcutLabel: "ctrl + ]",
            onPressed: () => handlePressed(context, _handleForwardPressed)),
        ContextMenuBtn("Send backward",
            shortcutLabel: "ctrl + [",
            icon: AppIcons.send_backward,
            onPressed: () => handlePressed(context, _handleBackPressed)),
        ContextDivider(),
        ContextMenuBtn("Set as cover photo",
            shortcutLabel: "ctrl + k",
            icon: AppIcons.star,
            iconColor: isCoverPhoto ? theme.accent1 : null,
            onPressed: disableCoverPhotoBtn
                ? null
                : () => handlePressed(context, _handleCoverPhotoPressed)),
        ContextMenuBtn("Delete",
            hoverBgColor: theme.greyStrong,
            icon: AppIcons.trashcan,
            onPressed: () => handlePressed(context, _handleDeletePressed)),
      ],
    );
  }
}
