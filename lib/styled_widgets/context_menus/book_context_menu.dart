import 'package:flutter/material.dart';
import 'package:cannlytics_app/commands/app/copy_share_link_command.dart';
import 'package:cannlytics_app/commands/books/delete_book_command.dart';
import 'package:cannlytics_app/commands/books/set_current_book_command.dart';
import 'package:cannlytics_app/core_packages.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/styled_widgets/context_menus/core/base_context_menu.dart';
import 'package:cannlytics_app/styled_widgets/context_menus/core/context_menu_button.dart';
import 'package:cannlytics_app/styled_widgets/context_menus/core/context_menu_card.dart';

class BookContextMenu extends BaseContextMenu {
  BookContextMenu(this.book);
  final ScrapBookData book;

  void _handleViewPressed(BuildContext context) =>
      SetCurrentBookCommand().run(book);
  void _handleSharePressed() => CopyShareLinkCommand().run(book.documentId);
  void _handleDeletePressed() {
    DeleteBookCommand().run(book);
  }

  @override
  Widget build(BuildContext context) {
    return ContextMenuCard(
      children: [
        ContextMenuBtn("View",
            icon: AppIcons.view,
            onPressed: () =>
                handlePressed(context, () => _handleViewPressed(context))),
        ContextDivider(),
        ContextMenuBtn("Share",
            icon: AppIcons.share,
            onPressed: () =>
                handlePressed(context, () => _handleSharePressed())),
        ContextDivider(),
        ContextMenuBtn("Delete",
            icon: AppIcons.trashcan,
            onPressed: () =>
                handlePressed(context, () => _handleDeletePressed())),
      ],
    );
  }
}
