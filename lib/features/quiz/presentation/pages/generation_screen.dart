import 'dart:math';

import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_frame_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/service/segment/segment_provider.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_color.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/custom_segment_widget.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/custom_textform_field.dart';
import 'package:clean_architutre_learn/features/drop_down/presentation/widget/custom_drop_down_widget.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/provider/quiz_sccren_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenerationScreen extends ConsumerStatefulWidget {
  const GenerationScreen({super.key});

  @override
  ConsumerState<GenerationScreen> createState() => _GenerationScreenState();
}

class _GenerationScreenState extends ConsumerState<GenerationScreen> {
  List<String> listOfData = ['Easy', 'Medium', 'Hard'];
  TextEditingController questnCount = TextEditingController();
  TextEditingController topicCOntroller = TextEditingController();
  TextEditingController univercityController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController maxMArkController = TextEditingController();
  TextEditingController paperCOdeCOntroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int dummyCount = 20;
    int timeControllerCount = 120;
    int maxMArkControllerCount = 100;
    timeController.text = timeControllerCount.toString();
    maxMArkController.text = maxMArkControllerCount.toString();
    questnCount.text = dummyCount.toString();

    return CustomFrameBodyWidget(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Uiutils.getTextWidget(
                  context,
                  "Make it & Solve it ",
                  textStyle: TextStyleType.largeBold,
                  color: context.blueTwo,
                ),
              ],
            ),
            SizedBox(height: 22.rh(context)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.rw(context)),
              child: Uiutils.getTextWidget(
                context,
                "💡 ${CoreConstants.infoTexts[Random().nextInt(CoreConstants.infoTexts.length)]}",
                color: context.primaryColor,
                overFlow: TextOverflow.visible,
                textStyle: TextStyleType.mediumBold,
              ),
            ),
            SizedBox(height: 20.rh(context)),

            PureCupertinoDropdown(
              subHeading: "Questionn paper  Type ",
              items:const [
                'Multiple Choice Question',
                'UNivercity type',
                'One Word',
                'TASC',
                'UNivercity type With 1 Qn neglatable',
                '',
              ],
              selectedValueProvider: paperTypeOptionProvider,
              bottomPadding: 0,
            ),
            Row(
              children: [
                Uiutils.getTextWidget(
                  context,
                  'Numbers of Questions',
                  textStyle: TextStyleType.mediumBold,
                  color: context.mainLightShadeColor,
                ),
                SizedBox(width: 10.rw(context)),
                Expanded(
                  child: CustomTextFormField(
                    onChange: (value) {
                      if (questnCount.text.isNotEmpty) {
                        dummyCount = int.tryParse(value) ?? dummyCount;
                      }
                    },
                    downPadding: 0,
                    titileStyle: TextStyleType.mediumBold,
                    borderRadius: 12,
                    boxColor: context.secondaryColor,
                    borderColor: context.subTextColor.withValues(alpha: .3),
                    controller: questnCount,
                    icon: CupertinoIcons.minus,
                    prefixOntap: () {
                      if (dummyCount >= 5) {
                        questnCount.text = (--dummyCount).toString();
                      }
                    },
                    onTap: () {
                      questnCount.text = (++dummyCount).toString();
                    },
                    suffixIcon: CupertinoIcons.add,
                    isWantsuffix: true,
                  ),
                ),
              ],
            ),
            PureCupertinoDropdown(
              items:const ['Maths', "SCience"],
              topPadding: 0,
              subHeading: 'topic',
              selectedValueProvider: topicOptionProvider,
            ),
            SizedBox(height: 9.rh(context)),

            CustomTextFormField(
              titileStyle: TextStyleType.mediumBold,
              prefixNeeded: false,
              text: 'Sub Topic',
              textColor: context.mainLightShadeColor,
              borderRadius: 9.rf(context),

              boxColor: context.secondaryColor,
              borderColor: context.subTextColor.withValues(alpha: .3),
              hintText: 'Topic Hint/Sub topic name',
              downPadding: 12.rh(context),
            ),

            PureCupertinoDropdown(
              items: const['chold ', 'adult', ''],
              subHeading: "Categeory of  question paper",
              selectedValueProvider: categeoryOptionProvider,
              // bottomPadding: 16.rh(context),
            ),
            SizedBox(height: 9.rh(context)),

            CustomSegemtWidget(
              titile: "Select Level of the Questions",
              segmentProvider: segmentSelectionLevelProvider,

              listOfData: listOfData,
            ),
            SizedBox(height: 9.rh(context)),

            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    titileStyle: TextStyleType.mediumBold,
                    downPadding: 10.rh(context),
                    textColor: context.mainLightShadeColor,

                    borderRadius: 4,
                    boxColor: context.secondaryColor,
                    borderColor: context.subTextColor.withValues(alpha: .3),
                    controller: timeController,
                    onChange: (value) {
                      if (timeController.text.isNotEmpty) {
                        timeControllerCount =
                            int.tryParse(timeController.text) ??
                            timeControllerCount;
                      }
                    },
                    prefixOntap: () {
                      if (timeControllerCount > 15) {
                        timeController.text = (--timeControllerCount)
                            .toString();
                      }
                    },
                    onTap: () {
                      timeController.text = (++timeControllerCount).toString();
                    },
                    suffixIcon: CupertinoIcons.add_circled,
                    isWantsuffix: true,
                    icon: CupertinoIcons.minus_circled,

                    text: "Time (Minutes)",
                  ),
                ),
                SizedBox(width: 20.rw(context)),
                Expanded(
                  child: CustomTextFormField(
                    titileStyle: TextStyleType.mediumBold,
                    textColor: context.mainLightShadeColor,

                    borderRadius: 12,
                    boxColor: context.secondaryColor,
                    borderColor: context.subTextColor.withValues(alpha: .3),
                    onChange: (value) {
                      if (maxMArkController.text.isNotEmpty) {
                        maxMArkControllerCount =
                            int.tryParse(value) ??
                            maxMArkControllerCount; //maxMArkController is int then maxMArkControllerCount=maxMArkController
                      }
                    },
                    controller: maxMArkController,
                    onTap: () {
                      maxMArkController.text = (++maxMArkControllerCount)
                          .toString();
                    },
                    suffixIcon: CupertinoIcons.add_circled,
                    isWantsuffix: true,
                    downPadding: 0.rh(context),
                    icon: CupertinoIcons.minus_circled,
                    prefixOntap: () {
                      if (maxMArkControllerCount > 10) {
                        maxMArkController.text = (--maxMArkControllerCount)
                            .toString();
                      }
                    },
                    text: 'Maximum Mark',
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.rh(context)),
            CustomTextFormField(
              titileStyle: TextStyleType.mediumBold,
              textColor: context.mainLightShadeColor,
              hintText: 'Calicut University',
              text: "University Name\n (optional*)",
              textInputAction: TextInputAction.next,
              controller: univercityController,
              prefixNeeded: false,
              borderRadius: 9.rf(context),

              downPadding: 10.rh(context),
              boxColor: context.secondaryColor,
              borderColor: context.subTextColor.withValues(alpha: .3),
            ),
            CustomTextFormField(
              titileStyle: TextStyleType.mediumBold,
              textColor: context.mainLightShadeColor,
              hintText: 'E 2021',
              text: "Paper Code\n (optional*)",
              textInputAction: TextInputAction.next,
              controller: paperCOdeCOntroller,
              prefixNeeded: false,
              borderRadius: 9.rf(context),
              downPadding: 20.rh(context),
              boxColor: context.secondaryColor,
              borderColor: context.subTextColor.withValues(alpha: .3),
            ),

            // Spacer(),
            CustomButtonWIdget(
              titile: 'Generate',
              color: AppColors.primary,
              textColor: AppColors.containerGray,
              textStyle: TextStyleType.mediumBold,
              onTap: () {
                // debugPrint()
              },
            ),
          ],
        ),
      ),
    );
  }
}
