import 'package:cannlytics_app/_utils/time_utils.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';

class UpdateBookCommand extends BaseAppCommand {
  Future<void> run(ScrapBookData book) async {
    booksModel.replaceBook(book);
    await firebase.setBook(book.copyWith(
      lastModifiedTime: TimeUtils.nowMillis,
    ));
  }
}
