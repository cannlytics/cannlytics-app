import 'package:flutter/material.dart';
import 'package:cannlytics_app/_widgets/popover/popover_notifications.dart';
import 'package:cannlytics_app/_widgets/popover/popover_region.dart';
import 'package:cannlytics_app/commands/app/copy_share_link_command.dart';
import 'package:cannlytics_app/core_packages.dart';
import 'package:cannlytics_app/data/book_data.dart';

class StyledSharedBtn extends StatelessWidget {
  const StyledSharedBtn({
    Key key,
    required this.book,
    this.iconColor,
  }) : super(key: key);
  final Color iconColor;
  final ScrapBookData book;

  @override
  Widget build(BuildContext context) {
    void _handleSharePressed() {
      ClosePopoverNotification().dispatch(context);
      CopyShareLinkCommand().run(book.documentId);
    }

    AppTheme theme = context.watch();
    return PopOverRegion.hover(
        anchor: Alignment.centerRight,
        popAnchor: Alignment.centerLeft,
        popChild: StyledTooltip("Copy Share Link",
            arrowAlignment: Alignment.centerLeft),
        child: SimpleBtn(
            child: Padding(
              padding: EdgeInsets.all(Insets.sm),
              child: Icon(Icons.share, color: iconColor ?? theme.surface1),
            ),
            onPressed: _handleSharePressed));
  }
}
