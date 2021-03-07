import 'package:flutter/material.dart';
import 'package:cannlytics_app/_utils/color_utils.dart';
import 'package:cannlytics_app/_utils/debouncer.dart';
import 'package:cannlytics_app/_widgets/context_menu_overlay.dart';
import 'package:cannlytics_app/commands/books/delete_page_command.dart';
import 'package:cannlytics_app/commands/books/update_page_command.dart';
import 'package:cannlytics_app/core_packages.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/models/app_model.dart';

class DraggablePageTitleBtn extends StatefulWidget {
  const DraggablePageTitleBtn(
    this.page, {
    required Key key,
    required this.onPressed,
    required this.onDragCancelled,
    required this.height,
    this.isSelected = false,
    this.isDragFeedback = false,
  }) : super(key: key);
  final ScrapPageData page;
  final VoidCallback onPressed;
  final VoidCallback onDragCancelled;
  final double height;
  final bool isSelected;
  final bool isDragFeedback;

  @override
  _DraggablePageTitleBtnState createState() => _DraggablePageTitleBtnState();
}

class _DraggablePageTitleBtnState extends State<DraggablePageTitleBtn> {
  bool _isDragActivated = false;
  Debouncer _textDebounce = Debouncer(Duration(milliseconds: 100));

  @override
  Widget build(BuildContext context) {
    void _handleTitleChanged(String value) {
      _textDebounce.call(() {
        UpdatePageCommand().run(widget.page.copyWith(title: value));
      });
    }

    Widget _wrapDraggable(Widget child) {
      return Draggable<ScrapPageData>(
          data: widget.page,
          // Make a copy of ourselves as the drag feedack
          feedback: DraggablePageTitleBtn(
            widget.page,
            key: GlobalKey(),
            height: widget.height,
            isSelected: widget.isSelected,
            isDragFeedback: true,
            onPressed: () {},
            onDragCancelled: () {},
          ),
          onDragStarted: _handleDragStart,
          onDragEnd: _handleDragEnd,
          onDraggableCanceled: (_, __) => widget.onDragCancelled?.call(),
          childWhenDragging: Opacity(child: child, opacity: .4),
          child: child);
    }

    bool touchMode = context.select((AppModel m) => m.enableTouchMode);
    double tileHeight = 48;
    AppTheme theme = context.watch();
    String label = widget.page.title ?? "Untitled Page";
    // Create the highlight color
    Color bgColor = theme.surface1;
    if (widget.isSelected) {
      // Blend some accent color onto our bg color
      bgColor = ColorUtils.blend(bgColor, theme.accent1, .15);
    }
    Widget bgWidget = Container(color: bgColor, width: 250, height: tileHeight);

    Widget innerContent = Stack(children: [
      /// In mouse mode, our background is draggable, in touch mode its not because we want the list itself to be scrollable.
      touchMode == false ? _wrapDraggable(bgWidget) : bgWidget,

      ///Content Row
      Positioned.fill(
          child: Row(
        children: [
          // Left-side thick vertical divider
          Container(
              width: 4,
              height: double.infinity,
              color: widget.isSelected ? theme.accent1 : Colors.transparent),
          HSpace.lg,
          // Title
          widget.isSelected
              ? InlineTextEditor(
                  label,
                  onChanged: _handleTitleChanged,
                  enableContextMenu: false,
                  style: TextStyles.body3.copyWith(color: theme.accent1),
                  width: 120,
                  promptText: "Add Page Title",
                )
              : Text(label, style: TextStyles.caption),
          //
          Spacer(),
          if (!widget.isDragFeedback) ...[
            _wrapDraggable(
              _FadingDragHandle(
                key: GlobalKey(),
                width: 40,
                height: double.infinity,
                opacity: touchMode ? 1 : 0,
                isSelected: widget.isSelected,
              ),
            ),
          ]
        ],
      )),
      if (_isDragActivated) ...[
        Positioned.fill(child: Container(color: theme.bg1.withOpacity(.4))),
      ]
    ]);

    // Wrap the content in a btn if we're not selected
    if (!widget.isSelected) {
      innerContent =
          SimpleBtn(onPressed: widget.onPressed, child: innerContent);
    }

    return ContextMenuRegion(
      contextMenu: GenericContextMenu(
        labels: ["View", "Delete"],
        actions: [
          widget.isSelected ? () {} : widget.onPressed,
          _handleDeletePressed
        ],
      ),
      child: innerContent,
    );
  }

  void _handleDeletePressed() => DeletePageCommand().run(widget.page);

  void _handleDragStart() {
    setState(() => _isDragActivated = true);
  }

  void _handleDragEnd(DraggableDetails details) {
    setState(() => _isDragActivated = false);
  }
}

class _FadingDragHandle extends StatelessWidget {
  const _FadingDragHandle({
    required Key key,
    required this.height,
    required this.width,
    required this.opacity,
    required this.isSelected,
  }) : super(key: key);

  final double height;
  final double width;
  final double opacity;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    MaterialIcon icon = MaterialIcon(Icons.drag_indicator,
        color: isSelected ? theme.accent1 : theme.grey);
    return AnimatedOpacity(
      duration: Times.fast,
      opacity: opacity,
      child: Container(width: width, height: height, child: icon),
    );
  }
}
