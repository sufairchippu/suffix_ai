import 'dart:developer';

import 'package:clean_architutre_learn/core/constants/lottie_constant.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/extenstion.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/connect_with_widget.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/custom_textform_field.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/presentation/provider/ai_provider.dart';
import 'package:clean_architutre_learn/features/chat/presentation/provider/chat_provider.dart';
import 'package:clean_architutre_learn/features/chat/presentation/widgets/chat_bubble_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/constants/widgets/app_logo_widget.dart';
import '../../../../core/theme/theme_notifier.dart';
import '../widgets/chat_bakground_screen.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController inputController = TextEditingController();
  @override
  void initState() {
    ref.read(chatListNotifierProvider.notifier).loadChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Positioned.fill(
            child: GradientMotionBackground(
              colors: [
                context.dynamicColor1,
                context.dynamicColor2,
                context.dynamicColor3,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 18.rh(context),
              top: 28.rh(context),
              left: 15.rw(context),
              right: 12.rw(context),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomCircleImageWidget(
                      onTap: () {
                        // context.pushNamed(RouteNames.chat);
                        ref.read(themeProvider.notifier).toggleTheme();
                        //drawer like something opening
                      },
                      firstLetter: "user first Letter",
                      // netwrkImage: 'avatar path',
                      icon: null,
                      boxColor: context.mainDarkShadeColor,
                    ),
                    Spacer(),

                    AppLogoWidget(
                      logoNeeded: true,
                      logoheit: 70.rh(context),
                      textColor: context.cardColor,
                    ),

                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(chatListNotifierProvider.notifier)
                            .clearChatts();
                        ref.read(chatListNotifierProvider.notifier).loadChats();
                      },
                      child: Icon(
                        CupertinoIcons.xmark_circle,
                        size: 30.rf(context),
                        color: context.mainDarkShadeColor,
                      ),
                    ),
                  ],
                ),

                Consumer(
                  builder: (context, ref, child) {
                    final chatlist = ref
                        .watch(chatListNotifierProvider)
                        .reversed
                        .toList();

                    return Expanded(
                      child: ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.zero,
                        // physics: NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        itemCount: chatlist.length + 1,
                        itemBuilder: (context, index) {
                          if (index == chatlist.length) {
                            final hour = DateTime.now().hour;
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(28.rf(context)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Uiutils.getLottie(
                                            LottieConstant.chatScreen,
                                            height: 60.rh(context),
                                            width: 80,
                                          ),
                                          SizedBox(width: 15.rw(context)),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Uiutils.getTextWidget(
                                                  context,
                                                  hour < 12
                                                      ? "Good Morning ☀️,"
                                                      : hour < 17
                                                      ? "Good Afternoon 🌤,"
                                                      : "Good Evening 🌙,",
                                                ),

                                                if (chatlist.isEmpty) ...[
                                                  Uiutils.getTextWidget(
                                                    context,
                                                    "How Can I Help Youh",
                                                  ),
                                                  SizedBox(
                                                    height: 15.rh(context),
                                                  ),
                                                ],
                                                Uiutils.getTextWidget(
                                                  context,
                                                  'Share Your thoughts ...',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 100.rh(context)),
                                // SizedBox.expand(),
                              ],
                            );
                          }
                          final chat = chatlist[index];

                          return Row(
                            mainAxisAlignment: chat.msgtype == MessegeOwner.user
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.6,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      chat.msgtype == MessegeOwner.user
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        8.rh(context),
                                        10.rh(context),
                                        0,
                                        0,
                                      ),
                                      child: CustomPaint(
                                        painter: ChatBubblePainter(
                                          color:
                                              chat.msgtype == MessegeOwner.user
                                              ? context.secondaryColor
                                              : context.primaryColor,
                                          isSender:
                                              chat.msgtype == MessegeOwner.user,
                                        ),
                                        child: Container(
                                          // decoration: BoxDecoration(
                                          //   color: chat.msgtype == MessegeOwner.user
                                          //       ? context.primaryColor
                                          //       : context.secondaryColor,
                                          //   borderRadius: BorderRadius.circular(
                                          //     20.rf(context),
                                          //   ),
                                          //   border: Border.all(
                                          //     width: 1.5.rf(context),
                                          //     color: CupertinoColors.transparent,
                                          //   ),
                                          // ),
                                          padding: EdgeInsets.all(
                                            14.rf(context),
                                          ),
                                          child:
                                              chat.msgtype == MessegeOwner.user
                                              ? Uiutils.getTextWidget(
                                                  context,
                                                  chat.message,
                                                  color: context.textColor,
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Uiutils.getTextWidget(
                                                          context,
                                                          "Suffix Ai",
                                                          textStyle: TextStyleType
                                                              .extraSmallBold,
                                                          color: context
                                                              .buttnColor,
                                                        ),
                                                        Spacer(),
                                                        LoadingAnimationWidget.staggeredDotsWave(
                                                          color: context
                                                              .subTextColor,
                                                          size: 20.rf(context),
                                                        ),
                                                      ],
                                                    ),
                                                    Uiutils.getTextWidget(
                                                      context,
                                                      chat.message,
                                                      color: context.cardColor,
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.rw(context),
                                      ),
                                      child: Uiutils.getTextWidget(
                                        context,
                                        Uiutils.timeAgo(
                                          Uiutils.parseBackendDate(chat.time),
                                        ),
                                        textStyle:
                                            TextStyleType.extraSmallsemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),

                CustomTextFormField(
                  prefixOntap: () {
                    // showCupertinoModalPopup(
                    //   context: context,
                    //   builder: (context) => CupertinoActionSheet(
                    //     actions: [
                    //       CupertinoActionSheetAction(
                    //         onPressed: () {
                    //           // open camera
                    //           Navigator.pop(context);
                    //         },
                    //         child: const Text("Camera"),
                    //       ),
                    //       CupertinoActionSheetAction(
                    //         onPressed: () {
                    //           // open gallery
                    //           Navigator.pop(context);
                    //         },
                    //         child: const Text("Gallery"),
                    //       ),
                    //       CupertinoActionSheetAction(
                    //         onPressed: () {
                    //           // open files
                    //           Navigator.pop(context);
                    //         },
                    //         child: const Text("Files"),
                    //       ),
                    //     ],
                    //     cancelButton: CupertinoActionSheetAction(
                    //       onPressed: () => Navigator.pop(context),
                    //       isDefaultAction: true,
                    //       child: const Text("Cancel"),
                    //     ),
                    //   ),
                    // );
                  },
                  boxshadows: [
                    BoxShadow(
                      color: context.containerGrayColor.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2), // light shadow closer
                    ),
                    BoxShadow(
                      color: context.containerGrayColor.withValues(alpha: 0.6),
                      blurRadius: 12,
                      offset: const Offset(0, 4), // deeper shadow further away
                    ),
                  ],
                  fillcolor: context.dynamicColor4,
                  obscure: false,
                  icon: CupertinoIcons.add_circled,
                  hintText: "Ask Me Anything",
                  controller: inputController,
                  iconColor: context.subTextColor,
                  isWantsuffix: true,
                  textInputAction: TextInputAction.search,
                  onTap: () {
                    final chat = Chatbubble(
                      message: inputController.text,
                      time: DateTime.now().toFormattedString(),
                      msgtype: MessegeOwner.user,
                    );
                    log('message of doinggggggg userrrr posting');

                    inputController.text.trim().isNotEmpty
                        ? ref
                              .read(chatListNotifierProvider.notifier)
                              .addchats(chat)
                              .then((value) {
                                ref
                                    .read(chatListNotifierProvider.notifier)
                                    .loadChats();

                                log('message of doinggggggg ai api posting');
                                return ref
                                    .read(aiMessgeNotifierProvider.notifier)
                                    .getAiReply(chat.message);
                              })
                        : null;
                    ref.read(chatListNotifierProvider.notifier).loadChats();
                    inputController.clear();
                  },
                  suffixIcon: CupertinoIcons.paperplane_fill,
                ),
              ],
            ),
          ),

          // SizedBox.expand(
          //   child: ListView.builder(
          //     itemBuilder: (context, index) {
          //       return Container();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
