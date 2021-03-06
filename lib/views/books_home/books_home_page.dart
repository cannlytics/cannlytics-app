import 'package:flutter/material.dart';
import 'package:cannlytics_app/_widgets/gradient_container.dart';
import 'package:cannlytics_app/commands/books/create_folio_command.dart';
import 'package:cannlytics_app/commands/books/refresh_all_books_command.dart';
import 'package:cannlytics_app/core_packages.dart';
import 'package:cannlytics_app/data/book_data.dart';
import 'package:cannlytics_app/models/books_model.dart';

import 'books_home_page_bottom_nav.dart';
import 'books_home_top_nav_bar.dart';
import 'covers_flow_list.dart';
import 'covers_flow_list_mobile.dart';
import 'covers_sortable_list.dart';

class BooksHomePage extends StatefulWidget {
  @override
  BooksHomePageState createState() => BooksHomePageState();
}

class BooksHomePageState extends State<BooksHomePage> {
  bool _showListView = false;

  @override
  void initState() {
    super.initState();
    RefreshAllBooks().run();
  }

  @override
  Widget build(BuildContext context) {
    List<ScrapBookData> books = context.select((BooksModel m) => m.books);
    bool isMobile = context.widthPx < Sizes.smallPhone;
    books?.sort((a, b) => a.lastModifiedTime > b.lastModifiedTime ? -1 : 1);
    return books == null
        ? LoadingIndicator()
        : StyledPageScaffold(
            body: Stack(
              children: [
                /// Content Area
                /// SB: Disabled IndexedStack for now, focus traversal does not play nicely: https://stackoverflow.com/questions/65888930/flutter-how-to-disable-focustraversal-for-non-visible-children
                /// TODO: Restore this if it gets fixed, or devise an alternate workaround (write our own IndexedStack? The goal is to maintain state of each view, but only allow focus traversal on the active one)
                // IndexedStack(
                //   index: pageIndex,
                //   children: [
                //     /// CoverFlow
                //     CoversFlowList(books: _books),
                //
                //     /// Data-grid List View
                //     ExcludeFocus(excluding: false, child: CoversSortableList(books: _books)),
                //   ],
                // ),
                if (books.isEmpty) ...[
                  _EmptyHomeView(),
                ] else ...[
                  _showListView
                      ? CoversSortableList(books: books, isMobile: isMobile)
                      : isMobile
                          ? CoversFlowListMobile(books: books)
                          : CoversFlowList(books: books),
                ],

                /// Top bar and bottom bar, has welcome message and view switcher
                if (isMobile) ...[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BooksHomePageBottomNav(
                        onToggled: _handleViewToggled,
                        showListView: _showListView),
                  ),
                ] else ...[
                  BooksHomeTopNavBar(
                      onToggled: _handleViewToggled,
                      showListView: _showListView),
                ],
              ],
            ),
          );
    //  },
    //);
  }

  void _handleViewToggled(bool value) => setState(() => _showListView = value);
}

class _EmptyHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      // Bg w/ Gradient
      Positioned.fill(
          child: Image.asset("images/empty_home_bg.png", fit: BoxFit.cover)),
      Align(alignment: Alignment.topLeft, child: _SideGradient()),

      Padding(
        padding: EdgeInsets.all(Insets.offset),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Spacer(),
          Text("Welcome to cannlytics",
              style: TextStyles.h1.copyWith(color: Colors.white)),
          VSpace.sm,
          SizedBox(
            width: 380,
            child: Text(
                "Suspendisse sed libero eget purus efficitur sodales non vel elit. Nulla egestas elit sed enim aliquam rutrum. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                style: TextStyles.body1.copyWith(color: Colors.white)),
          ),
          VSpace.xl,
          Row(
            children: [
              PrimaryBtn(
                  onPressed: _handleNewFolioPressed,
                  label: "YOUR FIRST FOLIO",
                  icon: Icons.add),
            ],
          ),
          Spacer(),
        ]),
      ),
    ]);
  }

  void _handleNewFolioPressed() => CreateFolioCommand().run();
}

class _SideGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: 800,
        child: HzGradient(
            [Colors.black.withOpacity(.75), Colors.black.withOpacity(0)],
            [.2, 1]),
      );
}
