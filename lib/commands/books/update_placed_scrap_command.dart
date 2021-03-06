import 'package:cannlytics_app/_utils/time_utils.dart';
import 'package:cannlytics_app/commands/books/update_book_modified_command.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';

class UpdatePageScrapCommand extends BaseAppCommand {
  Future<void> run(PlacedScrapItem scrapItem, {bool localOnly = false}) async {
    PlacedScrapItem newScrap =
        scrapItem.copyWith(lastModifiedTime: TimeUtils.nowMillis);
    booksModel.replaceCurrentPageScrap(newScrap);
    if (localOnly == false) {
      firebase.setPlacedScrap(newScrap);
      UpdateBookModifiedCommand().run(bookId: scrapItem.bookId);
    }
  }
}
