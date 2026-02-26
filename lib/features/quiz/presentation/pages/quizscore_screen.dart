// import 'dart:developer';

// import 'package:clean_architutre_learn/core/constants/svg_constants.dart';
// import 'package:clean_architutre_learn/core/constants/widgets/bending_text.dart';
// import 'package:clean_architutre_learn/core/constants/widgets/custom_frame_widget.dart';
// import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
// import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
// import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
// import 'package:flutter/cupertino.dart';

// class QuizScoreScreen extends StatelessWidget {
//   const QuizScoreScreen({
//     super.key,
//     required this.answerCount,
//     required this.totalQuestion,
//   });
//   final int answerCount;
//   final int totalQuestion;
//   @override
//   Widget build(BuildContext context) {
//     log('$answerCount. answercount  $totalQuestion.   total questions');
//     final markPercent = (answerCount / totalQuestion) * 100;
//     String resultMessage;

//     if (markPercent >= 90) {
//       resultMessage = 'Outstanding! You nailed it — a perfect performance 🎉';
//     } else if (markPercent >= 80) {
//       resultMessage = 'Great job! You did really well 👏';
//     } else if (markPercent >= 60) {
//       resultMessage = 'Good effort! Keep practicing 👍';
//     } else {
//       resultMessage = 'Don’t give up! Practice makes perfect 💪';
//     }
//     return CupertinoPageScaffold(
//       child: CustomFrameBodyWidget(
//         child: Column(
//           children: [
//             SizedBox(height: 100.rh(context)),

//             Uiutils.getTextWidget(context, 'Congratulation! $resultMessage'),
//             Stack(
//               children: [
//                 Uiutils.getSvg(
//                   SvgConstants.result,
//                   color: ColorFilter.mode(
//                     context.primaryColor,
//                     BlendMode.colorDodge,
//                   ),
//                 ),
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   top: 0,
//                   bottom: 0,
//                   child: BendingText(
//                     text: resultMessage,
//                     radius: 150.rf(context),
//                     sweepAngle: 180,
//                     startAngle: -180,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }///////////https://youtu.be/AXywe3nDOec?si=7_NsdKROu6oAn6nL
//https://youtu.be/o9dcSS_82gw?si=gctxyntPKQ9RNVHx
import 'dart:ui';
import 'package:clean_architutre_learn/core/constants/widgets/bending_text.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_frame_widget.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/widget/cupertino_animate_widget.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// show
//     CupertinoColors,
//     Icons,
//     LinearGradient,
//     BoxDecoration,
//     BoxShadow,
//     RenderPointerListener,
//     CircularProgressIndicator;
import 'package:clean_architutre_learn/core/constants/svg_constants.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:go_router/go_router.dart';

// Assuming these are available in your project structure
// import 'package:clean_architutre_learn/features/quiz/presentation/widgets/bending_text.dart';
// import 'package:clean_architutre_learn/features/quiz/presentation/widgets/custom_frame_widget.dart';

class QuizScoreScreen extends StatelessWidget {
  const QuizScoreScreen({
    super.key,
    required this.answerCount,
    required this.totalQuestion,
  });

  final int answerCount;
  final int totalQuestion;

