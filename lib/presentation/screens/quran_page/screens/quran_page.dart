import 'package:alquranalkareem/core/widgets/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/svg_picture.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../controllers/bookmarks_controller.dart';
import '../../../controllers/general_controller.dart';
import '../widgets/left_page.dart';
import '../widgets/right_page.dart';
import '/presentation/screens/quran_page/widgets/pages_widget.dart';

class MPages extends StatelessWidget {
  MPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalCtrl = sl<GeneralController>();
    sl<BookmarksController>().getBookmarks();
    return SafeArea(
      child: Stack(
        children: [
          GetBuilder<GeneralController>(
            builder: (generalCtrl) => PageView.builder(
                controller: generalCtrl.pageController(),
                itemCount: 604,
                physics: const ClampingScrollPhysics(),
                onPageChanged: generalCtrl.pageChanged,
                itemBuilder: (_, index) {
                  return (index % 2 == 0
                      ? Semantics(
                          image: true,
                          label: 'Quran Page',
                          child: RightPage(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                PagesWidget(index: index),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      if (sl<BookmarksController>()
                                          .isPageBookmarked(index + 1)) {
                                        sl<BookmarksController>()
                                            .deleteBookmarks(
                                                index + 1, context);
                                      } else {
                                        sl<BookmarksController>()
                                            .addBookmark(
                                                index + 1,
                                                sl<BookmarksController>()
                                                    .soraBookmarkList![
                                                        index + 1]
                                                    .SoraName_ar!,
                                                generalCtrl.timeNow.lastRead)
                                            .then((value) => customSnackBar(
                                                context, 'addBookmark'.tr));
                                        print('addBookmark');
                                        print(
                                            '${generalCtrl.timeNow.lastRead}');
                                        // sl<BookmarksController>()
                                        //     .savelastBookmark(index + 1);
                                      }
                                    },
                                    icon: bookmarkIcon(context, 30.0, 30.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Semantics(
                          image: true,
                          label: 'Quran Page',
                          child: LeftPage(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                PagesWidget(index: index),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    onPressed: () {
                                      if (sl<BookmarksController>()
                                          .isPageBookmarked(index + 1)) {
                                        sl<BookmarksController>()
                                            .deleteBookmarks(
                                                index + 1, context);
                                      } else {
                                        sl<BookmarksController>()
                                            .addBookmark(
                                                index + 1,
                                                sl<BookmarksController>()
                                                    .soraBookmarkList![
                                                        index + 1]
                                                    .SoraName_ar!,
                                                generalCtrl.timeNow.lastRead)
                                            .then((value) => customSnackBar(
                                                context, 'addBookmark'.tr));
                                        print('addBookmark');
                                        print(
                                            '${generalCtrl.timeNow.lastRead}');
                                        // sl<BookmarksController>()
                                        //     .savelastBookmark(index + 1);
                                      }
                                    },
                                    icon: bookmarkIcon(context, 30.0, 30.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                }),
          ),
          Obx(() => generalCtrl.isShowControl.value
              ? const TabBarWidget(isChild: true)
              : const SizedBox.shrink())
        ],
      ),
    );
  }
}
