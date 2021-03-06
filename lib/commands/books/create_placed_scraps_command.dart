import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cannlytics_app/commands/books/update_book_modified_command.dart';
import 'package:cannlytics_app/commands/commands.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:shortid/shortid.dart';

class CreatePlacedScrapCommand extends BaseAppCommand {
  Future<void> run(
      {@required String pageId,
      Size size,
      @required List<ScrapItem> scraps}) async {
    if (scraps?.isEmpty ?? false) return null;
    List<PlacedScrapItem> scrapsToPlace = scraps.map((scrap) {
      bool isText = scrap.contentType == ContentType.Text;
      // Choose some default width for new items
      double contentWidth = 300;
      if (isText) contentWidth = 500;

      return PlacedScrapItem(
        documentId: shortid.generate(),
        bookId: scrap.bookId,
        pageId: pageId,
        aspect: scrap.aspect,
        contentType: scrap.contentType,
        scrapId: scrap.documentId,
        // Assign size, respecting the aspect ratio of the original scrap
        width: size?.width ?? contentWidth,
        height: size?.height ?? contentWidth / scrap.aspect,
        // Randomly scatter scraps
        dx: 200 + Random().nextDouble() * 300,
        dy: 200 + Random().nextDouble() * 300,
        // Assign some default style for Text
        boxStyle: isText
            ? BoxStyle(
                align: TextAlign.left,
                bgColor: Colors.transparent,
                fgColor: Colors.black,
                font: BoxFonts.Lato,
              )
            : null,
        data: scrap.data,
      );
    }).toList();
    // Add them to firebase
    await scrapsToPlace.forEach((s) async {
      String documentId = await firebase.addPlacedScrap(s);
      s = s.copyWith(documentId: documentId);
      // Write documentId back to db
      await firebase.setPlacedScrap(s);
      // Update local data
      booksModel.currentPageScraps =
          List.from(booksModel.currentPageScraps ?? [])..add(s);
      return;
    });
    // Mark book as changed
    UpdateBookModifiedCommand().run(bookId: scrapsToPlace.first.bookId);
  }
}
