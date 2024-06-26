import 'dart:developer';

import 'package:alquranalkareem/presentation/controllers/quran_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants/extensions/extensions.dart';
import '../../../../core/utils/helpers/responsive.dart';
import '../../../controllers/bookmarks_controller.dart';
import '../../../controllers/general_controller.dart';
import '../../../controllers/translate_controller.dart';
import '../widgets/pages/left_page.dart';
import '../widgets/pages/pages_widget.dart';
import '../widgets/pages/right_page.dart';
import '../widgets/pages/top_title_widget.dart';
import '/presentation/controllers/audio_controller.dart';

class QuranPages extends StatelessWidget {
  QuranPages({Key? key}) : super(key: key);
  final audioCtrl = sl<AudioController>();
  final quranCtrl = sl<QuranController>();
  final bookmarkCtrl = sl<BookmarksController>();

  @override
  Widget build(BuildContext context) {
    bookmarkCtrl.getBookmarks();
    return SafeArea(
      child: GetBuilder<GeneralController>(
        builder: (generalCtrl) => GestureDetector(
          onTap: () {
            audioCtrl.clearSelection();
          },
          onScaleStart: (details) {
            quranCtrl.baseScaleFactor.value = quranCtrl.scaleFactor.value;
          },
          onScaleUpdate: (ScaleUpdateDetails details) {
            quranCtrl.scaleFactor.value =
                quranCtrl.baseScaleFactor.value * details.scale;
          },
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            child: PageView.builder(
              controller: generalCtrl.pageController,
              itemCount: 604,
              padEnds: false,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              onPageChanged: generalCtrl.pageChanged,
              itemBuilder: (_, index) {
                sl<TranslateDataController>().fetchTranslate(context);
                log('width: ${MediaQuery.sizeOf(context).width}');
                return Responsive.isMobile(context) ||
                        Responsive.isMobileLarge(context)
                    ? Center(
                        child: index.isEven
                            ? RightPage(
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: TopTitleWidget(
                                            index: index, isRight: true)),
                                    Align(
                                        alignment: Alignment.center,
                                        child: PagesWidget(pageIndex: index)),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          quranCtrl.getHizbQuarterDisplayByPage(
                                              index + 1),
                                          style: TextStyle(
                                              fontSize:
                                                  context.customOrientation(
                                                      18.0, 22.0),
                                              fontFamily: 'naskh',
                                              color: const Color(0xff77554B)),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child:
                                              quranCtrl.showVerseToast(index)),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        '${generalCtrl.convertNumbers('${index + 1}')}',
                                        style: TextStyle(
                                            fontSize: context.customOrientation(
                                                20.0, 22.0),
                                            fontFamily: 'naskh',
                                            color: const Color(0xff77554B)),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : LeftPage(
                                child: Stack(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: TopTitleWidget(
                                            index: index, isRight: false)),
                                    Align(
                                        alignment: Alignment.center,
                                        child: PagesWidget(pageIndex: index)),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          quranCtrl.getHizbQuarterDisplayByPage(
                                              index + 1),
                                          style: TextStyle(
                                              fontSize:
                                                  context.customOrientation(
                                                      18.0, 22.0),
                                              fontFamily: 'naskh',
                                              color: const Color(0xff77554B)),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: quranCtrl.showVerseToast(index),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        '${generalCtrl.convertNumbers('${index + 1}')}',
                                        style: TextStyle(
                                            fontSize: context.customOrientation(
                                                20.0, 22.0),
                                            fontFamily: 'naskh',
                                            color: const Color(0xff77554B)),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                    : Center(
                        child: index.isEven
                            ? RightPage(
                                child: ListView(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TopTitleWidget(index: index, isRight: true),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 32.0,
                                      ),
                                      child: PagesWidget(pageIndex: index),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          quranCtrl.getHizbQuarterDisplayByPage(
                                              index + 1),
                                          style: TextStyle(
                                              fontSize:
                                                  context.customOrientation(
                                                      18.0, 22.0),
                                              fontFamily: 'naskh',
                                              color: const Color(0xff77554B)),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child:
                                              quranCtrl.showVerseToast(index)),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        '${generalCtrl.convertNumbers('${index + 1}')}',
                                        style: TextStyle(
                                            fontSize: context.customOrientation(
                                                18.0, 22.0),
                                            fontFamily: 'naskh',
                                            color: const Color(0xff77554B)),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : LeftPage(
                                child: ListView(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TopTitleWidget(
                                        index: index, isRight: false),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 32.0,
                                      ),
                                      child: PagesWidget(pageIndex: index),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          quranCtrl.getHizbQuarterDisplayByPage(
                                              index + 1),
                                          style: TextStyle(
                                              fontSize:
                                                  context.customOrientation(
                                                      18.0, 22.0),
                                              fontFamily: 'naskh',
                                              color: const Color(0xff77554B)),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child:
                                              quranCtrl.showVerseToast(index)),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        '${generalCtrl.convertNumbers('${index + 1}')}',
                                        style: TextStyle(
                                            fontSize: context.customOrientation(
                                                18.0, 22.0),
                                            fontFamily: 'naskh',
                                            color: const Color(0xff77554B)),
                                      ),
                                    )
                                  ],
                                ),
                              ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
