import 'dart:math';

import 'package:cannlytics_app/_utils/time_utils.dart';
import 'package:cannlytics_app/commands/books/update_book_modified_command.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';

class UpdatePageCountCommand extends BaseAppCommand {
  Future<int> run(int value, {ScrapBookData book}) async {
    book ??= booksModel.currentBook;
    value = max(0, value);
    ScrapBookData newBook = book.copyWith(
      lastModifiedTime: TimeUtils.nowMillis,
      pageCount: value,
    );
    booksModel.replaceBook(newBook);
    await firebase.setBook(newBook);
    UpdateBookModifiedCommand().run(book: newBook);
    return value;
  }

  Future<int> incrementCurrent() async {
    ScrapBookData book = booksModel.currentBook;
    return await run(book.pageCount + 1, book: book);
  }

  Future<int> decrementCurrent() async {
    ScrapBookData book = booksModel.currentBook;
    return await run(book.pageCount - 1, book: book);
  }
}
