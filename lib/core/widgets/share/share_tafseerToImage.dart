import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import '../../../presentation/controllers/ayat_controller.dart';
import '../../../presentation/controllers/share_controller.dart';
import '../../../presentation/screens/quran_text/widgets/widgets.dart';
import '../../services/services_locator.dart';
import '../../utils/constants/svg_picture.dart';
import '../../utils/helpers/functions.dart';
import '../widgets.dart';
import '/core/utils/constants/extensions.dart';
import '/presentation/controllers/translate_controller.dart';

class TafseerImageCreator extends StatelessWidget {
  final int verseNumber;
  final int verseUQNumber;
  final int surahNumber;
  final String verseText;
  final String tafseerText;

  TafseerImageCreator({
    Key? key,
    required this.verseNumber,
    required this.verseUQNumber,
    required this.surahNumber,
    required this.verseText,
    required this.tafseerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tafseerToImage = sl<ShareController>();

    return Column(
      children: [
        Screenshot(
          controller: tafseerToImage.tafseerScreenController,
          child: buildVerseImageWidget(
            context: context,
            verseNumber: verseNumber,
            verseUQNumber: verseUQNumber,
            surahNumber: surahNumber,
            verseText: verseText,
            tafseerText: tafseerText,
          ),
        ),
        // if (ayahToImage.ayahToImageBytes != null)
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Image.memory(ayahToImage.ayahToImageBytes!),
        //   ),
      ],
    );
  }

  Widget buildVerseImageWidget({
    required BuildContext context,
    required int verseNumber,
    required int verseUQNumber,
    required int surahNumber,
    required String verseText,
    required String tafseerText,
  }) {
    final tafseerToImage = sl<ShareController>();

    return GetBuilder<TranslateDataController>(builder: (translateController) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: 960.0,
          decoration: const BoxDecoration(
              color: const Color(0xff404C6E),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      surah_banner1(),
                      surahNameWidget(
                          formatNumber(surahNumber), const Color(0xff404C6E)),
                    ],
                  ),
                  const Gap(16),
                  SizedBox(
                      width: 928.0,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              '﴿ $verseText ${arabicNumber.convert(verseNumber)} ﴾',
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'uthmanic2',
                                color: Color(0xff161f07),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Gap(16),
                          Align(
                            alignment: tafseerToImage.checkAndApplyRtlLayout(
                                '${tafseerToImage.currentTranslate.value}'),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xffCDAD80).withOpacity(.3),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: Obx(
                                () => Text(
                                  tafseerToImage.currentTranslate.value,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'kufi',
                                    color: Color(0xff161f07),
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                          const Gap(8),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: const Color(0xff404C6E).withOpacity(.15),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Obx(
                              () => Text(
                                sl<ShareController>().isTafseer.value
                                    ? sl<AyatController>()
                                        .currentText
                                        .value!
                                        .translate
                                    : sl<TranslateDataController>()
                                        .data[verseUQNumber - 1]['text'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'naskh',
                                  color: Color(0xff161f07),
                                ),
                                textAlign: TextAlign.justify,
                                textDirection:
                                    tafseerToImage.checkApplyRtlLayout(
                                        tafseerToImage.currentTranslate.value),
                              ),
                            ),
                          ),
                        ],
                      )),
                  const Gap(24),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          splash_icon(height: 40.0),
                          context.vDivider(),
                          const Text(
                            'القـرآن الكريــــم\nمكتبة الحكمة',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'kufi',
                              color: Color(0xff161f07),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
