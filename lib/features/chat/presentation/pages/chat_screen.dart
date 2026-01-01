import 'dart:developer';
import 'dart:io';
import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/constants/lottie_constant.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_keys.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_storage_service.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/extenstion.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/core/utils/validation.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/connect_with_widget.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/custom_textform_field.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/presentation/provider/ai_provider.dart';
import 'package:clean_architutre_learn/features/chat/presentation/provider/chat_provider.dart';
import 'package:clean_architutre_learn/features/chat/presentation/provider/supabase_provider.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/provider/attachment_provider.dart';
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
  // late final String chatSetID;
  Future<void> _initSpeech() async {
    await Permission.microphone.request();
    await Permission.speech.request();

    bool available = await _speechService.initialize();
    if (!available) {
      log("Speech recognition not available");
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initSpeech();
      ref.read(chatListNotifierProvider.notifier).clearChats();

      // final newchatProvider = ref.read(newChatNotifierProvider);
      ref.read(supabaseChatSetNotifierProvider.notifier).fetchChatSets();
      LocalStorageService.setString(
        LocalServiceKeys.CHAT_SET_ID,
        Uiutils.generateUniqueId(),
      );
      // chatSetID = LocalStorageService.getString(LocalServiceKeys.CHAT_SET_ID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isListening = ref.watch(voiceListenProvider);
    final spokenText = ref.watch(speakingTestProvider);
    final isdrawer = ref.watch(chatHistoryProvider);
    final asyncChats = ref.watch(chatListNotifierProvider);
    final asyncChatSet = ref.watch(supabaseChatSetNotifierProvider);
    final loadingProgressor = ref.watch(remotchatLoading);
    final attachmentState = ref.watch(chatAttachmentProvider);
    final attachemntProvider = ref.watch(attachementNotifierProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (isdrawer || attachmentState) {
          ref.invalidate(chatHistoryProvider); //.state = false;
          ref.invalidate(chatAttachmentProvider); //.state = false;
          return;
          // } else if (attachmentState) {
        }
        ref.invalidate(chatListNotifierProvider); //.clearChats();
        context.pop();
      },
      child: CupertinoPageScaffold(
        child: Stack(
          children: [
            const Positioned.fill(child: GradientMotionBackground()),

            Padding(
              padding: EdgeInsets.only(
                bottom: 18.rh(context),
                top: 28.rh(context),
                left: 15.rw(context),
                right: 12.rw(context),
              ),
              child: Column(
                children: [
                  // --- Top Header ---
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
                      GestureDetector(
                        onTap: () {
                          ref.invalidate(chatHistoryProvider); //.state = false;
                          ref.invalidate(
                            chatAttachmentProvider,
                          ); //.state = false;
                          ref.invalidate(chatListNotifierProvider);
                          context.pop();
                        },
                        child: Icon(
                          CupertinoIcons.xmark_circle,
                          size: 30.rf(context),
                          color: context.mainDarkShadeColor,
                        ),
                      ),
                    ],
                  ),
                  // --- Chat List ---
                  asyncChats.when(
                    data: (chats) {
                      log('${chats.length}');
                      final chatList = chats.reversed.toList();
                      return _buildChatList(chatList, ref, context);
                    },
                    loading: () => const Expanded(
                      child: Center(child: CupertinoActivityIndicator()),
                    ),
                    error: (e, _) => Expanded(
                      child: Center(child: Text('Error loading chats: $e')),
                    ),
                  ),

                  // --- Input Field ---
                  attachemntProvider.when(
                    data: (files) {
                      return Column(
                        children: [
                          if (files.isNotEmpty) ...[
                            Wrap(
                              spacing: 10.rf(context),
                              children: files.map((file) {
                                final type = Validators.fileType(file);
                                return Stack(
                                  children: [
                                    Container(
                                      width: 80.rw(context),
                                      height: 80.rh(context),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: context.buttnColor,
                                      ),
                                      child: type == "image"
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                File(file.path),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Center(
                                              child: Icon(
                                                Validators.fileIcon(type),
                                                size: 34.rf(context),
                                              ),
                                            ),
                                    ),

                                    // Close button
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () => ref
                                            .read(
                                              attachementNotifierProvider
                                                  .notifier,
                                            )
                                            .removeAttachment(file),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: context.mainDarkShadeColor
                                                .withValues(alpha: 0.5),
                                          ),
                                          padding: EdgeInsets.all(
                                            2.rf(context),
                                          ),
                                          child: Icon(
                                            CupertinoIcons.delete,
                                            size: 16.rf(context),
                                            color: context.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                          CustomTextFormField(
                            onHold: () async {
                              if (isListening) {
                                _speechService.stopListening();
                                ref.read(voiceListenProvider.notifier).state =
                                    false;
                                if (spokenText.isNotEmpty) {
                                  _sendMessage(ref, spokenText);
                                }
                              } else {
                                _speechService.startListening((text) {
                                  ref
                                          .read(speakingTestProvider.notifier)
                                          .state =
                                      text;
                                });
                                ref.read(voiceListenProvider.notifier).state =
                                    true;
                              }
                            },
                            prefixOntap: () {
                              ref.read(chatAttachmentProvider.notifier).state =
                                  !attachmentState;
                            },
                            fillcolor: context.dynamicColor4,
                            obscure: false,
                            icon: CupertinoIcons.add_circled,
                            hintText: "Ask Me Anything",
                            controller: inputController,
                            // loadingOnsomething: loadingAiMsg,
                            iconColor: context.subTextColor,
                            isWantsuffix: true,
                            maxline: null,
                            textInputAction: TextInputAction.newline,
                            onTap: () async {
                              try {
                                if (asyncChats.value!.isNotEmpty
                                //         && asyncChats.value!.length >= 1
                                ) {}

                                final text = inputController.text.trim();
                                if (text.isEmpty) return;
                                await _sendMessage(
                                  ref,
                                  text,
                                  files: files
                                      .map((e) => File(e.path))
                                      .toList(),
                                );
                                inputController.clear();
                              } catch (e) {
                                log('$e');
                              }
                            },
                            suffixIcon: CupertinoIcons.paperplane_fill,
                          ),
                        ],
                      );
                    },
                    error: (e, _) => Column(
                      children: [
                        Uiutils.getTextWidget(context, "Error: $e", maxline: 4),
                        CustomTextFormField(
                          onHold: () async {
                            if (isListening) {
                              _speechService.stopListening();
                              ref.read(voiceListenProvider.notifier).state =
                                  false;
                              if (spokenText.isNotEmpty) {
                                _sendMessage(ref, spokenText);
                              }
                            } else {
                              _speechService.startListening((text) {
                                ref.read(speakingTestProvider.notifier).state =
                                    text;
                              });
                              ref.read(voiceListenProvider.notifier).state =
                                  true;
                            }
                          },
                          prefixOntap: () {
                            ref.read(chatAttachmentProvider.notifier).state =
                                !attachmentState;
                          },
                          fillcolor: context.dynamicColor4,
                          obscure: false,
                          icon: CupertinoIcons.add_circled,
                          hintText: "Ask Me Anything",
                          controller: inputController,
                          // loadingOnsomething: loadingAiMsg,
                          iconColor: context.subTextColor,
                          isWantsuffix: true,
                          maxline: null,
                          textInputAction: TextInputAction.newline,
                          onTap: () async {
                            try {
                              if (asyncChats.value!.isNotEmpty
                              //         && asyncChats.value!.length >= 1
                              ) {}

                              final text = inputController.text.trim();
                              if (text.isEmpty) return;
                              await _sendMessage(ref, text);
                              inputController.clear();
                            } catch (e) {
                              log('$e');
                            }
                          },
                          suffixIcon: CupertinoIcons.paperplane_fill,
                        ),
                      ],
                    ),
                    loading: () => Column(
                      children: [
                        const CupertinoActivityIndicator(),
                        CustomTextFormField(
                          onHold: () async {
                            if (isListening) {
                              _speechService.stopListening();
                              ref.read(voiceListenProvider.notifier).state =
                                  false;
                              if (spokenText.isNotEmpty) {
                                _sendMessage(ref, spokenText);
                              }
                            } else {
                              _speechService.startListening((text) {
                                ref.read(speakingTestProvider.notifier).state =
                                    text;
                              });
                              ref.read(voiceListenProvider.notifier).state =
                                  true;
                            }
                          },
                          prefixOntap: () {
                            ref.read(chatAttachmentProvider.notifier).state =
                                !attachmentState;
                          },
                          fillcolor: context.dynamicColor4,
                          obscure: false,
                          icon: CupertinoIcons.add_circled,
                          hintText: "Ask Me Anything",
                          controller: inputController,
                          // loadingOnsomething: loadingAiMsg,
                          iconColor: context.subTextColor,
                          isWantsuffix: true,
                          maxline: null,
                          textInputAction: TextInputAction.newline,
                          onTap: () async {
                            try {
                              if (asyncChats.value!.isNotEmpty
                              //         && asyncChats.value!.length >= 1
                              ) {}

                              final text = inputController.text.trim();
                              if (text.isEmpty) return;
                              await _sendMessage(ref, text);
                              inputController.clear();
                            } catch (e) {
                              log('$e');
                            }
                          },
                          suffixIcon: CupertinoIcons.paperplane_fill,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.rh(context)),

                        Row(
                          children: [
                            CustomCircleImageWidget(onTap: () {}),
                            SizedBox(width: 20.rw(context)),
                            Uiutils.getTextWidget(context, 'Sufair RF'),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                LocalStorageService.setString(
                                  LocalServiceKeys.CHAT_SET_ID,
                                  Uiutils.generateUniqueId(),
                                );
                                //add to fire base  whole this engineer
                                ref.read(chatHistoryProvider.notifier).state =
                                    false;
                                ref
                                    .read(chatListNotifierProvider.notifier)
                                    .clearChats();
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
                            try {
                              ref
                                  .read(
                                    supabaseChatSetNotifierProvider.notifier,
                                  )
                                  .clearAllChat();
                            } catch (e) {
                              log('$e');
                            }
                            // ref
                            //     .read(chatListNotifierProvider.notifier)
                            //     .clearChats();
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

                        asyncChatSet.when(
                          data: (listData) {
                            final data = listData.reversed.toList();
                            log('$data-----------------------------');
                            return Expanded(
                              child: ListView.builder(
                                // reverse: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final item = data[index];
                                  return CustomButtonWIdget(
                                    onTap: () async {
                                      try {
                                        ref
                                            .read(
                                              chatListNotifierProvider.notifier,
                                            )
                                            .clearChats();
                                        ref
                                                .read(
                                                  chatHistoryProvider.notifier,
                                                )
                                                .state =
                                            false;
                                        ref
                                                .read(remotchatLoading.notifier)
                                                .state =
                                            true;
                                        LocalStorageService.setString(
                                          LocalServiceKeys.CHAT_SET_ID,
                                          item.chatSetId,
                                        );
                                        final chats = await ref
                                            .read(
                                              supabaseChatNotifierProvider
                                                  .notifier,
                                            )
                                            .fetchChats(item.chatSetId);
                                        debugPrint(item.chatSetId);

                                        debugPrint("$chats is added to it");
                                        for (Chatbubble chat in chats) {
                                          debugPrint(
                                            "${chat.msgtype} is added to it",
                                          );

                                          ref
                                              .read(
                                                chatListNotifierProvider
                                                    .notifier,
                                              )
                                              .addChat(chat);
                                        }
                                        ref
                                                .read(remotchatLoading.notifier)
                                                .state =
                                            false;
                                      } catch (e) {
                                        debugPrint(
                                          "$e    error: fetching chat from supabase ",
                                        );
                                      }
                                    },
                                    color: index % 2 == 0
                                        ? context.primaryColor.withValues(
                                            alpha: .4,
                                          )
                                        : null,
                                    borderRadius: 6,
                                    height: 40.rh(context),
                                    widget: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 260.rw(context),
                                          height: 35.rh(context),
                                          child: Uiutils.getTextWidget(
                                            context,
                                            item.msg,
                                            maxline: 1,
                                            overFlow: TextOverflow.fade,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          error: (error, stackTrace) {
                            return const SizedBox();
                          },
                          loading: () {
                            return const CupertinoActivityIndicator();
                          },
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
                                // ref
                                //     .read(chatListNotifierProvider.notifier)
                                //     .clearChats();
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
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: 0,
              right: 0,
              top: loadingProgressor ? 0 : -MediaQuery.of(context).size.height,
              bottom: loadingProgressor
                  ? 0
                  : MediaQuery.of(context).size.height,
              child: Container(
                color: context.mainDarkShadeColor.withValues(
                  alpha: .4,
                ), // FULL BACKGROUND
                child: Center(
                  child: Container(
                    width: 250, // SMALL BOX WIDTH
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: context.mainLightShadeColor.withValues(
                        alpha: .4,
                      ), // INSIDE BOX COLOR
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Uiutils.getLottie(
                          LottieConstant.chatScreen,
                          height: 60.rf(context),
                        ),
                        const SizedBox(height: 12),
                        Uiutils.getTextWidget(
                          context,
                          "Chat Data Is Fetching Wait Few Seconds",
                        ),
                        const SizedBox(height: 16),
                        const CupertinoActivityIndicator(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //!            ///attachment
            Positioned(
              left: 35.rw(context),
              bottom: 80.rh(context),
              child: Consumer(
                builder: (context, ref, child) {
                  const attachmentList = CoreConstants.listOfAttachment;
                  log('$attachmentState----------------attachment ');
                  return attachmentState
                      ? AnimatedContainer(
                          decoration: const BoxDecoration(),
                          // height: 100.rh(context),
                          // width: 300.rw(context),
                          duration: const Duration(microseconds: 300),
                          alignment: AlignmentGeometry.bottomLeft,
                          child: CustomButtonWIdget(
                            height: 125.rh(context),
                            borderRadius: 14.rf(context),
                            padding: 12.rf(context),
                            width: 190.rw(context),
                            bordercolor: context.greySecondColor,
                            color: context.secondaryColor.withValues(
                              alpha: .85,
                            ),
                            widget: Column(
                              spacing: 12.rh(context),
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(attachmentList.length, (
                                index,
                              ) {
                                final item = attachmentList[index];
                                return GestureDetector(
                                  onTap: () {
                                    index == 0
                                        ? ref
                                              .read(
                                                attachementNotifierProvider
                                                    .notifier,
                                              )
                                              .cameraImage()
                                        : index == 1
                                        ? ref
                                              .read(
                                                attachementNotifierProvider
                                                    .notifier,
                                              )
                                              .pickMultiImageGallery()
                                        : ref
                                              .read(
                                                attachementNotifierProvider
                                                    .notifier,
                                              )
                                              .pickDocument();
                                    ref
                                            .read(
                                              chatAttachmentProvider.notifier,
                                            )
                                            .state =
                                        false;
                                  },
                                  child: Row(
                                    spacing: 10.rh(context),
                                    children: [
                                      Icon(
                                        item.icon,
                                        color: context.primaryColor,
                                      ),
                                      Uiutils.getTextWidget(context, item.name),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage(
    WidgetRef ref,
    String text, {
    List<File>? files,
  }) async {
    final chat = Chatbubble(
      chatSetID: LocalStorageService.getString(LocalServiceKeys.CHAT_SET_ID),
      message: text,
      time: DateTime.now().toFormattedString(),
      attachment:
          files?.map((file) {
            final mimeType = Validators.fileTypeForLocal(file);
            return Attachment(
              path: file.path,
              type: mimeType,
              name: file.path.split('/').last,
            );
          }).toList() ??
          [],
      // attachment: [
      //   // AttachmentFile(
      //   //   path: imageFile!.path,
      //   //   type: 'image/jpeg',
      //   //   name:
      //   //       'chat_${DateTime.now().millisecondsSinceEpoch}.jpg', //supabaseUrl: supabase.storage.from('chat_attachments') .getPublicUrl(fileName);
      //   // ),
      // ],
      msgtype: MessegeOwner.user,
    );

    try {
      await ref.read(chatListNotifierProvider.notifier).addChat(chat);
      await ref.read(supabaseChatNotifierProvider.notifier).addChats(chat);
      // 1️⃣ Add user's message immediately
      ref.read(attachementNotifierProvider.notifier).clear();
      inputController.clear();

      // 2️⃣ Show loading state for AI reply
      ref.read(loadingmsgProvider.notifier).state = true;

      // 3️⃣ Get AI reply asynchronously
      await ref
          .read(aiMessgeNotifierProvider.notifier)
          .getAiReply(
            data: chat.message,
            files: chat.attachment!.isNotEmpty
                ? chat.attachment!.map((e) => File(e.path)).toList()
                : null,
          );

      // 4️⃣ Stop loading once AI reply is done
      ref.read(loadingmsgProvider.notifier).state = false;
    } catch (e) {
      log('Error while sending message: $e');
      ref.read(loadingmsgProvider.notifier).state = false;
    }
  }

  Widget _buildChatList(
    List<Chatbubble> chatlist,
    WidgetRef ref,
    BuildContext context,
  ) {
    final loadingAiMsg = ref.watch(loadingmsgProvider);
    log('$loadingAiMsg --------------fnvkhsgfksd---------------loading');
    // Combine messages and optional AI "thinking..." message
    // final totalCount =
    //     chatlist.length + (loadingAiMsg ? 1 : 0) + 1; // +1 for greeting section

    return Expanded(
      child: ListView.builder(
        reverse: true,
        padding: EdgeInsets.zero,
        itemCount: loadingAiMsg ? chatlist.length : chatlist.length + 1,
        itemBuilder: (context, index) {
          if (index == chatlist.length + (loadingAiMsg ? 1 : 0)) {
            // this is the last item in the builder
            final hour = DateTime.now().hour;
            return Padding(
              padding: EdgeInsets.all(28.rf(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RepaintBoundary(
                    child: Uiutils.getLottie(
                      LottieConstant.chatScreen,
                      height: 60.rh(context),
                      width: 80,
                    ),
                  ),
                  SizedBox(height: 10.rh(context)),
                  Uiutils.getTextWidget(
                    context,
                    hour < 12
                        ? "Good Morning ☀️"
                        : hour < 17
                        ? "Good Afternoon 🌤"
                        : "Good Evening 🌙",
                  ),
                  if (chatlist.isEmpty) ...[
                    Uiutils.getTextWidget(context, "How can I help you?"),
                    SizedBox(height: 15.rh(context)),
                  ],
                  Uiutils.getTextWidget(
                    context,
                    'Share your thoughts with us...',
                  ),
                ],
              ),
            );
          }

          final chat = chatlist[index];

          // 🟢 3️⃣ Show user bubble
          final bubble = CustomChatBubbleWidget(chat: chat);

          // 🟢 4️⃣ If this is the latest message AND AI is loading → show "Thinking..."
          final isLastUserMessage = index == 0 && loadingAiMsg;

          if (isLastUserMessage) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [bubble, const ThinkingWidget()],
            );
          } else {
            // 🟢 Default: just show the chat bubble
            return bubble;
          }
        },
      ),
    );
  }
}

class ThinkingWidget extends StatelessWidget {
  const ThinkingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.rw(context),
        right: 12.rw(context),
        bottom: 8.rh(context),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(10.rf(context)),
          decoration: BoxDecoration(
            color: context.dynamicColor4,
            borderRadius: BorderRadius.circular(15.rf(context)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.fourRotatingDots(
                color: context.buttnColor,
                size: 25.rf(context),
              ),
              SizedBox(width: 10.rw(context)),
              Uiutils.getTextWidget(context, "Thinking..."),
            ],
          ),
        ),
      ),
    );
  }
}