  @override
  Widget build(BuildContext context) {
    final double percent = (answerCount / totalQuestion);
    final String resultMessage = _resultMessage(percent * 100);
    final String title = _resultTitle(percent * 100);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.goNamed(RouteNames.generate);
      },
      child: CupertinoPageScaffold(
        backgroundColor: const Color(
          0xFF0F172A,
        ), // Deep Slate/Midnight Background
        child: CustomFrameBodyWidget(
          child: Column(
            children: [
              SizedBox(height: 40.rh(context)),

              /// 🎉 Header Label
              _buildGlassLabel(context, "RESULT ACHIEVED"),

              SizedBox(height: 20.rh(context)),

              /// 🏆 Main Title with subtle shadow
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    CupertinoColors.white,
                    context.primaryColor.withValues(alpha: 0.7),
                  ],
                ).createShader(bounds),
                child: Uiutils.getTextWidget(
                  context,
                  title.toUpperCase(),
                  fs: 34.rf(context),
                  fw: FontWeight.w900,
                ),
              ),

              const Spacer(),

              /// 💎 THE CENTERPIECE: Glowing Glass Orb
              Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Ambient Glow
                  _buildAmbientGlow(context, percent),

                  // The Glass Disc
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        width: 260.rf(context),
                        height: 260.rf(context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: CupertinoColors.white.withValues(
                              alpha: 0.15,
                            ),
                            width: 1.5,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              CupertinoColors.white.withValues(alpha: 0.1),
                              CupertinoColors.white.withValues(alpha: 0.02),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Progress Indicator (The "Jewel" Ring)
                  SizedBox(
                    width: 230.rf(context),
                    height: 230.rf(context),
                    child: CupertinoAnimatedProgress(
                      percent: percent,
                      // strokeWidth: 8,
                      // backgroundColor: context.primaryColor.withValues(
                      //   alpha: 0.05,
                      // ),
                      // color: context.primaryColor,
                      // strokeCap: StrokeCap.round, percent: null,
                    ),
                  ),

                  // SVG Centerpiece
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Uiutils.getSvg(
                        SvgConstants.result,
                        height: 80.rh(context),
                        color: ColorFilter.mode(
                          CupertinoColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(height: 10.rh(context)),
                      Text(
                        "${(percent * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 48.rf(context),
                          fontWeight: FontWeight.w900,
                          color: CupertinoColors.white,
                          letterSpacing: -2,
                        ),
                      ),
                    ],
                  ),

                  // Rotating Bending Text (Professional Branding)
                  BendingText(
                    text: "• $resultMessage • $resultMessage •".toUpperCase(),
                    radius: 145.rf(context),
                    startAngle: -90,
                    sweepAngle: 360,
                    textStyle:
                        AppText.getStyle(
                          context,
                          TextStyleType.smallBold,
                        ).copyWith(
                          color: context.primaryColor.withValues(alpha: 0.8),
                          letterSpacing: 4,
                          fontSize: 10.rf(context),
                        ),
                  ),
                ],
              ),

              const Spacer(),

              /// 📊 Elegant Stats Row
              _buildStatsRow(context),

              const Spacer(),

              /// ⚡ PREMIUM ACTION BUTTONS
              _buildPremiumButton(
                context,
                label: "RETRY CHALLENGE",
                // isPrimary: true,
                onTap: () => Navigator.pop(context),
              ),

              SizedBox(height: 16.rh(context)),

              _buildPremiumButton(
                context,
                label: "EXIT TO DASHBOARD",
                // isPrimary: false,
                onTap: () => context.goNamed(RouteNames.generate),
              ),

              SizedBox(height: 30.rh(context)),
            ],
          ),
        ),
      ),
    );
  }

  /// Helpers for that "Expensive" look
  Widget _buildAmbientGlow(BuildContext context, double percent) {
    return Container(
      width: 200.rf(context),
      height: 200.rf(context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.3),
            blurRadius: 100,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildGlassLabel(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: CupertinoColors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: CupertinoColors.white.withValues(alpha: 0.1)),
      ),
      child: Uiutils.getTextWidget(
        context,
        text,
        // style: TextStyle(
        color: context.primaryColor,
        fs: 10.rf(context),
        fw: FontWeight.bold,
        //   letterSpacing: 2,
        // ),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem(context, "CORRECT", "$answerCount"),
        _statItem(context, "QUESTIONS", "$totalQuestion"),
        _statItem(
          context,
          "ACCURACY",
          "${((answerCount / totalQuestion) * 100).toInt()}%",
        ),
      ],
    );
  }

  Widget _statItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Uiutils.getTextWidget(
          context,
          label,
          // style: TextStyle(
          color: CupertinoColors.white.withValues(alpha: .6),
          fs: 10.rf(context),
          // letterSpacing: 1,
          // ),
        ),
        SizedBox(height: 5.rh(context)),
        Uiutils.getTextWidget(
          context,
          value,
          // style: TextStyle(
          color: CupertinoColors.white,
          fs: 18.rf(context),
          fw: FontWeight.bold,
          // ),
        ),
      ],
    );
  }

  Widget _buildPremiumButton(
    BuildContext context, {
    required String label,
    // required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60.rh(context),
        margin: EdgeInsets.symmetric(horizontal: 20.rw(context)),
        decoration: BoxDecoration(
          color: context.primaryColor,
          borderRadius: BorderRadius.circular(20),
          // border: isPrimary ? null : Border.all(color: CupertinoColors.white24),
          boxShadow: [
            BoxShadow(
              color: context.primaryColor.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Uiutils.getTextWidget(
          context,
          label,
          // style: TextStyle(
          color: CupertinoColors.white,
          fw: FontWeight.w800,
          // letterSpacing: 1.2,
          fs: 14.rf(context),
          // ),
        ),
      ),
    );
  }

  String _resultTitle(double percent) {
    if (percent >= 90) return 'Prestige';
    if (percent >= 80) return 'Elite';
    if (percent >= 60) return 'Pro';
    if (percent >= 40) return 'Mid Level';
    // if (percent >= 60) return 'Pro';
    return 'Novice';
  }

  String _resultMessage(double percent) {
    if (percent >= 90) return 'Mastery Unlocked';
    if (percent >= 80) return 'Exceptional Skill';
    if (percent >= 60) return 'Solid Progress';
    return 'Growth Mindset';
  }
}

//!>>>>>>>>>>>>>>>>>>>>>>>>

// import 'dart:developer';
// import 'package:clean_architutre_learn/core/router/route_names.dart';
// import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
// import 'package:flutter/cupertino.dart';

// import 'package:clean_architutre_learn/core/constants/svg_constants.dart';
// import 'package:clean_architutre_learn/core/constants/widgets/bending_text.dart';
// import 'package:clean_architutre_learn/core/constants/widgets/custom_frame_widget.dart';
// import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
// import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
// import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
// import 'package:go_router/go_router.dart';

// class QuizScoreScreen extends StatelessWidget {
//   const QuizScoreScreen({
//     super.key,
//     required this.answerCount,
//     required this.totalQuestion,
//   });

//   final int answerCount;
//   final int totalQuestion;

//   @override
//   Widget build(BuildContext context) {
//     log('Score: $answerCount / $totalQuestion');

//     final double percent = (answerCount / totalQuestion) * 100;

//     final String resultMessage = _resultMessage(percent);
//     final String title = _resultTitle(percent);

//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (didPop, result) {
//         if (didPop) return;
//         context.goNamed(RouteNames.generate);
//       },
//       child: CupertinoPageScaffold(
//         child: CustomFrameBodyWidget(
//           child: Center(
//             child: Column(
//               spacing: 12.rh(context),
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 80.rh(context)),

