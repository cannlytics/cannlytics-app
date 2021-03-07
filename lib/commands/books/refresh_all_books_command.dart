import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';
// import 'package:cannlytics_app/services/cloudinary/cloud_storage_service.dart';

class RefreshAllBooks extends BaseAppCommand {
  Future<List<ScrapBookData>> run() async {
    List<ScrapBookData> allBooks = await firebase.getAllBooks();
    // CloudStorageService.addMaxSizeToUrlList<ScrapBookData>(
    //     allBooks, (s) => s.imageUrl, (s, url) => s.copyWith(imageUrl: url));
    booksModel.books = allBooks;
    return booksModel.books;
  }
}
