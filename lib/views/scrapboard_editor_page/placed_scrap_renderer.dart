import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:cannlytics_app/_utils/debouncer.dart';
import 'package:cannlytics_app/_utils/string_utils.dart';
import 'package:cannlytics_app/_widgets/app_image.dart';
import 'package:cannlytics_app/_widgets/context_menu_overlay.dart';
import 'package:cannlytics_app/commands/books/update_placed_scrap_command.dart';
import 'package:cannlytics_app/core_packages.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/styled_widgets/emoji.dart';
import 'package:cannlytics_app/views/scrapboard_editor_page/placed_scrap_keyboard_listener.dart';

class PlacedScrapRenderer extends StatelessWidget {
  const PlacedScrapRenderer(
    this.item, {
    required Key key,
    required this.isSelected,
    required this.onEditStarted,
    required this.onEditEnded,
  }) : super(key: key);
  final PlacedScrapItem item;
  final bool isSelected;
  final VoidCallback onEditStarted;
  final VoidCallback onEditEnded;

  @override
  Widget build(BuildContext context) {
    Widget? scrapBox;
    // Figure out what type of renderer to use for this srap
    if (item.isPhoto)
      scrapBox = _PhotoBox(item, key: GlobalKey<ScaffoldState>());
    if (item.isEmoji)
      scrapBox = _EmojiBox(item, key: GlobalKey<ScaffoldState>());
    if (item.isText)
      scrapBox = _TextBox(
        item,
        key: GlobalKey<ScaffoldState>(),
        isSelected: isSelected,
        onEditStarted: onEditStarted,
        onEditEnded: onEditEnded,
      );
    // Couldn't find a renderer, fail gracefully but make sure we hide the invalid content
    if (scrapBox == null) {
      debugPrint(
          "[PlacedScrapRenderer] Warning: Unknown scrap type found: ${item.contentType}");
      return SizedBox(width: 0, height: 0);
    }

    return ScrapKeyboardShortcutsListener(
      key: GlobalKey<ScaffoldState>(),
      item: item,
      enableKeyListener: isSelected,
      child: ContextMenuRegion(
        contextMenu: ScrapContextMenu(scrap: item),
        child: Container(
          color: Colors.transparent,
          child: scrapBox,
        ),
      ),
    );
  }
}

class _EmojiBox extends StatelessWidget {
  const _EmojiBox(this.item, {required Key key}) : super(key: key);
  final PlacedScrapItem item;

  @override
  Widget build(BuildContext context) {
    // If emoji is length of 1, this is legacy data, have a beer!
    if (StringUtils.isEmpty(item.data) || item.data.length <= 2) {
      return Emoji(Emojis.beers);
    }
    return Emoji(EnumToString.fromString(Emojis.values, item.data));
  }
}

class _PhotoBox extends StatelessWidget {
  const _PhotoBox(this.item, {required Key key}) : super(key: key);
  final PlacedScrapItem item;

  @override
  Widget build(BuildContext context) =>
      HostedImage(item.data, fit: BoxFit.cover);
}

class _TextBox extends StatefulWidget {
  const _TextBox(this.item,
      {required Key key,
      this.isSelected = false,
      required this.onEditStarted,
      required this.onEditEnded})
      : super(key: key);
  final PlacedScrapItem item;
  final bool isSelected;
  final VoidCallback onEditStarted;
  final VoidCallback onEditEnded;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<_TextBox> {
  Debouncer textChangedDebounce = Debouncer(Duration(milliseconds: 150));
  String _txtValue = '';

  @override
  void initState() {
    super.initState();
    _txtValue = widget.item.data;
  }

  @override
  Widget build(BuildContext context) {
    // Write the text to
    void _handleTextChanged(String value) {
      // Update local data immediately, but debounce the firebase call
      PlacedScrapItem newItem = widget.item.copyWith(data: value);
      UpdatePageScrapCommand().run(newItem, localOnly: true);
      // Debounce db update
      textChangedDebounce.call(() => UpdatePageScrapCommand().run(newItem));
      setState(() => _txtValue = value);
    }

    String promptText = "Type something...";
    return Container(
      padding: EdgeInsets.all(8.0),
      color: widget.item.boxStyle?.bgColor ?? Colors.transparent,
      child: LayoutBuilder(builder: (_, constraints) {
        return AutoSizeText(
          StringUtils.defaultOnEmpty(_txtValue, promptText),
          minFontSize: 10,
          maxFontSize: 999,
          textBuilder: (size, style, numLines) {
            style = style.copyWith(color: widget.item.boxStyle.fgColor);
            TextAlign textAlign = widget.item.boxStyle.align;
            return widget.isSelected
                ? InlineTextEditor(
                    widget.item.data,
                    autoFocus: false,
                    alignVertical: TextAlignVertical.center,
                    align: textAlign,
                    width: constraints.maxWidth,
                    promptText: promptText,
                    maxLines: numLines,
                    enableContextMenu: false,
                    onFocusOut: _handleTextChanged,
                    // SB: Due to a bug in Flutter where we were missing focusOut events, we're saving on every keystroke for this editor.
                    onChanged: _handleTextChanged,
                    style: style.copyWith(
                        fontSize: size,
                        fontFamily: boxFontToFamily(widget.item.boxStyle.font)),
                  )
                : Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        StringUtils.defaultOnEmpty(
                            widget.item.data, promptText),
                        style: style.copyWith(
                            fontSize: size,
                            fontFamily:
                                boxFontToFamily(widget.item.boxStyle.font)),
                        maxLines: numLines,
                        textAlign: textAlign),
                  );
          },
          style: TextStyle(fontSize: 999, letterSpacing: 0, height: 1.25),
        );
      }),
    );
  }
}