//                 /// 🎉 Title
//                 Uiutils.getTextWidget(
//                   context,
//                   title,
//                   fs: 22.rf(context),
//                   fw: FontWeight.bold,
//                 ),

//                 SizedBox(height: 12.rh(context)),

//                 /// 📊 Score Text
//                 Uiutils.getTextWidget(
//                   context,
//                   '$answerCount / $totalQuestion Correct',
//                   fs: 18.rf(context),
//                   color: context.primaryColor,
//                 ),

//                 SizedBox(height: 6.rh(context)),

//                 Uiutils.getTextWidget(
//                   context,
//                   '${percent.toStringAsFixed(1)}%',
//                   fs: 16.rf(context),
//                 ),

//                 SizedBox(height: 40.rh(context)),

//                 /// 🎯 Result Graphic
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // SizedBox(height: 20.rh(context)),
//                     Uiutils.getSvg(
//                       SvgConstants.result,
//                       height: 220.rh(context),
//                       color: ColorFilter.mode(
//                         context.primaryColor,
//                         BlendMode.colorDodge,
//                       ),
//                     ),

//                     /// 🔄 Curved Result Message
//                     BendingText(
//                       text: resultMessage,
//                       radius: 150.rf(context),
//                       sweepAngle: 180,
//                       startAngle: -180,
//                       textStyle: AppText.getStyle(
//                         context,
//                         TextStyleType.largeBold,
//                       ),
//                     ),
//                   ],
//                 ),

//                 const Spacer(),

//                 /// 🔁 Action Buttons
//                 CupertinoButton.filled(
//                   child: const Text('Retry Quiz'),
//                   onPressed: () => Navigator.pop(context),
//                 ),

//                 SizedBox(height: 16.rh(context)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// 🧠 Result Title
//   String _resultTitle(double percent) {
//     if (percent >= 90) return 'Outstanding 🎉';
//     if (percent >= 80) return 'Great Job 👏';
//     if (percent >= 60) return 'Good Effort 👍';
//     return 'Keep Practicing 💪';
//   }

//   /// 🧠 Result Message
//   String _resultMessage(double percent) {
//     if (percent >= 90) {
//       return 'Perfect performance! You nailed it';
//     } else if (percent >= 80) {
//       return 'You did really well, keep it up';
//     } else if (percent >= 60) {
//       return 'Nice try! Practice a bit more';
//     } else {
//       return 'Don’t give up — success is coming';
//     }
//   }
// }
