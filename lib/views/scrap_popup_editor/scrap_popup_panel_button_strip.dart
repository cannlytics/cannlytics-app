import 'package:flutter/material.dart';
import 'package:cannlytics_app/_widgets/flexibles/seperated_flexibles.dart';
import 'package:cannlytics_app/_widgets/mixins/loading_state_mixin.dart';
import 'package:cannlytics_app/commands/books/delete_page_scrap_command.dart';
import 'package:cannlytics_app/commands/books/shift_placed_scraps_sort_order_command.dart';
import 'package:cannlytics_app/commands/books/update_current_book_cover_photo_command.dart';
import 'package:cannlytics_app/core_packages.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/models/books_model.dart';

class ScrapPopupPanelButtonStrip extends StatefulWidget {
  const ScrapPopupPanelButtonStrip({Key key, @required this.scrap})
      : super(key: key);
  final PlacedScrapItem scrap;

  @override
  _ScrapPopupPanelButtonStripState createState() =>
      _ScrapPopupPanelButtonStripState();
}

class _ScrapPopupPanelButtonStripState extends State<ScrapPopupPanelButtonStrip>
    with LoadingStateMixin {
  @override
  Widget build(BuildContext context) {
    // Bind to page for rebuilds because our re-order might trigger it
    context.select((BooksModel m) => m.currentPage);
    // Bind to current book cover photo
    String currentCoverPhoto =
        context.select((BooksModel m) => m.currentBook?.imageUrl);
    bool isCoverPhoto =
        widget.scrap.isPhoto && currentCoverPhoto == widget.scrap.data;
    bool disableCoverPhotoBtn = isCoverPhoto || widget.scrap.isPhoto == false;
    return GestureDetector(
      onTap:
          () {}, // Swallow any taps on this stack, so that disabled btns don't trigger a menu close
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.sm),
            child: SeparatedRow(
              mainAxisAlignment: MainAxisAlignment.center,
              separatorBuilder: () => HSpace.sm,
              children: [
                _IconBtn(
                    onPressed: isLoading ? null : _handleSendBackPressed,
                    icon: AppIcons.send_backward),
                _IconBtn(
                    onPressed: isLoading ? null : _handleMoveForwardPressed,
                    icon: AppIcons.move_forward),
                _IconBtn(
                    isSelected: isCoverPhoto,
                    onPressed:
                        disableCoverPhotoBtn ? null : _handleCoverPhotoPressed,
                    icon: AppIcons.star),
                _IconBtn(
                    onPressed: _handleDeletePressed, icon: AppIcons.trashcan),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleDeletePressed() => DeletePageScrapCommand().run(widget.scrap);

  void _handleMoveForwardPressed() => load(() async {
        await ShiftPlacedScrapsSortOrderCommand().run(1, widget.scrap);
      });

  void _handleSendBackPressed() => load(
        () async {
          await ShiftPlacedScrapsSortOrderCommand().run(-1, widget.scrap);
        },
      );

  void _handleCoverPhotoPressed() =>
      UpdateCurrentBookCoverPhotoCommand().run(widget.scrap);
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({Key key, this.onPressed, this.icon, this.isSelected = false})
      : super(key: key);
  final VoidCallback onPressed;
  final AppIcons icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Flexible(
      child: SecondaryBtn(
        child: SizedBox(
            width: double.infinity,
            child: AppIcon(icon,
                color: isSelected ? theme.accent1 : theme.greyStrong,
                size: 16)),
        onPressed: onPressed,
      ),
    );
  }
}
