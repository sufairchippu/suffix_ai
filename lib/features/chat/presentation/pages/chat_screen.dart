import 'dart:developer';
import 'package:clean_architutre_learn/core/constants/lottie_constant.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
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
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/widgets/app_logo_widget.dart';
import '../../../../core/service/speach/speech_service.dart';

import '../provider/tts_provider.dart';
import '../widgets/custom_chat_bubble_widget.dart';
import '../widgets/chat_bakground_screen.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController inputController = TextEditingController();
  final SpeechService _speechService = SpeechService();
  // String _spokenText = "";
  // bool _isListening = false;
  Future<void> _initSpeech() async {
    await Permission.microphone.request();
    await Permission.speech.request();

    bool available = await _speechService.initialize();
    if (!available) {
      print("Speech recognition not available");
    }
  }

  @override
  void initState() {
    ref.read(chatListNotifierProvider.notifier).loadChats();
    _initSpeech();
    // _initializeTts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadingAiMsg = ref.watch(loadingmsgProvider);
    final isListening = ref.watch(voiceListenProvider);
    final spokenText = ref.watch(speakingTestProvider);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {},
      child: CupertinoPageScaffold(
        child: Stack(
          children: [
            const Positioned.fill(
              child: GradientMotionBackground(
                // colors: [
                //   context.dynamicColor1,
                //   context.dynamicColor2,
                //   context.dynamicColor3,
                // ],
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
                          ref.read(chatHistoryProvider.notifier).state = true;
                        },
                        icon: null,
                        boxColor: context.mainDarkShadeColor,
                      ),
                      const Spacer(),

                      AppLogoWidget(
                        logoNeeded: true,
                        logoheit: 70.rh(context),
                        textColor: context.cardColor,
                      ),

                      const Spacer(),
                      Consumer(
                        builder: (context, ref, child) {
                          final isdrawer = ref.watch(chatHistoryProvider);
                          return GestureDetector(
                            onTap: () {
                              isdrawer
                                  ? ref
                                            .read(chatHistoryProvider.notifier)
                                            .state =
                                        false
                                  : context.pop();
                              // ref
                              //     .read(chatListNotifierProvider.notifier)
                              //     .clearChatts();
                              // ref.read(chatListNotifierProvider.notifier).loadChats();
                            },
                            child: Icon(
                              CupertinoIcons.xmark_circle,
                              size: 30.rf(context),
                              color: context.mainDarkShadeColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  Consumer(
                    builder: (context, ref, child) {
                      final chatlist = ref
                          .watch(chatListNotifierProvider)
                          .reversed
                          .toList();

                      return _buildChatList(chatlist, loadingAiMsg, ref);
                    },
                  ),

                  CustomTextFormField(
                    onHold: () async {
                      if (isListening) {
                        _speechService.stopListening();

                        ref.read(voiceListenProvider.notifier).state = false;
                        spokenText != ''
                            ? () async {
                                final chat = Chatbubble(
                                  message: spokenText,
                                  time: DateTime.now().toFormattedString(),
                                  msgtype: MessegeOwner.user,
                                );

                                log('User message posting: $spokenText');

                                try {
                                  // Add user chat
                                  await ref
                                      .read(chatListNotifierProvider.notifier)
                                      .addchats(chat);

                                  // Reload chats
                                  await ref
                                      .read(chatListNotifierProvider.notifier)
                                      .loadChats();

                                  // Clear input field
                                  inputController.clear();

                                  log('Fetching AI response...');
                                  await ref
                                      .read(aiMessgeNotifierProvider.notifier)
                                      .getAiReply(chat.message);
                                } catch (e) {
                                  log('Error while sending message: $e');
                                }
                              }
                            : () {};
                      } else {
                        _speechService.startListening((text) {
                          ref.read(speakingTestProvider.notifier).state = text;
                        });
                        ref.read(voiceListenProvider.notifier).state = true;
                      }
                    },
                    prefixOntap: () {},
                    boxshadows: [
                      BoxShadow(
                        color: context.containerGrayColor.withValues(
                          alpha: 0.3,
                        ),
                        blurRadius: 6,
                        offset: const Offset(0, 2), // light shadow closer
                      ),
                      BoxShadow(
                        color: context.containerGrayColor.withValues(
                          alpha: 0.6,
                        ),
                        blurRadius: 12,
                        offset: const Offset(
                          0,
                          4,
                        ), // deeper shadow further away
                      ),
                    ],
                    fillcolor: context.dynamicColor4,
                    obscure: false,
                    icon: CupertinoIcons.add_circled,
                    hintText: "Ask Me Anything",
                    controller: inputController,
                    loadingOnsomething: loadingAiMsg,
                    iconColor: context.subTextColor,
                    isWantsuffix: true,
                    maxline: null,
                    textInputAction: TextInputAction.newline,
                    onTap: () async {
                      final text = inputController.text.trim();
                      if (text.isEmpty) return;

                      final chat = Chatbubble(
                        message: text,
                        time: DateTime.now().toFormattedString(),
                        msgtype: MessegeOwner.user,
                      );

                      log('User message posting: $text');

                      try {
                        // Add user chat
                        await ref
                            .read(chatListNotifierProvider.notifier)
                            .addchats(chat);

                        // Reload chats
                        await ref
                            .read(chatListNotifierProvider.notifier)
                            .loadChats();

                        // Clear input field
                        inputController.clear();

                        log('Fetching AI response...');
                        await ref
                            .read(aiMessgeNotifierProvider.notifier)
                            .getAiReply(chat.message);
                      } catch (e) {
                        log('Error while sending message: $e');
                      }
                    },
                    suffixIcon: CupertinoIcons.paperplane_fill,
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final isdrawer = ref.watch(chatHistoryProvider);
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: 0,
                  bottom: 0,
                  left: isdrawer ? 0 : -350.rw(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.rw(context),
                      vertical: 40.rh(context),
                    ),
                    decoration: BoxDecoration(
                      color: context.cardColor3,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(30.rf(context)),
                      ),
                    ),
                    // height: double.infinity,
                    width: 350.rw(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.rh(context)),

                        Row(
                          children: [
                            CustomCircleImageWidget(onTap: () {}),
                            SizedBox(width: 20.rw(context)),
                            Uiutils.getTextWidget(context, 'Sufair RF'),
                          const  Spacer(),
                            GestureDetector(
                              onTap: () {

                                //add to fire base  whole this engineer
                                ref
                                    .read(chatListNotifierProvider.notifier)
                                    .clearChatts();
                              },
                              child: Column(
                                children: [
                                  AppLogoWidget(
                                    textNeeded: false,
                                    logoheit: 50.rf(context),
                                  ),
                                  Uiutils.getTextWidget(
                                    context,
                                    'New Chat',
                                    textStyle: TextStyleType.extraSmallBold,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.rh(context)),
                        // Divider(),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: .1.rh(context)),
                          ),
                        ),
                        SizedBox(height: 10.rh(context)),

                        GestureDetector(
                          onTap: () {
                            ref
                                .read(chatListNotifierProvider.notifier)
                                .clearChatts();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Uiutils.getTextWidget(context, 'Clear History'),
                              const Icon(CupertinoIcons.trash),
                            ],
                          ),
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     border: Border.all(width: .01.rh(context)),
                        //   ),
                        // ),
                        SizedBox(height: 30.rh(context)),

                        Expanded(
                          child: ListView.builder(
                            itemCount: 12,
                            itemBuilder: (context, index) {
                              return CustomButtonWIdget(
                                widget: Row(
                                  children: [
                                    Uiutils.getTextWidget(
                                      context,
                                      'discussed topi',
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 12.rh(context)),
                        // Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(RouteNames.settings);
                              },
                              child: const Icon(CupertinoIcons.settings),
                            ),
                            GestureDetector(
                              onTap: () {
                                ref.read(chatHistoryProvider.notifier).state =
                                    false;
                              },
                              child: const Icon(CupertinoIcons.arrow_left),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildChatList(
    List<Chatbubble> chatlist,
    bool loadingAiMsg,
    WidgetRef ref,
  ) {
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Uiutils.getTextWidget(
                                  context,
                                  hour < 12
                                      ? "Good Morning ☀️,User"
                                      : hour < 17
                                      ? "Good Afternoon 🌤,User"
                                      : "Good Evening 🌙, User",
                                ),

                                if (chatlist.isEmpty) ...[
                                  Uiutils.getTextWidget(
                                    context,
                                    "How Can I Help Youh ,",
                                  ),
                                  SizedBox(height: 15.rh(context)),
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
              ],
            );
          }
          if (index == 0 && loadingAiMsg) {
            return Row(
              children: [
                LoadingAnimationWidget.fourRotatingDots(
                  color: context.buttnColor,
                  size: 40.rf(context),
                ),
              ],
            );
          }
          final chat = chatlist[index];

          return CustomChatBubbleWidget(chat: chat, loadingAiMsg: loadingAiMsg);
        },
      ),
    );
  }
}
