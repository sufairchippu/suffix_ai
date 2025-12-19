import 'dart:math';

import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_frame_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/service/segment/segment_provider.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_color.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/custom_segment_widget.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/custom_textform_field.dart';
import 'package:clean_architutre_learn/features/chat/presentation/provider/ai_provider.dart';
import 'package:clean_architutre_learn/features/drop_down/presentation/widget/custom_drop_down_widget.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/provider/quiz_sccren_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GenerationScreen extends ConsumerStatefulWidget {
  const GenerationScreen({super.key});

  @override
  ConsumerState<GenerationScreen> createState() => _GenerationScreenState();
}

class _GenerationScreenState extends ConsumerState<GenerationScreen> {
  List<String> listOfData = ['Easy', 'Medium', 'Hard'];
  TextEditingController questnCount = TextEditingController();
  TextEditingController subTopicCOntroller = TextEditingController();
  TextEditingController univercityController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController maxMArkController = TextEditingController();
  TextEditingController paperCOdeCOntroller = TextEditingController();
  TextEditingController descriptionCOntroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    timeController.text = "120";
    maxMArkController.text = "100";
    questnCount.text = "20";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(questionCountProvider.notifier).state = 20;
      ref.read(timeNumberProvider.notifier).state = 120;
      ref.read(maxMarkProvider.notifier).state = 100;
    });

    // LISTEN TO CONTROLLERS
    questnCount.addListener(() {
      final val = int.tryParse(questnCount.text.trim());
      if (val != null) {
        ref.read(questionCountProvider.notifier).state = val;
      }
    });

    timeController.addListener(() {
      final val = int.tryParse(timeController.text.trim());
      if (val != null) {
        ref.read(timeNumberProvider.notifier).state = val;
      }
    });

    maxMArkController.addListener(() {
      final val = int.tryParse(maxMArkController.text.trim());
      if (val != null) {
        ref.read(maxMarkProvider.notifier).state = val;
      }
    });
  }

  @override
  void dispose() {
    questnCount.dispose();
    subTopicCOntroller.dispose();
    univercityController.dispose();
    timeController.dispose();
    maxMArkController.dispose();
    paperCOdeCOntroller.dispose();
    descriptionCOntroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categeoryOptionProvider);

    final typeProvider = ref.watch(paperTypeOptionProvider);
    final level = ref.watch(segmentSelectionLevelProvider);
    final topic = ref.watch(topicOptionProvider);
    final questinCOunt = ref.watch(questionCountProvider);
    final timeNumber = ref.watch(timeNumberProvider);
    final maxMark = ref.watch(maxMarkProvider);
    final genratepdfProvider = ref.watch(pdfGenrationNotifierProvider);
    final optional = ref.watch(optionalFormfieldProvider);
    ref.listen(pdfGenrationNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (!mounted) return;
          if (previous?.hasValue == true) return;
          context.pushNamed(RouteNames.pdfPreview, extra: data);
        },
        error: (error, stackTrace) =>
            Uiutils.cupertinoSnackBar(context, error.toString(), true),
      );
    });
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        ref.invalidate(questionCountProvider);
        ref.invalidate(timeNumberProvider);
        ref.invalidate(maxMarkProvider);
        ref.invalidate(pdfGenrationNotifierProvider);
        ref.invalidate(topicOptionProvider);
        ref.invalidate(segmentSelectionLevelProvider);
      },
      child: CustomFrameBodyWidget(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          reverse: true,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.rh(context),
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
                  items: CoreConstants.qustionText, // '',
                  selectedValueProvider: paperTypeOptionProvider,
                  bottomPadding: 0,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select a Paper Type";
                    }
                    return null;
                  },
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
                        ///!give tha cpondtion for mcq and university exam minimum question count in the 53 lineimpiment constion of corecosntant.paprtype ==papertype provider value give value as minimum to specific
                        onChange: (value) {
                          final parsed = int.tryParse(value.trim());
                          if (parsed != null) {
                            ref.read(questionCountProvider.notifier).state =
                                parsed;
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
                          if (questinCOunt >= 5) {
                            ref.read(questionCountProvider.notifier).state =
                                questinCOunt - 1;
                            questnCount.text = (questinCOunt - 1).toString();
                          }
                        },
                        onTap: () {
                          ref.read(questionCountProvider.notifier).state =
                              questinCOunt + 1;
                          questnCount.text = (questinCOunt + 1).toString();
                        },
                        suffixIcon: CupertinoIcons.add,
                        isWantsuffix: true,
                      ),
                    ),
                  ],
                ),
                PureCupertinoDropdown(
                  items: const ['Maths', "SCience"],
                  topPadding: 0,
                  subHeading: 'topic',
                  selectedValueProvider: topicOptionProvider,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select a topic";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 9.rh(context)),

                CustomTextFormField(
                  titileStyle: TextStyleType.mediumBold,
                  prefixNeeded: false,
                  controller: subTopicCOntroller,
                  text: 'Sub Topic',
                  textColor: context.mainLightShadeColor,
                  borderRadius: 9.rf(context),

                  boxColor: context.secondaryColor,
                  borderColor: context.subTextColor.withValues(alpha: .3),
                  hintText: 'Topic Hint/Sub topic name',
                  downPadding: 12.rh(context),
                ),

                // PureCupertinoDropdown(
                //   items: const ['chold ', 'adult', ''],
                //   subHeading: "Categeory of  question paper",
                //   selectedValueProvider: categeoryOptionProvider,
                //   // validator:
                //   // (value) {
                //   //   if (value == null || value.isEmpty) {
                //   //     return "Select a categeory";
                //   //   }
                //   //   return null;
                //   // },
                //   // bottomPadding: 16.rh(context),
                // ),
                SizedBox(height: 9.rh(context)),

                CustomSegemtWidget(
                  height: 30.rh(context),
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
                          final parsed = int.tryParse(value.trim());
                          if (parsed != null) {
                            ref.read(timeNumberProvider.notifier).state =
                                parsed;
                          }
                        },
                        prefixOntap: () {
                          if (timeNumber > 15) {
                            ref.read(timeNumberProvider.notifier).state =
                                timeNumber - 1;
                            timeController.text = (timeNumber - 1)
                                .toString(); // timeController.text = (--timeControllerCount)
                            //     .toString();
                          }
                        },
                        onTap: () {
                          ref.read(timeNumberProvider.notifier).state =
                              timeNumber + 1;
                          timeController.text = (timeNumber + 1).toString();
                          // timeController.text = (++timeControllerCount)
                          //     .toString();
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
                          final parsed = int.tryParse(value.trim());
                          if (parsed != null) {
                            ref.read(maxMarkProvider.notifier).state = parsed;
                          }
                        },
                        controller: maxMArkController,
                        onTap: () {
                          ref.read(maxMarkProvider.notifier).state =
                              maxMark + 1;
                          maxMArkController.text = (maxMark + 1).toString();
                        },
                        suffixIcon: CupertinoIcons.add_circled,
                        isWantsuffix: true,
                        downPadding: 0.rh(context),
                        icon: CupertinoIcons.minus_circled,
                        prefixOntap: () {
                          if (maxMark > 10) {
                            ref.read(maxMarkProvider.notifier).state =
                                maxMark - 1;
                            maxMArkController.text = (maxMark - 1).toString();
                          }
                        },
                        text: 'Maximum Mark',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Uiutils.getTextWidget(context, '(optional*)'),
                    GestureDetector(
                      onTap: () =>
                          ref.read(optionalFormfieldProvider.notifier).state =
                              !optional,
                      child: Icon(
                        optional
                            ? CupertinoIcons.chevron_up
                            : CupertinoIcons.chevron_down,
                      ),
                    ),
                  ],
                ),
                if (optional) ...[
                  CustomTextFormField(
                    titileStyle: TextStyleType.mediumBold,
                    textColor: context.mainLightShadeColor,
                    hintText: 'Descrption / Hints',
                    text: "Description",
                    textInputAction: TextInputAction.next,
                    controller: descriptionCOntroller,
                    prefixNeeded: false,
                    borderRadius: 9.rf(context),
                    downPadding: 20.rh(context),
                    boxColor: context.secondaryColor,
                  ),
                  SizedBox(height: 6.rh(context)),
                  CustomTextFormField(
                    titileStyle: TextStyleType.mediumBold,
                    textColor: context.mainLightShadeColor,
                    hintText: 'Calicut University',
                    text: "University Name",
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
                ],
                SizedBox(height: 12.rh(context)),
                // Spacer(),
                CustomButtonWIdget(
                  titile: 'Generate',
                  color: AppColors.primary,
                  textColor: AppColors.containerGray,
                  textStyle: TextStyleType.mediumBold,
                  onTap: () async {
                    if (!formKey.currentState!.validate()) return;
                    try {
                      final prompt = Uiutils.buildPrompt(
                        paperType: typeProvider!,
                        questionCount: questinCOunt,
                        topic: topic!,
                        level: Diffculty.values[level].name,
                        categeory: category,
                        subTopic: subTopicCOntroller.text,
                      );
                      ref
                          .read(aiMessgeNotifierProvider.notifier)
                          .getAiReply(data: prompt);
                      final response = ref
                          .watch(aiMessgeNotifierProvider)
                          .parts!
                          .first
                          .text;

                      ref
                          .read(pdfGenrationNotifierProvider.notifier)
                          .genratePdf(
                            description: descriptionCOntroller.text,
                            papperCode: paperCOdeCOntroller.text,
                            subTopic: subTopicCOntroller.text,
                            universityName: univercityController.text,
                            papperType: typeProvider,
                            questionData: response??'',
                            mark: '$maxMark',
                            time: '$timeNumber',
                            topic: topic,
                          );
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

                  //             if (ref.watch(paperTypeOptionProvider) ==
                  //                 CoreConstants.qustionText[4]) {
                  //               const propmt = """
                  //             Generate a university-style exam on "Arithmatic"
                  //             Total questions required: 10.
                  //             Difficulty: medium.

                  //         Include:
                  //             1 question may be ignored (exception rule).for every section when each section question count is more than 2

                  //         - Short Answer (4)
                  //         - MCQ (2)
                  //         - Medium Long (3)
                  //         - Essay (1)
                  //             {
                  //  "exam_paper": [
                  //             { "type": "short_answer", "question": "...", "answer": "..." },
                  //             { "type": "mcq", "question": "...", "options": ["..."], "answer_index": "..." },
                  //             { "type": "long_answer", "question": "...", "answer": "..." },
                  //             { "type": "essay", "question": "...", "answer": "..." }
                  //           ]
                  //             }
                  //             """;

                  //               await ref
                  //                   .read(aiMessgeNotifierProvider.notifier)
                  //                   .getAiReply(data: propmt, toSupabase: false);
                  //               final reply = ref
                  //                   .watch(aiMessgeNotifierProvider)
                  //                   .parts![0]
                  //                   .text;
                  //               print('...$reply ............shortanswe');
                  //             }
                  // if (genratepdfProvider.hasValue) {
                  //   context.pushNamed(
                  //     RouteNames.pdfPreview,
                  //     extra: genratepdfProvider.value,
                  //   );
                  // }
       
              // debugPrint(
              //   'controller>>>>>>>>>>>>>>>>>>>>${questnCount.text}............dummycount>>>>>>>>>>> $questinCOunt.....',
              // );
              // if (typeProvider == CoreConstants.qustionText[0]) {
              //   ref
              //       .read(aiMessgeNotifierProvider.notifier)
              //       .getAiReply(
              //         data:
              //             'Generate 20 multiple-choice questions about flutter. Difficulty: medium. Format in JSON with fields: question, options, correct_answer_index, difficulty',
              //       );
              // }
              // if (ref.watch(paperTypeOptionProvider) ==
              //     CoreConstants.qustionText[1]) {
              //   ref
              //       .read(aiMessgeNotifierProvider.notifier)
              //       .getAiReply(
              //         data:
              //             """
              // Generate an exam paper on '$topic'.
              // Difficulty: $level.
              // Number of Questions: $questnCount.
              // Include:
              // - Short Answer (4)
              // - MCQ (2)
              // - Medium Long (3)
              // - Essay (1)

              // Return valid JSON:
              // {
              //   "exam_paper": [
              //     { "type": "short_answer", "question": "...", "answer": "..." },
              //     { "type": "mcq", "question": "...", "options": ["..."], "answer_index": "..." },
              //     { "type": "long_answer", "question": "...", "answer": "..." },
              //     { "type": "essay", "question": "...", "answer": "..." }
              //   ]
              // }
              // """,
              //       );
              // }
              // if (ref.watch(paperTypeOptionProvider) ==
              //     CoreConstants.qustionText[2]) {
              //   ref
              //       .read(aiMessgeNotifierProvider.notifier)
              //       .getAiReply(
              //         data:
              //             """
              // Generate $questnCount ONE-WORD questions on "$topic".
              // Difficulty: $level.

              // Return output STRICTLY in the following JSON format:
              // {
              //   "one_word_paper": [
              //     {
              //       "question": "string",
              //       "answer": "string"
              //     }
              //   ]
              // }
              // """,
              //       );
              // }
              // if (ref.watch(paperTypeOptionProvider) ==
              //     CoreConstants.qustionText[3]) {
              //   ref
              //       .read(aiMessgeNotifierProvider.notifier)
              //       .getAiReply(
              //         data:
              //             """
              // Generate a TASC-style exam with $questnCount questions on "$topic".
              // Difficulty: $level.

              // Return STRICT JSON only:
              // {
              //   "tasc_paper": [
              //     {
              //       "question": "string",
              //       "description": "string",
              //       "answer": "string"
              //     }
              //   ]
              // }
              // """,
              //       );
              // }
              // if (ref.watch(paperTypeOptionProvider) ==
              //     CoreConstants.qustionText[4]) {
              //   ref
              //       .read(aiMessgeNotifierProvider.notifier)
              //       .getAiReply(
              //         data:
              //             """
              // Generate a university-style exam on "$topic".
              // Total questions required: $questnCount.
              // 1 question may be ignored (exception rule).
              // Difficulty: $level.

              // Return STRICT JSON:
              // {
              //   "university_paper": {
              //     "ignore_question_count": 1,
              //     "questions": [
              //       {
              //         "question": "string",
              //         "marks": 5,
              //         "answer": "string"
              //       }
              //     ]
              //   }
              // }
              // """,
              //       );
              // }

              // final valuee = ref.watch(aiMessgeNotifierProvider);

              // debugPrint('${valuee.parts?[0].text}.............');
              // switch (String) {
              //   // case CoreConstants.qustionText[0]:
              // }
 
