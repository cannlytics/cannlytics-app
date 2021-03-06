import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cannlytics_app/_utils/string_utils.dart';
import 'package:cannlytics_app/commands/books/update_page_count_command.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/styled_widgets/dialogs/delete_dialog.dart';

class DeletePageCommand extends BaseAppCommand {
  Future<void> run(ScrapPageData page) async {
    // Show dialog
    bool doDelete = await showDialog(
        context: mainContext,
        builder: (_) {
          String title =
              "${StringUtils.isNotEmpty(page.title) ? "\"${page.title}\"" : ""}";
          if (title.length > 30) title = title.substring(0, 30) + "...";
          return DeleteDialog(
            title: "Delete Page $title?",
            desc1: "Are you sure you want to permanently\ndelete this page?",
          );
        });
    //Delete
    if (doDelete ?? false) {
      // If we're deleting the current page, we will want to select another one if we can.
      bool wasCurrentPage =
          booksModel.currentPage?.documentId == page.documentId;

      // Remove page locally
      booksModel.removePageById(page.documentId);
      if (wasCurrentPage && booksModel.currentBookPages.isNotEmpty) {
        booksModel.currentPage = booksModel.currentBookPages.first;
      }

      // Select a replacement page if we can, since we deleted the current one
      if (wasCurrentPage && booksModel.currentBookPages.isNotEmpty) {
        // Decrement pageCount
        await UpdatePageCountCommand()
            .run(max(booksModel.currentBookPages.length - 1, 0));
      }

      // Remove page from db
      await firebase.deletePage(bookId: page.bookId, pageId: page.documentId);

      // Decrement the page count
      bool isCurrentBook = booksModel.currentBookId == page.bookId;
      ScrapBookData book = isCurrentBook
          ? booksModel.currentBook
          : (await firebase.getBook(bookId: page.bookId));
      UpdatePageCountCommand().run(book.pageCount - 1, book: book);
    }
  }
}
