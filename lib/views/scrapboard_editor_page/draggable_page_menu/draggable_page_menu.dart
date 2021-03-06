import 'package:flutter/material.dart';
import 'package:cannlytics_app/commands/books/update_book_command.dart';
import 'package:cannlytics_app/core_packages.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/models/books_model.dart';
import 'package:cannlytics_app/views/scrapboard_editor_page/draggable_page_menu/draggable_page_title_btn.dart';

class DraggablePagesMenu extends StatefulWidget {
  const DraggablePagesMenu(
      {Key key,
      @required this.pages,
      @required this.pageId,
      @required this.onPressed})
      : super(key: key);
  final List<ScrapPageData> pages;
  final String pageId;
  final void Function(ScrapPageData page) onPressed;
  @override
  DraggablePagesMenuState createState() => DraggablePagesMenuState();
}

class DraggablePagesMenuState extends State<DraggablePagesMenu> {
  static const double menuItemHeight = 48;

  ValueNotifier<int> _hoverIndexNotifier = ValueNotifier(-1);

  bool get isDragging => hoverIndex != -1;
  int get hoverIndex => _hoverIndexNotifier.value;
  List<ScrapPageData> get pages => widget.pages;
  String get currentPageId => widget.pageId;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<ScrapPageData>(
      onMove: _handleItemMoved,
      onAcceptWithDetails: _handleItemDropped,
      builder: (_, __, ___) {
        // Rebuild anytime hoverIndex changes
        return ValueListenableBuilder<int>(
          valueListenable: _hoverIndexNotifier,
          builder: (_, index, __) {
            return StyledScrollbar(
              padding: EdgeInsets.zero,
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Stack(
                  children: [
                    Column(
                      children: () {
                        /// Create a btn for each item in the list
                        List<Widget> menuItems = pages.map((page) {
                          bool isSelected = currentPageId == page.documentId;
                          return DraggablePageTitleBtn(
                            page,
                            key: ValueKey(page.documentId),
                            isSelected: isSelected,
                            onPressed: () => widget.onPressed?.call(page),
                            onDragCancelled: _handleDragCancelled,
                            height: menuItemHeight,
                          );
                        }).toList();
                        return menuItems;
                      }(),
                    ),

                    /// Show an outline for the selected index
                    if (hoverIndex != -1)
                      _SelectedPageOutline(
                        top: hoverIndex * menuItemHeight,
                        height: menuItemHeight,
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

// When an item is dropped, re-order it, and clear the hoverIndex.
  bool _handleItemDropped(DragTargetDetails<ScrapPageData> details) {
    List<ScrapPageData> pages = List.from(widget.pages);
    int oldIndex = pages.indexOf(details.data);
    safePrint("Dropped: ${details.data}");
    int newIndex = hoverIndex;
    pages.removeAt(oldIndex);
    pages.insert(newIndex, details.data);
    ScrapBookData currentBook = context.read<BooksModel>().currentBook;
    // pages.forEach((element) {
    //   print(element);
    // });
    UpdateBookCommand().run(currentBook.copyWith(
      pageOrder: pages.map((e) => e.documentId).toList(),
    ));
    _hoverIndexNotifier.value = -1;
    return false;
  }

// Calculates the new hoverIndex of the Draggable while dragging. When index changes,
// the view will be rebuilt and the selected outline will move.
  void _handleItemMoved(DragTargetDetails<dynamic> details) {
    // Convert globalOffset to local
    RenderBox rb = context.findRenderObject() as RenderBox;
    Offset localPos =
        rb.globalToLocal(details.offset + Offset(0, menuItemHeight / 2));
    int newIndex =
        (localPos.dy / menuItemHeight).clamp(0, pages.length - 1).floor();
    if (newIndex != hoverIndex) {
      _hoverIndexNotifier.value = newIndex;
    }
  }

  void _handleDragCancelled() => _hoverIndexNotifier.value = -1;
}

class _SelectedPageOutline extends StatelessWidget {
  const _SelectedPageOutline(
      {Key key, @required this.top, @required this.height})
      : super(key: key);
  final double top;
  final double height;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.read();
    return Positioned(
        left: 0,
        right: 0,
        top: top,
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border.all(color: theme.accent1.withOpacity(.6), width: 2)),
        ),
        height: height);
  }
}
