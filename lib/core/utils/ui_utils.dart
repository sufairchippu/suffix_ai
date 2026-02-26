import 'dart:math';
import 'dart:typed_data';

import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class Uiutils {
  static LottieBuilder getLottie(
    String assetName, {

    double? height,
    double? width,
    BoxFit? boxfit,
    bool? repeat,
  }) {
    return Lottie.asset(
      assetName,
      fit: boxfit,
      height: height,
      width: width,
      repeat: repeat,
    );
  }

  static SvgPicture getSvg(
    String assetName, {
    ColorFilter? color,
    double? height,
    double? width,
    BoxFit? boxfit,
  }) {
    return SvgPicture.asset(
      assetName,
      fit: boxfit ?? BoxFit.cover,
      height: height ?? 100,
      width: width ?? 60,
      colorFilter: color,
    );
  }

  static Image getassetImage(
    String assetName, {

    double? height,
    double? width,
    BoxFit? boxfit,
  }) {
    return Image.asset(
      assetName,
      fit: boxfit ?? BoxFit.cover,
      height: height ?? 100,
      width: width ?? 60,
    );
  }

  static Image getNetworkImage(
    String assetName, {

    double? height,
    double? width,
    BoxFit? boxfit,
  }) {
    return Image.network(
      assetName,
      fit: boxfit ?? BoxFit.cover,
      height: height ?? 100,
      width: width ?? 60,
    );
  }

  static Text getTextWidget(
    BuildContext context,
    String title, {
    int? maxline,
    TextOverflow? overFlow,
    Color? color,
    double? fs,
    FontWeight? fw,
    TextStyleType? textStyle,
    TextWidthBasis? textWidthBasis,
    TextAlign? textAlign,
  }) {
    return Text(
      title,
      textAlign: textAlign,
      // textWidthBasis: TextWidthBasis.parent,
      style: AppText.getStyle(
        color: color,
        fontSize: fs,
        fontweight: fw,
        context,
        textStyle ?? TextStyleType.mediumRegular,
      ),
      textWidthBasis: textWidthBasis, //TextWidthBasis.parent
      maxLines: maxline,
      overflow: overFlow ?? TextOverflow.ellipsis,
    );
  }

  // Use Random.secure() for cryptographic randomness where available.
  static final Random _secureRandom = Random.secure();

  // A small counter to avoid collisions when called multiple times in the same microsecond.
  static int _counter = 0;

  /// Generates a unique string.
  /// Optional [prefix] can be used to add a readable label like "user_", "order_", etc.
  /// Example output: "user_17000000001234567-0001-4f2a9b3c8d"
  static String generateUniqueId({String prefix = ''}) {
    // High resolution timestamp (microseconds since epoch UTC)
    final int ts = DateTime.now().toUtc().microsecondsSinceEpoch;

    // Increment counter and keep it within a small range for compactness
    _counter = (_counter + 1) & 0xffff; // 16-bit wrap-around

    // Generate 6 random bytes (48 bits), cryptographically random
    final bytes = Uint8List(6);
    for (var i = 0; i < bytes.length; i++) {
      bytes[i] = _secureRandom.nextInt(256);
    }

    // Hex-encode random bytes (12 hex chars)
    final rndHex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

    // Counter as 4-hex digits (keeps fixed width)
    final counterHex = _counter.toRadixString(16).padLeft(4, '0');

    // Combine parts with separators for readability
    return '$prefix${ts.toString()}-$counterHex-$rndHex';
  }

  static DateTime parseBackendDate(String dateString) {
    final parts = dateString.split(' ');
    final dateParts = parts[0].split('/');
    final timeParts = parts[1].split(':');

    return DateTime(
      int.parse(dateParts[2]), // year
      int.parse(dateParts[1]), // month
      int.parse(dateParts[0]), // day
      int.parse(timeParts[0]), // hour
      int.parse(timeParts[1]), // minute
      int.parse(timeParts[2]), // second
    );
  }

  static String timeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return "Just Now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hrs ago";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    }
  }

  static void cupertinoSnackBar(
    BuildContext context,
    String message,
    bool isRed,
  ) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 40.rh(context),
        left: 20.rw(context),
        right: 20.rw(context),
        child: CupertinoPopupSurface(
          isSurfacePainted: true,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 250),
            child: Container(
              padding: EdgeInsets.all(14.rf(context)),
              decoration: BoxDecoration(
                color: isRed ? context.red : context.greyFirstColor,
                borderRadius: BorderRadius.circular(12.rf(context)),
              ),
              child: getTextWidget(
                context,
                message,
                textAlign: TextAlign.center,
                // style:  TextStyle(
                //   color: CupertinoColors.label,
                //   fontSize: 15.rf(context),
                // ),
              ),
            ),
          ),
        ),
      ),
    );

    // Insert snackbar into overlay
    overlay.insert(overlayEntry);

    // Auto remove after delay
    Future.delayed(const Duration(seconds: 2)).then((_) {
      overlayEntry.remove();
    });
  }

  static void showAlert(
    BuildContext context,
    VoidCallback onConformTap,
    String titile,
    String discription,
    bool cnacel,
    String conformText,
    Color infoColor, {
    bool somethingTodo = false,
    Widget? widget,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Uiutils.getTextWidget(context, titile, color: infoColor),
        content: somethingTodo
            ? widget
            : Uiutils.getTextWidget(context, discription),
        actions: [
          cnacel
              ? CupertinoDialogAction(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                )
              : const SizedBox(),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Uiutils.getTextWidget(
              context,
              conformText,
              color: infoColor,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              onConformTap(); // Call logout function
            },
          ),
        ],
      ),
    );
  }

  static modelBottomsheet(
    BuildContext context,
    Widget title,
    Widget discription,
    List<Widget> cupertinoactions,
    Widget cupertinoCancel,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: title,
          message: discription,
          actions: cupertinoactions,
          //  [
          //   CupertinoActionSheetAction(
          //     onPressed: () {
          //       Navigator.pop(context);
          //       debugPrint("Camera tapped");
          //     },
          //     child: const Text("📷 Open Camera"),
          //   ),
          //   CupertinoActionSheetAction(
          //     onPressed: () {
          //       Navigator.pop(context);
          //       debugPrint("Gallery tapped");
          //     },
          //     child: const Text("🖼️ Open Gallery"),
          //   ),
          // ],
          cancelButton: cupertinoCancel,
          // CupertinoActionSheetAction(
          //   isDefaultAction: true,
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   child: const Text("Cancel"),
          // ),
        );
      },
    );
  }

  static String mcqDailyPrompt() {
    return '''
You are a system that generates quiz questions.

Generate EXACTLY 5 multiple-choice questions.

Topic: General Knowledge (past, present, and future related facts)
Difficulty: Mixed (suitable for general users)

Rules:
- Each question MUST have exactly 4 options
- ONLY ONE option is correct
- Do NOT include explanations
- Do NOT include markdown
- Output MUST be valid JSON
- Do NOT include any extra text before or after JSON

Return ONLY this JSON structure:

{
  "type": "mcq",
  "questions": [
    {
      "question": "string",
      "options": ["string", "string", "string", "string"],
      "correct_index": 0
    }
  ]
}
''';
  }
  //   static String mcqDailyPrompt({
  //     // required int questionCount,
  //     // required String topic,
  //     // required String level,
  //     // String? subTopic,
  //     // String? categeory, //!
  //   }) {
  //     return '''
  // Generate EXACTLY 5 multiple-choice questions.

  // Topic: "GK(Like presnt , future past evrything)"
  // 'Sub-topic:''
  // Difficulty:'' //define latee :-level chose by user age declare or question number leavel

  // Rules:
  // - Each question has exactly 4 options
  // - Only ONE correct answer
  // - No explanations
  // - No markdown
  // - STRICT JSON only

  // Return this JSON format ONLY:

  // {
  //   "type": "mcq",
  //   "questions": [
  //     {
  //       "question": "string",
  //       "options": ["A", "B", "C", "D"],
  //       "correct_index": 0
  //     }
  //   ]
  // }
  // ''';
  //   }

  static String buildPrompt({
    required String paperType,
    required int questionCount,
    required String topic,
    required String level,
    String? subTopic,
    String? categeory,
  }) {
    if (paperType == CoreConstants.qustionText[0]) {
      return mcqPrompt(
        questionCount: questionCount,
        topic: topic,
        level: level,
        subTopic: subTopic,
        categeory: categeory,
      );
    } else if (paperType == CoreConstants.qustionText[1]) {
      return oneWordPrompt(
        questionCount: questionCount,
        topic: topic,
        level: level,
        subTopic: subTopic,
        categeory: categeory,
      );
    } else if (paperType == CoreConstants.qustionText[2]) {
      return tascPrompt(
        questionCount: questionCount,
        topic: topic,
        level: level,
        subTopic: subTopic,
        categeory: categeory,
      );
    } else if (paperType == CoreConstants.qustionText[3]) {
      return mixedExamPrompt(
        questionCount: questionCount,
        topic: topic,
        level: level,
        subTopic: subTopic,
        categeory: categeory,
      );
    } else if (paperType == CoreConstants.qustionText[4]) {
      return universityPrompt(
        questionCount: questionCount,
        topic: topic,
        level: level,
        subTopic: subTopic,
        categeory: categeory,
      );
    } else {
      throw Exception("Unsupported paper type: $paperType");
    }
  }

  static String mcqPrompt({
    required int questionCount,
    required String topic,
    required String level,
    String? subTopic,
    String? categeory, //!
  }) {
    return '''
Generate EXACTLY $questionCount multiple-choice questions.

Topic: "$topic"
${subTopic != null && subTopic.isNotEmpty ? 'Sub-topic: "$subTopic"' : ''}
Difficulty: $level

Rules:
- Each question has exactly 4 options
- Only ONE correct answer
- No explanations
- No markdown
- STRICT JSON only

Return this JSON format ONLY:

{
  "type": "mcq",
  "questions": [
    {
      "question": "string",
      "options": ["A", "B", "C", "D"],
      "correct_index": 0
    }
  ]
}
''';
  }

  static String oneWordPrompt({
    required int questionCount,
    required String topic,
    required String level,
    String? subTopic,
    String? categeory, //!
  }) {
    return '''
Generate EXACTLY $questionCount one-word or very short-answer questions.

Topic: "$topic"
${subTopic != null && subTopic.isNotEmpty ? 'Sub-topic: "$subTopic"' : ''}
Difficulty: $level

Rules:
- Answers must be ONE word or ONE short line
- No explanations
- No markdown
- STRICT JSON only

Return this format:

{
  "one_word_paper": [
    {
      "question": "string",
      "answer": "string"
    }
  ]
}
''';
  }

  static String tascPrompt({
    required int questionCount,
    required String topic,
    required String level,
    String? subTopic,
    String? categeory,
  }) {
    return '''
Generate a TASC-style exam with EXACTLY $questionCount questions.

Topic: "$topic"
${subTopic != null && subTopic.isNotEmpty ? 'Sub-topic: "$subTopic"' : ''}
Difficulty: $level

Rules:
- Each question must include a description
- Answers should be concise
- No markdown
- STRICT JSON only

Return this format:
{
  "type": "tasc",
  "questions": [
    {
      "question": "string",
      "description": "string",
      "answer": "string"
    }
  ]
}
''';
  }

  static String mixedExamPrompt({
    required int questionCount,
    required String topic,
    required String level,
    String? subTopic,
    String? categeory,
  }) {
    const totalRatio = 4 + 2 + 3 + 1;

    final shortAnswer = (questionCount * 4) ~/ totalRatio;
    final mcq = (questionCount * 2) ~/ totalRatio;
    final medium = (questionCount * 3) ~/ totalRatio;
    final essay = (questionCount * 1) ~/ totalRatio;

    return '''
Generate an exam paper.

Topic: "$topic"
${subTopic != null && subTopic.isNotEmpty ? 'Sub-topic: "$subTopic"' : ''}
Difficulty: $level

Include:
- Short Answer: $shortAnswer
- MCQ: $mcq
- Medium Answer: $medium
- Essay: $essay

Rules:
- No explanations
- No markdown
- STRICT JSON only

Return this format:

     {
                "exam_paper": [
                  { "type": "short_answer", "question": "...", "answer": "..." },
                  { "type": "mcq", "question": "...", "options": ["..."], "answer_index": "..." },
                  { "type": "long_answer", "question": "...", "answer": "..." },
                  { "type": "essay", "question": "...", "answer": "..." }
                ]
              }
''';
  }

  static String universityPrompt({
    required int questionCount,
    required String topic,
    required String level,
    String? subTopic,
    String? categeory,
  }) {
    const totalRatio = 4 + 2 + 3 + 1;

    final shortAnswer = (questionCount * 4) ~/ totalRatio;
    final mcq = (questionCount * 2) ~/ totalRatio;
    final medium = (questionCount * 3) ~/ totalRatio;
    final essay = (questionCount * 1) ~/ totalRatio;

    return '''
Generate a university-style exam paper.

Topic: "$topic"
${subTopic != null && subTopic.isNotEmpty ? 'Sub-topic: "$subTopic"' : ''}
Difficulty: $level
Total Questions: $questionCount

Rules:
- Each section may ignore ONE optional question
- No explanations
- No markdown
- question count
  > short answer - $shortAnswer
  > mcq - $mcq
  > long_answer - $medium
  > essay - $essay
- STRICT JSON only

Return this format:
         {
                "exam_paper": [
                  { "type": "short_answer", "question": "...", "answer": "..." },
                  { "type": "mcq", "question": "...", "options": ["..."], "answer_index": "..." },
                  { "type": "long_answer", "question": "...", "answer": "..." },
                  { "type": "essay", "question": "...", "answer": "..." }
                ]
              }
''';
  }
}
