import 'dart:developer';

import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/utils/validation.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/mcq_paper_model.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/short_answer_model.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/tasc_papper_model.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/university_normal_model.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  static Future<Uint8List> genratPdf({
    required dynamic questionData,
    required String papperType,
    required String topic,
    String? universityName,
    String? time,
    String? mark,
    String? subtopic,
    String? discription,
    String? pappercode,
  }) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          log("Building pdf page >>>>>>>>>>>>>>>>>>>>>>>>>>");
          return [
            // ---------------------------
            pw.Center(
              child: pw.Column(
                children: [
                  universityName != '' &&
                          universityName != null &&
                          universityName.isNotEmpty
                      ? pw.Text(
                          universityName,
                          style: pw.TextStyle(
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        )
                      : pw.SizedBox(),
                  pw.SizedBox(height: 8),

                  topic != '' && topic.isNotEmpty
                      ? pw.Text(
                          "Subject: $topic",
                          style: const pw.TextStyle(fontSize: 16),
                        )
                      : pw.SizedBox(),

                  subtopic != '' && subtopic != null && subtopic.isNotEmpty
                      ? pw.Text(
                          "Subject: $subtopic",
                          style: const pw.TextStyle(fontSize: 16),
                        )
                      : pw.SizedBox(),
                  time != '' && time != null && time.isNotEmpty
                      ? pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Text(
                              "Exam Duration: ${Validators.parseTime(int.tryParse(time)!)}",
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ],
                        )
                      : pw.SizedBox(),
                  mark != '' && mark != null && mark.isNotEmpty
                      ? pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,

                          children: [
                            pw.Text(
                              "Total Marks: $mark",
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ],
                        )
                      : pw.SizedBox(),

                  pw.SizedBox(height: 20),
                  pw.Divider(),
                ],
              ),
            ),

            pw.SizedBox(height: 20),

            // ---------------------------
            // INSTRUCTIONS (Optional)
            // ---------------------------
            if (discription != null &&
                discription.isNotEmpty &&
                discription != '') ...[
              pw.Text(
                "Instructions:",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              pw.Bullet(text: discription),

              // pw.Bullet(text: "All questions are compulsory."),
              // pw.Bullet(text: "Marks are indicated on the right."),
              pw.SizedBox(height: 20),
            ],

            // ---------------------------
            // QUESTIONS LIST
            // ---------------------------
            // pw.Text(
            //   "Part A — Multiple Choice Questions (1 × 10 = 10 Marks)",
            //   style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
            // ),
            pw.SizedBox(height: 10),
            if (papperType == CoreConstants.qustionText[0])
              _buildMcqQuestionMetode(questionData: questionData),

            if (papperType == CoreConstants.qustionText[1])
              _buildShortAnswerMethode(questionData: questionData),
            //!pending one
            if (papperType == CoreConstants.qustionText[2])
              _buildTaskAnswerMethode(
                questionData: questionData,
              ), //questionData
            if (papperType == CoreConstants.qustionText[3])
              _buildUniversityMethode(questionData: questionData),
            if (papperType == CoreConstants.qustionText[4])
              _buildUniversityMethode(
                questionData: questionData,
                isHavExption: true,
              ),
            // if (papperType == CoreConstants.qustionText[4])
            //   pw.Column(
            //     children: [
            //       pw.ListView.builder(
            //         itemBuilder: (context, index) {
            //           return pw.Text('text');
            //         },
            //         itemCount: 10,
            //       ),
            //     ],
            //   ),
            pw.SizedBox(height: 20),
          ];
        },
      ),
    );
    return pdf.save();
  }

  static pw.Column _buildUniversityMethode({
    required List<ExamPaper> questionData,
    bool isHavExption = false,
  }) {
    // final shortNaswer=
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Center(
          child: pw.Text(
            "Short Answer ${isHavExption ? "- with one exception question" : ""}",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
          ),
        ),
        pw.SizedBox(height: 5),

        pw.Text(
          "Write Answers in minimum of word 3 to 5 words",
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
        ),
        pw.Divider(),
        pw.SizedBox(height: 10),
        ...questionData
            .where((element) => element.type == 'short_answer')
            .toList()
            .asMap()
            .entries
            .map((e) {
              final value = e.value;
              final index = e.key;
              return pw.Padding(
                padding: const pw.EdgeInsets.all(12),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${index + 1}. ${value.question}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.normal),
                    ),
                  ],
                ),
              );
            }),
        pw.SizedBox(height: 10),
        pw.Divider(),
        pw.Center(
          child: pw.Text(
            "Multi-Choice Question ${isHavExption ? "- with one exception question" : ""} ",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
          ),
        ),
        pw.SizedBox(height: 5),

        pw.Text(
          "Pick right one from options",
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
        ),
        pw.Divider(),
        pw.SizedBox(height: 10),
        ...questionData
            .where((element) => element.type == 'mcq')
            .toList()
            .asMap()
            .entries
            .map((e) {
              final value = e.value;
              final index = e.key;
              return pw.Padding(
                padding: const pw.EdgeInsets.all(12),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${index + 1}. ${value.question}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.normal),
                    ),
                    pw.SizedBox(height: 6),

                    pw.Wrap(
                      spacing: 20,
                      runSpacing: 6,
                      children: value.options!.asMap().entries.map((opt) {
                        return pw.SizedBox(
                          width: 250,
                          child: pw.Text('${opt.key + 1}) ${opt.value}'),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }),
        pw.SizedBox(height: 10),
        pw.Divider(),
        pw.Center(
          child: pw.Text(
            "Long Answers ${isHavExption ? "- with one exception question" : ""}",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
          ),
        ),
        pw.SizedBox(height: 5),

        pw.Text(
          "Write 3 to 4 paragraph as answers",
          style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 16),
        ),
        pw.Divider(),
        pw.SizedBox(height: 10),
        ...questionData
            .where((element) => element.type == 'long_answer')
            .toList()
            .asMap()
            .entries
            .map((e) {
              final value = e.value;
              final index = e.key;
              return pw.Padding(
                padding: const pw.EdgeInsets.all(12),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${index + 1}. ${value.question}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 6),

                    // pw.Wrap(
                    //   spacing: 20,
                    //   runSpacing: 6,
                    //   children: value.options!.asMap().entries.map((opt) {
                    //     return pw.SizedBox(
                    //       width: 250,
                    //       child: pw.Text('${opt.key + 1}) ${opt.value}'),
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                ),
              );
            }),
        pw.SizedBox(height: 10),
        pw.Divider(),
        pw.Center(
          child: pw.Text(
            "Essay ${isHavExption ? "- with one exception question" : ""}",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
          ),
        ),

        pw.Text(
          "Write 6 to 8 paragraph as answers",
          style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 16),
        ),
        pw.Divider(),
        pw.SizedBox(height: 10),
        ...questionData
            .where((element) => element.type == 'essay')
            .toList()
            .asMap()
            .entries
            .map((e) {
              final value = e.value;
              final index = e.key;
              return pw.Padding(
                padding: const pw.EdgeInsets.all(12),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${index + 1}. ${value.question}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 6),
                  ],
                ),
              );
            }),
        // pw.ListView.builder(
        //   itemBuilder: (context, index) {
        //     return pw.Text('text');
        //   },
        //   itemCount: 10,
        // ),
      ],
    );
  }

  //!3
  static pw.Column _buildTaskAnswerMethode({
    required List<TascQuestionModel> questionData,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        ...questionData.asMap().entries.map((e) {
          final index = e.key;
          final value = e.value;
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('$index .   ${value.question}'),
              pw.SizedBox(height: 12),
              pw.Text('$index .   ${value.description}'),
              // pw.Text('$index .   ${value.question}'),
            ],
          );
        }),
      ],
    );
  }

  //!2
  static pw.Column _buildShortAnswerMethode({
    required List<QuestionModel> questionData,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,

      children: [
        ...questionData.asMap().entries.map((e) {
          final index = e.key;
          final value = e.value;
          return pw.Padding(
            padding: const pw.EdgeInsets.all(12),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '${index + 1}. ${value.qestion}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          );
        }),

        pw.SizedBox(height: 20),
        pw.Text('Answers', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(),
        pw.SizedBox(height: 6),
        pw.Wrap(
          crossAxisAlignment: pw.WrapCrossAlignment.center,
          spacing: 20,
          children: questionData
              .asMap()
              .entries
              .map((e) => pw.Text("${e.key + 1}. ${e.value.answer}"))
              .toList(),
        ),
      ],
    );
  }

  //!1
  static pw.Widget _buildMcqQuestionMetode({
    required List<McqQuestionModel> questionData,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        ...questionData.asMap().entries.map((entry) {
          final index = entry.key;
          final mcq = entry.value;

          return pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 12),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '${index + 1}. ${mcq.question}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 6),

                pw.Wrap(
                  spacing: 20,
                  runSpacing: 6,
                  children: mcq.options.asMap().entries.map((opt) {
                    return pw.SizedBox(
                      width: 250,
                      child: pw.Text(' ${opt.value}'), //${opt.key + 1})
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }),

        pw.SizedBox(height: 20),
        pw.Text('Answers', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Divider(),

        pw.Wrap(
          spacing: 20,
          children: questionData.asMap().entries.map((e) {
            const list = ['A', 'B', 'C', 'D'];
            return pw.Text('${e.key + 1}. ${list[e.value.correctIndex]}');
          }).toList(),
        ),
      ],
    );
  }

  // static pw.Column _buildMcqQuestionMetode(questionData) {
  //   return pw.Column(
  //     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //     children: [
  //       pw.ListView.builder(
  //         itemBuilder: (context, index) {
  //           final mcq = questionData[index] as McqQuestion;
  //           return pw.Column(
  //             children: [
  //               pw.Text(mcq.question),
  //               pw.Expanded(
  //                 child: pw.GridView(
  //                   crossAxisCount: 2,
  //                   children: mcq.options
  //                       .asMap()
  //                       .entries
  //                       .map(
  //                         (e) => pw.Row(
  //                           children: [
  //                             pw.Text('${e.key + 1}'),
  //                             pw.Text(e.value),
  //                           ],
  //                         ),
  //                       )
  //                       .toList(),
  //                   //  [

  //                   // ],
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //         itemCount: questionData.length,
  //       ),
  //       pw.Text('Answers'),
  //       pw.Divider(),
  //       pw.Expanded(
  //         child: pw.GridView(
  //           crossAxisCount: 4,
  //           children: (questionData as List<McqQuestion>)
  //               .asMap()
  //               .entries
  //               .map(
  //                 (e) => pw.Row(
  //                   children: [
  //                     pw.Text('${e.key + 1}.'),
  //                     pw.Text('${e.value.correctAnswerIndex + 1}'),
  //                   ],
  //                 ),
  //               )
  //               .toList(),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
