import 'package:cannlytics_app/commands/books/update_book_modified_command.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';

class UpdatePageCommand extends BaseAppCommand {
  Future<void> run(ScrapPageData page) async {
    booksModel.replacePage(page);
    await firebase.setPage(page);
    UpdateBookModifiedCommand().run(bookId: page.bookId);
  }
}
