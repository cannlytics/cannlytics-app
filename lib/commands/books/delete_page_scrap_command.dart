import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';

import 'update_book_modified_command.dart';

class DeletePageScrapCommand extends BaseAppCommand {
  Future<void> run(PlacedScrapItem scrap) async {
    booksModel.removePageScrapById(scrap.documentId);
    UpdateBookModifiedCommand().run(bookId: scrap.bookId);
    await firebase.deletePlacedScrap(scrap);
  }
}
