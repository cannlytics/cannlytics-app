import 'package:flutter/material.dart';
import 'package:cannlytics_app/commands/app/copy_share_link_command.dart';
import 'package:cannlytics_app/commands/books/update_book_command.dart';
import 'package:cannlytics_app/core_packages.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/models/books_model.dart';

class EditorPanelInfo extends StatefulWidget {
  const EditorPanelInfo({Key key, @required this.width, @required this.height})
      : super(key: key);
  final double width;
  final double height;

  @override
  _EditorPanelInfoState createState() => _EditorPanelInfoState();
}

class _EditorPanelInfoState extends State<EditorPanelInfo> {
  ScrapBookData _book;
  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    _book = context.select((BooksModel m) => m.currentBook) ?? _book;
    return CollapsingCard(
      height: widget.height,
      title: "Folio Information",
      titleClosed: _book.title,
      icon: IconBtn(Icons.share,
          padding: EdgeInsets.all(Insets.sm),
          color: theme.greyStrong,
          onPressed: _handleSharePressed),
      child: Padding(
        padding: EdgeInsets.all(Insets.lg).copyWith(top: Insets.med),
        child: Container(
          width: double.infinity,
          height: widget.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InlineTextEditor(
                _book.title,
                width: widget.width * Insets.med * 2,
                style: TextStyles.body3.copyWith(color: theme.greyStrong),
                onFocusOut: _handleTitleChanged,
                promptText: "Add Title",
              ),
              VSpace.xs,
              Expanded(
                child: InlineTextEditor(
                  _book.desc,
                  width: widget.width * Insets.med * 2,
                  style: TextStyles.caption.copyWith(color: theme.greyMedium),
                  alignVertical: TextAlignVertical.top,
                  maxLines: 4,
                  onFocusOut: _handleDescChanged,
                  promptText: "Add Description",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTitleChanged(String value) =>
      UpdateBookCommand().run(_book.copyWith(title: value));
  void _handleDescChanged(String value) =>
      UpdateBookCommand().run(_book.copyWith(desc: value));

  void _handleSharePressed() => CopyShareLinkCommand().run(
        _book.documentId,
        pageId: context.read<BooksModel>().currentPageId,
      );
}
