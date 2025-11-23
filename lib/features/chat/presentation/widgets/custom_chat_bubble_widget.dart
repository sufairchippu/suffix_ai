import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/text/app_text.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../business/entities/chat_bubble.dart';
import '../provider/chat_provider.dart';
import '../provider/tts_provider.dart';
import 'chat_bubble_painter.dart';

///needed to ontap navigate new screen copy the output specfically
class CustomChatBubbleWidget extends ConsumerStatefulWidget {
  const CustomChatBubbleWidget({super.key, required this.chat, this.maxline});

  final Chatbubble chat;

  final int? maxline;

  @override
  ConsumerState<CustomChatBubbleWidget> createState() =>
      _CustomChatBubbleWidgetState();
}

class _CustomChatBubbleWidgetState
    extends ConsumerState<CustomChatBubbleWidget> {
  @override
  Widget build(BuildContext context) {
    Widget buildAttachmentPreview(Attachment attachment) {
      if (attachment.type == 'image') {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Uiutils.getNetworkImage(
            attachment.path,
            height: 150,
            width: 150,
            // fit: BoxFit.cover,
          ),
        );
      } else {
        // Document preview
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey5,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.doc_fill, color: context.primaryColor),
              SizedBox(width: 8),
              Uiutils.getNetworkImage(
                attachment.name ?? '',
                // style: TextStyle(color: context.textColor),
                // overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }
    }

    return Row(
      mainAxisAlignment: widget.chat.msgtype == MessegeOwner.user
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: double.infinity,
            maxWidth: widget.chat.msgtype == MessegeOwner.user
                ? MediaQuery.of(context).size.width * 0.65
                : MediaQuery.of(context).size.width * 0.80,
          ),
          child: Column(
            crossAxisAlignment: widget.chat.msgtype == MessegeOwner.user
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (widget.chat.attachment != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.rh(context)),
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.chat.attachment!.length,
                      itemBuilder: (context, index) {
                        final attachmentItem = widget.chat.attachment![index];
                        return buildAttachmentPreview(attachmentItem);
                      },
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  8.rh(context),
                  10.rh(context),
                  0,
                  0,
                ),
                child: CustomPaint(
                  painter: ChatBubblePainter(
                    color: widget.chat.msgtype == MessegeOwner.user
                        ? context.secondaryColor
                        : context.primaryColor,
                    isSender: widget.chat.msgtype == MessegeOwner.user,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(14.rf(context)),
                    child: widget.chat.msgtype == MessegeOwner.user
                        ? Column(
                            children: [
                              Uiutils.getTextWidget(
                                context,
                                widget.chat.message,
                                color: context.textColor,
                              ),

                              if (widget.chat.message.length > 100) ...[
                                SizedBox(height: 6.rh(context)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(chatReadMoreProvider.notifier)
                                            .state = !ref
                                            .read(chatReadMoreProvider.notifier)
                                            .state;
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 4.rh(context),
                                        ),
                                        child: Uiutils.getTextWidget(
                                          context,
                                          ref.watch(chatReadMoreProvider)
                                              ? 'readLess'
                                              : 'readMore',
                                          color: context.cardColor2,
                                          textStyle:
                                              TextStyleType.extraSmallBold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Uiutils.getTextWidget(
                                    context,
                                    "Suffix Ai",
                                    textStyle: TextStyleType.extraSmallBold,
                                    color: context.buttnColor,
                                  ),
                                  const Spacer(), //remove below one
                                  // widget.loadingAiMsg
                                  //     ? LoadingAnimationWidget.staggeredDotsWave(
                                  //         color: context.subTextColor,
                                  //         size: 20.rf(context),
                                  //       )
                                  //     : const SizedBox(),
                                ],
                              ),
                              Uiutils.getTextWidget(
                                maxline: ref.watch(chatReadMoreProvider)
                                    ? null
                                    : widget.maxline ?? 6,
                                overFlow: ref.watch(chatReadMoreProvider)
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                                context,
                                widget.chat.message,
                                // color: context.cardColor3,
                              ),
                              if (widget.chat.message.length > 100)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(chatReadMoreProvider.notifier)
                                            .state = !ref
                                            .read(chatReadMoreProvider.notifier)
                                            .state;
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 4.rh(context),
                                        ),
                                        child: Uiutils.getTextWidget(
                                          context,
                                          ref.watch(chatReadMoreProvider)
                                              ? 'readLess'
                                              : 'readMore',
                                          color: context.cardColor2,
                                          textStyle:
                                              TextStyleType.extraSmallBold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              /// Show Read More / Read Less only if needed
                              // conditionally show
                            ],
                          ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: //widget.chat.msgtype == MessegeOwner.ai?
                    MainAxisAlignment.end,
                // : MainAxisAlignment.start,
                children: [
                  if (widget.chat.msgtype == MessegeOwner.ai) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.rw(context)),
                      child: Uiutils.getTextWidget(
                        context,
                        Uiutils.timeAgo(
                          Uiutils.parseBackendDate(widget.chat.time),
                        ),
                        textStyle: TextStyleType.extraSmallsemiBold,
                      ),
                    ),
                    Spacer(),
                  ],
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 19.rw(context),
                      vertical: 3.rh(context),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        final ttsState = ref.read(ttsProvider);
                        final tts = ref.read(ttsProvider.notifier);

                        if (ttsState == TtsState.playing) {
                          tts.stop();
                        } else {
                          tts.speak(widget.chat.message);
                        }
                        //if its playing stop
                        //if not playing play it
                        // _speak(widget.chat.message);
                      },
                      child: Icon(
                        CupertinoIcons.mic_fill,
                        color: context.cardColor2,
                        size: 18.rf(context),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(text: widget.chat.message),
                      );
                    },
                    child: Icon(
                      CupertinoIcons.doc_on_doc,
                      color: context.cardColor2,
                      size: 15.rf(context),
                    ),
                  ),
                ],
              ),
              if (widget.chat.msgtype == MessegeOwner.user) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.rw(context)),
                  child: Uiutils.getTextWidget(
                    context,
                    Uiutils.timeAgo(Uiutils.parseBackendDate(widget.chat.time)),
                    textStyle: TextStyleType.extraSmallsemiBold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
