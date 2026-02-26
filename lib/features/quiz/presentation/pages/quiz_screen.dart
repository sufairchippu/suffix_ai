import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/mcq_paper_model.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/provider/quiz_sccren_provider.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/widget/custom_paint_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key, required this.quizdata});
  final List<McqQuestionModel> quizdata;
  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  // @override
  // void dispose() {
  //   ref.invalidate(quizselectedAnswerProvider);
  //   ref.invalidate(quizQuestionNumber);
  //   ref.invalidate(quizAnswerCountProvider);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // print('building build methode');

    // var correctedanswerCount = 0;
    // ref.listen(provider, listener)
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) return;
        // ref.invalidate(quizselectedAnswerProvider);
        // ref.invalidate(quizQuestionNumber);
        // ref.invalidate(quizselectedAnswerProvider);
        // ref.invalidate(quizQuestionNumber);
      },

      // onPopInvokedWithResult: (didPop, result) {},
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: context.dynamicColor4.withValues(alpha: 1),
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  // padding: MediaQuery.of(context).padding,
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [context.dynamicColor2, context.dynamicColor3],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              AnimatedPositioned(
                duration: const Duration(seconds: 3),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.rw(context),
                    vertical: 6.rh(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70.rh(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.pop();
                              ref.invalidate(quizselectedAnswerProvider);
                              ref.invalidate(quizQuestionNumber);

                              ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>> make condition her for when its quiz give an alert box to exit
                            },
                            child: Icon(
                              CupertinoIcons.chevron_left,
                              fontWeight: FontWeight.bold,
                              color: context.primaryColor,
                            ),
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final questionNumber = ref.watch(
                                quizQuestionNumber,
                              );
                              final selectedOption = ref.watch(
                                quizselectedAnswerProvider,
                              );
                              // int correctAnswerIndex =
                              //     widget.quizdata[questionNumber].correctIndex;
                              // final questionNumber = ref.watch(
                              //   quizQuestionNumber,
                              // );
                              return Column(
                                children: [
                                  Uiutils.getTextWidget(
                                    context,
                                    '${questionNumber + 1}/${widget.quizdata.length}',
                                    textStyle: TextStyleType.mediumSemiBold,
                                    color: context.mainDarkShadeColor,
                                  ),

                                  SizedBox(height: 40.rh(context)),
                                  CustomButtonWIdget(
                                    width: 340.rw(context),
                                    titile: widget
                                        .quizdata[questionNumber]
                                        .question,
                                    textStyle: TextStyleType.mediumSemiBold,
                                    textColor: context.textColor,
                                    height: 110.rh(context),
                                    boxshadowColor: context.textColor
                                        .withValues(alpha: .3),
                                    color: context.dynamicColor3,
                                    maxline: 9,
                                  ),
                                  SizedBox(height: 100.rh(context)),
                                  Column(
                                    children: List.generate(
                                      // padding: EdgeInsets.zero,
                                      // shrinkWrap: true,
                                      // physics:
                                      //     const NeverScrollableScrollPhysics(),
                                      widget
                                          .quizdata[questionNumber]
                                          .options
                                          .length,
                                      (index) {
                                        // separatorBuilder: (context, index) =>
                                        //     SizedBox(height: 15.rh(context)),
                                        // itemBuilder: (context, index) {
                                        String? option = widget
                                            .quizdata[questionNumber]
                                            .options[index];
                                        return CustomButtonWIdget(bottom: 15.rf(context),
                                          padding: 20.rf(context),
                                          width: 340.rw(context),
                                          height: 65.rh(context),
                                          // top: 10.rh(context),
                                          color: selectedOption == index
                                              ? context.scaffoldColor
                                              : context.primaryColor,
                                          onTap: () {
                                            ref
                                                    .read(
                                                      quizselectedAnswerProvider
                                                          .notifier,
                                                    )
                                                    .state =
                                                index;
                                          },
                                          widget: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Uiutils.getTextWidget(
                                                context,
                                                option,
                                                maxline: 2,
                                                textStyle:
                                                    TextStyleType.mediumBold,
                                              ),
                                              Icon(
                                                selectedOption == index
                                                    ? CupertinoIcons
                                                          .check_mark_circled_solid
                                                    : CupertinoIcons.circle,
                                              ),
                                            ],
                                            // CupertinoRadio(
                                            //   value: option,
                                            //   onChanged: (String? value) {
                                            //     // setState(() {
                                            //     //   valuee = value;
                                            //     // });
                                            //   },
                                            //   groupValue: valuee,
                                            // ),
                                          ),
                                        );
                                        // CustomButtonWIdget(
                                        //   widget: Row(
                                        //     children: [
                                        //       Uiutils.getTextWidget(context, "Optiion${index + 1}"),
                                        //       Spacer(),
                                        //     ],
                                        //   ),
                                        // );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          // const SizedBox(),
                        ],
                      ),

                      // SizedBox(height: 40.rh(context)),
                      // Consumer(
                      //   builder: (context, ref, child) {
                      //     return;
                      //   },
                      // ),
                      SizedBox(height: 30.rh(context)),

                      // const Spacer(),
                      // CustomButtonWIdget(
                      //   titile: 'Wrong Answer ❌',
                      //   // textColor: context.mainDarkShadeColor,s
                      //   // color: context.red.withValues(alpha: .4),
                      //   borderRadius: 12.rf(context),
                      // ),
                      SizedBox(height: 50.rh(context)),

                      Consumer(
                        builder: (context, ref, child) {
                          final correctedanswerCount = ref.watch(
                            quizAnswerCountProvider,
                          );
                          final questionNumber = ref.watch(quizQuestionNumber);
                          final selectedOption = ref.watch(
                            quizselectedAnswerProvider,
                          );
                          int correctAnswerIndex =
                              widget.quizdata[questionNumber].correctIndex;
                          return CustomButtonWIdget(
                            left: 20.rf(context),
                            onTap: () {
                              print(
                                'correctanswrer count $correctedanswerCount',
                              );
                              if (questionNumber >=
                                  widget.quizdata.length - 1) {
                                context.pushNamed(
                                  RouteNames.resultScreen,
                                  extra: {
                                    'answerCount': correctedanswerCount,
                                    'totalQuestion': widget.quizdata.length,
                                  },
                                );
                                ref.invalidate(quizselectedAnswerProvider);
                                ref.invalidate(quizQuestionNumber);
                                ref.invalidate(quizAnswerCountProvider);

                                ///! scor showing screnn
                              } else {
                                if (selectedOption == correctAnswerIndex) {
                                  ref
                                      .read(quizAnswerCountProvider.notifier)
                                      .state++;
                                }
                                ref.invalidate(quizselectedAnswerProvider);
                                ref.read(quizQuestionNumber.notifier).state++;
                              }
                            },
                            titile: 'Next',
                            color: context.primaryColor,
                          );
                        },
                      ),
                      SizedBox(height: 22.rh(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
