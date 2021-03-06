import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cannlytics_app/_utils/keyboard_utils.dart';
import 'package:cannlytics_app/_widgets/mixins/raw_keyboard_listener_mixin.dart';
import 'package:cannlytics_app/commands/books/delete_page_scrap_command.dart';
import 'package:cannlytics_app/commands/books/shift_placed_scraps_sort_order_command.dart';
import 'package:cannlytics_app/commands/books/update_current_book_cover_photo_command.dart';
import 'package:cannlytics_app/core_packages.dart';
import 'package:cannlytics_app/data/book_data.dart';

// Listens to common keyboard shortcuts for all scraps.
class ScrapKeyboardShortcutsListener extends StatefulWidget {
  const ScrapKeyboardShortcutsListener(
      {Key key,
      @required this.child,
      this.enableKeyListener,
      @required this.item})
      : super(key: key);
  final Widget child;
  final bool enableKeyListener;
  final PlacedScrapItem item;

  @override
  _ScrapKeyboardShortcutsListenerState createState() =>
      _ScrapKeyboardShortcutsListenerState();
}

class _ScrapKeyboardShortcutsListenerState
    extends State<ScrapKeyboardShortcutsListener>
    with RawKeyboardListenerMixin {
  bool _isEditingText = false;

  @override
  bool get enableKeyListener =>
      widget.enableKeyListener && _isEditingText == false;

  @override
  Widget build(BuildContext context) {
    if (widget.item.isText == false) {
      return widget.child;
    } else {
      /// For text scraps, we must ignore Backspace and Delete when user is typing
      /// Listener for events from any embedded textFields so we can disable our static listeners
      return NotificationListener(
          onNotification: (Notification n) {
            if (n is InlineTextEditorFocusNotification) {
              _isEditingText = n.hasFocus;
              return true;
            }
            return false;
          },
          child: widget.child);
    }
  }

  @override
  void handleKeyDown(RawKeyDownEvent value) {
    if (KeyboardUtils.isCommandOrControlDown) {
      if (value.logicalKey == LogicalKeyboardKey.bracketLeft) {
        ShiftPlacedScrapsSortOrderCommand().run(-1, widget.item);
      }
      if (value.logicalKey == LogicalKeyboardKey.bracketRight) {
        ShiftPlacedScrapsSortOrderCommand().run(1, widget.item);
      }
      if (value.logicalKey == LogicalKeyboardKey.keyK) {
        UpdateCurrentBookCoverPhotoCommand().run(widget.item);
      }
    }
    if (value.logicalKey == LogicalKeyboardKey.delete ||
        value.logicalKey == LogicalKeyboardKey.backspace) {
      DeletePageScrapCommand().run(widget.item);
    }
  }
}
