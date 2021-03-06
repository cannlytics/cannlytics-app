import 'package:cannlytics_app/_utils/string_utils.dart';
import 'package:cannlytics_app/_utils/time_utils.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';

class UpdateBookModifiedCommand extends BaseAppCommand {
  Future<void> run({String bookId, ScrapBookData book}) async {
    assert(StringUtils.isNotEmpty(bookId) || book != null,
        "You must pass either an id or an instance to this Command.");
    // fetch a book, or use the one passed in
    book ??= await firebase.getBook(bookId: bookId);
    book = book.copyWith(lastModifiedTime: TimeUtils.nowMillis);
    booksModel.replaceBook(book);
    firebase.setBook(book);
  }
}
