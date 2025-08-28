import 'dart:developer';
import 'package:clean_architutre_learn/core/constants/lottie_constant.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
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
import '../../../../core/theme/theme_notifier.dart';
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
  String _spokenText = "";
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

  // void _initializeTts() async {
  //   // Optional: Check languages
  //   var languages = await _flutterTts.getLanguages;
  //   print("Languages available: $languages");

  //   // Optional: Check voices
  //   // var voices = await _flutterTts.getVoices;
  //   // print("Voices available: $voices");

  //   // Set default language
  //   await _flutterTts.setLanguage("en-US");

  //   // Set pitch (0.5 - 2.0)
  //   await _flutterTts.setPitch(1.2);
  //   await _flutterTts.setVoice({
  //     "name": "com.apple.voice.compact.en-US.Samantha",
  //     "locale": "en-US",
  //   });

  //   // Set speech rate (0.0 - 1.0)
  //   await _flutterTts.setSpeechRate(0.5);

  //   // Optional: Volume (0.0 - 1.0)
  //   await _flutterTts.setVolume(1.0);
  // }

  // final FlutterTts _flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    final loadingAiMsg = ref.watch(loadingmsgProvider);
    final isListening = ref.watch(voiceListenProvider);

    return CupertinoPageScaffold(
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

          // AnimatedPositioned(
          //   left: 100, //change it
          //   top: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: Container(height: 100,color: context.red,),
          //   duration: Duration(milliseconds: 300),
          // ),
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
                      // firstLetter: "user first Letter",
                      // netwrkImage: 'avatar path',
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
                    GestureDetector(
                      onTap: () {
                        context.pop();
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
                      // setState(() => _isListening = false);
                      ref.read(voiceListenProvider.notifier).state = false;
                      _spokenText != ''
                          ? () async {
                              final chat = Chatbubble(
                                message: _spokenText,
                                time: DateTime.now().toFormattedString(),
                                msgtype: MessegeOwner.user,
                              );

                              log('User message posting: $_spokenText');

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
                        setState(() {
                          _spokenText = text;
                        });
                      });
                      ref.read(voiceListenProvider.notifier).state = true;
                    }
                  },
                  // inputController.text=_spokenText;
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
        ],
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
