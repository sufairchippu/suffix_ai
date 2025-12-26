import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
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
  @override
  Widget build(BuildContext context) {
    final questionNumber = ref.watch(quizQuestionNumber);
    final selectedOption = ref.watch(quizselectedAnswerProvider);
    int correctAnswerIndex = widget.quizdata[questionNumber].correctIndex;
    var correctedanswerCount = 0;
    return PopScope(
      canPop: true,
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
                    horizontal: 38.rw(context),
                    vertical: 6.rh(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60.rh(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.pop();

                              ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>> make condition her for when its quiz give an alert box to exit
                            },
                            child: Icon(
                              CupertinoIcons.chevron_left,
                              fontWeight: FontWeight.bold,
                              color: context.primaryColor,
                            ),
                          ),
                          Uiutils.getTextWidget(
                            context,
                            '${widget.quizdata.length}/${widget.quizdata.length}',
                            textStyle: TextStyleType.mediumSemiBold,
                            color: context.mainDarkShadeColor,
                          ),
                          const SizedBox(),
                        ],
                      ),
                      SizedBox(height: 50.rh(context)),
                      CustomButtonWIdget(
                        titile: widget.quizdata[questionNumber].question,
                        textStyle: TextStyleType.mediumSemiBold,
                        textColor: context.textColor,
                        height: 110.rh(context),
                        boxshadowColor: context.textColor.withValues(alpha: .3),
                        color: context.dynamicColor3,
                      ),
                      const Spacer(),

                      // SizedBox(height: 40.rh(context)),
                      Consumer(
                        builder: (context, ref, child) {
                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                widget.quizdata[questionNumber].options.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 15.rh(context)),
                            itemBuilder: (context, index) {
                              String? option = widget
                                  .quizdata[questionNumber]
                                  .options[index];
                              return CustomButtonWIdget(
                                top: 10.rh(context),
                                color: selectedOption == index
                                    ? context.scaffoldColor
                                    : context.primaryColor,
                                onTap: () {
                                  ref
                                          .read(
                                            quizselectedAnswerProvider.notifier,
                                          )
                                          .state =
                                      index;
                                },
                                widget: CupertinoListTile(
                                  title: Uiutils.getTextWidget(
                                    context,
                                    option,
                                    textStyle: TextStyleType.mediumBold,
                                  ),
                                  trailing: Icon(
                                    selectedOption == index
                                        ? CupertinoIcons
                                              .check_mark_circled_solid
                                        : CupertinoIcons.circle,
                                  ),
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
                          );
                        },
                      ),
                      SizedBox(height: 17.rh(context)),

                      const Spacer(),
                      // CustomButtonWIdget(
                      //   titile: 'Wrong Answer ❌',
                      //   // textColor: context.mainDarkShadeColor,s
                      //   // color: context.red.withValues(alpha: .4),
                      //   borderRadius: 12.rf(context),
                      // ),
                      SizedBox(height: 17.rh(context)),

                      CustomButtonWIdget(
                        onTap: () {
                          if (selectedOption == correctAnswerIndex) {
                            ++correctedanswerCount;
                          }
                          ref.invalidate(quizselectedAnswerProvider);
                          ref.read(quizQuestionNumber.notifier).state =
                              questionNumber + 1;
                        },
                        titile: 'Next',
                        color: context.primaryColor,
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
