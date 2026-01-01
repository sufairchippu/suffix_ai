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
// }

import 'dart:developer';
import 'package:flutter/cupertino.dart';

import 'package:clean_architutre_learn/core/constants/svg_constants.dart';
import 'package:clean_architutre_learn/core/constants/widgets/bending_text.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_frame_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';

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
    log('Score: $answerCount / $totalQuestion');

    final double percent = (answerCount / totalQuestion) * 100;

    final String resultMessage = _resultMessage(percent);
    final String title = _resultTitle(percent);

    return CupertinoPageScaffold(
      child: CustomFrameBodyWidget(
        child: Column(
          children: [
            SizedBox(height: 80.rh(context)),

            /// 🎉 Title
            Uiutils.getTextWidget(
              context,
              title,
              fs: 22.rf(context),
              fw: FontWeight.bold,
            ),

            SizedBox(height: 12.rh(context)),

            /// 📊 Score Text
            Uiutils.getTextWidget(
              context,
              '$answerCount / $totalQuestion Correct',
              fs: 18.rf(context),
              color: context.primaryColor,
            ),

            SizedBox(height: 6.rh(context)),

            Uiutils.getTextWidget(
              context,
              '${percent.toStringAsFixed(1)}%',
              fs: 16.rf(context),
            ),

            SizedBox(height: 40.rh(context)),

            /// 🎯 Result Graphic
            Stack(
              alignment: Alignment.center,
              children: [
                Uiutils.getSvg(
                  SvgConstants.result,
                  height: 220.rh(context),
                  color: ColorFilter.mode(
                    context.primaryColor,
                    BlendMode.colorDodge,
                  ),
                ),

                /// 🔄 Curved Result Message
                BendingText(
                  text: resultMessage,
                  radius: 150.rf(context),
                  sweepAngle: 180,
                  startAngle: -180,
                  textStyle: TextStyle(
                    fontSize: 14.rf(context),
                    fontWeight: FontWeight.w600,
                    color: context.primaryColor,
                  ),
                ),
              ],
            ),

            const Spacer(),

            /// 🔁 Action Buttons
            CupertinoButton.filled(
              child: const Text('Retry Quiz'),
              onPressed: () => Navigator.pop(context),
            ),

            SizedBox(height: 16.rh(context)),
          ],
        ),
      ),
    );
  }

  /// 🧠 Result Title
  String _resultTitle(double percent) {
    if (percent >= 90) return 'Outstanding 🎉';
    if (percent >= 80) return 'Great Job 👏';
    if (percent >= 60) return 'Good Effort 👍';
    return 'Keep Practicing 💪';
  }

  /// 🧠 Result Message
  String _resultMessage(double percent) {
    if (percent >= 90) {
      return 'Perfect performance! You nailed it';
    } else if (percent >= 80) {
      return 'You did really well, keep it up';
    } else if (percent >= 60) {
      return 'Nice try! Practice a bit more';
    } else {
      return 'Don’t give up — success is coming';
    }
  }
}
