import 'package:flutter/material.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/styled_widgets/dialogs/delete_dialog.dart';

class DeleteBookCommand extends BaseAppCommand {
  Future<void> run(ScrapBookData book) async {
    // Show dialog
    bool doDelete = await showDialog(
        context: mainContext,
        builder: (_) => DeleteDialog(
              title: "Delete Folio",
              desc1:
                  "Are you sure you want to permanently\ndelete the selected folio?",
              desc2: "\"${book.title}\"",
            ));
    //Delete
    if (doDelete ?? false) {
      // Delete locally right away
      booksModel.removeBookById(book.documentId);
      // Sent to database
      firebase.deleteBook(book);
    }
  }
}
