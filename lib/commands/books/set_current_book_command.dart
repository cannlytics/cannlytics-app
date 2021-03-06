import 'package:cannlytics_app/_utils/input_utils.dart';
import 'package:cannlytics_app/commands/books/refresh_current_book_command.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';

import 'set_current_page_command.dart';

class SetCurrentBookCommand extends BaseAppCommand {
  Future<void> run(ScrapBookData book, {bool setInitialPage = true}) async {
    booksModel.currentBook = book;
    if (book != null) {
      // Because TextEditing relies on FocusOut for saving, we have to make sure we focus out before changing books
      InputUtils.unFocus();
      // Load new book contents
      await RefreshCurrentBookCommand().run();
      // If we have any pages, set the first one as the current page
      if (setInitialPage &&
          (booksModel.currentBookPages?.isNotEmpty ?? false)) {
        await SetCurrentPageCommand().run(booksModel.currentBookPages[0]);
      }
    }
  }
}
