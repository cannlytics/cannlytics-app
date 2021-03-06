import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/services/cloudinary/cloud_storage_service.dart';

class RefreshCurrentBookCommand extends BaseAppCommand {
  Future<void> run(
      {bool book = true, bool pages = true, bool scraps = true}) async {
    String bookId = booksModel.currentBookId;
    List<Future> futures = [
      if (book)
        firebase.getBook(bookId: bookId).then((value) {
          booksModel.currentBook = value;
        }),
      if (pages)
        firebase.getAllPages(bookId: bookId).then((value) {
          booksModel.currentBookPages = value
            ..removeWhere((p) => p.documentId == null);
        }),
      if (scraps)
        firebase.getAllBookScraps(bookId: bookId).then((value) {
          CloudStorageService.addMaxSizeToUrlList<ScrapItem>(
            value,
            (s) => s.data,
            (s, url) => s.copyWith(data: url),
          );
          booksModel.currentBookScraps = value;
        }),
    ];
    await Future.wait(futures);
  }

  void onlyScraps() => run(book: false, pages: false);
  void onlyPages() => run(book: false);
}
