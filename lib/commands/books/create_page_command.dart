import 'package:flutter/material.dart';
import 'package:cannlytics_app/commands/books/create_placed_scraps_command.dart';
import 'package:cannlytics_app/commands/books/update_page_count_command.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:shortid/shortid.dart';

class CreatePageCommand extends BaseAppCommand {
  Future<void> run() async {
    // Increment pageCount
    int count = await UpdatePageCountCommand()
        .run(booksModel.currentBookPages.length + 1);
    // Create new page
    ScrapPageData newPage = ScrapPageData(
      documentId: shortid.generate(),
      bookId: booksModel.currentBook.documentId,
      title: "Page $count",
      desc: "Add a description...",
      boxOrder: [],
    );

    /// Add page locally
    booksModel.currentBookPages = List.from(booksModel.currentBookPages)
      ..add(newPage);
    if (booksModel.currentPage == null) {
      booksModel.currentPage = newPage;
    }

    /// Add to database
    String pageId = await firebase.addPage(newPage);

    // Add a hidden scrap, this sidesteps a bug in firedart regarding empty collections.
    ScrapItem emptyScrap = ScrapItem(
        bookId: newPage.bookId, contentType: ContentType.Hidden, data: "");
    await CreatePlacedScrapCommand()
        .run(pageId: pageId, size: Size.zero, scraps: [emptyScrap]);
  }
}
