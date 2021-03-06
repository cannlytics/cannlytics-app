import 'package:cannlytics_app/_utils/string_utils.dart';
import 'package:cannlytics_app/_utils/time_utils.dart';
import 'package:cannlytics_app/commands/books/refresh_all_books_command.dart';
import 'package:cannlytics_app/commands/books/set_current_book_command.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/styles.dart';
import 'package:shortid/shortid.dart';

class CreateFolioCommand extends BaseAppCommand {
  Future<String> run({String title, String desc}) async {
    // Create an empty book
    ScrapBookData book = ScrapBookData(
      documentId: shortid.generate(),
      title: title ?? "",
      desc: desc ?? "",
      creationTime: TimeUtils.nowMillis,
      lastModifiedTime: TimeUtils.nowMillis,
    );
    // Send to server
    String documentId = await firebase.addBook(book);
    if (StringUtils.isNotEmpty(documentId)) {
      // Set as selected book once we get the id back. This will change views
      SetCurrentBookCommand().run(book.copyWith(documentId: documentId));
      // Refresh the book list after a small delay. This allows any transitions to happen before the books lists are updated
      Future.delayed(Times.medium, () => RefreshAllBooks().run());
    }
    return documentId;
  }
}
