import 'dart:io';

import 'package:clean_architutre_learn/core/constants/lottie_constant.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/features/chat/presentation/pages/chat_screen.dart';
import 'package:clean_architutre_learn/features/chat/presentation/provider/ai_provider.dart';
import 'package:clean_architutre_learn/features/chat/presentation/provider/chat_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/extenstion.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/presentation/widgets/custom_chat_bubble_widget.dart';

import '../provider/home_screen_provider.dart';

class CameraResultScreen extends ConsumerStatefulWidget {
  const CameraResultScreen({super.key});

  @override
  ConsumerState<CameraResultScreen> createState() => _CameraResultScreenState();
}

class _CameraResultScreenState extends ConsumerState<CameraResultScreen> {
  @override
  void initState() {
    requestCameraAndStorage();
    super.initState();
  }

  Future<bool> requestCameraAndStorage() async {
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.photos.request();
    return cameraStatus.isGranted && storageStatus.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    // final cameraState = ref.watch(cameraControllerProvider);
    // final imageState = ref.watch(imageStateProvider);
    // final imageNotifier = ref.read(imageStateProvider.notifier);
    final imageState = ref.watch(imagePickerNotifierProvider);
    final asyncChats = ref.watch(chatListNotifierProvider);

    final imageStateNotifier = ref.read(imagePickerNotifierProvider.notifier);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        ref.read(chatListNotifierProvider.notifier).clearChats();
        ref.read(imagePickerNotifierProvider.notifier).clear();
      },
      child: CupertinoPageScaffold(
        child: Padding(
          padding: EdgeInsets.all(18.rf(context)),
          child: CustomScrollView(
            slivers: [
              /// Sticky top widget (like SliverAppBar)
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverHeaderDelegate(
                  minHeight: 180.rh(context),
                  maxHeight: 500.rh(context),

                  child: Consumer(
                    builder: (context, ref, child) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              imageState.value == null
                                  ? imageStateNotifier.pick(ImageSource.camera)
                                  : Uiutils.showAlert(
                                      context,
                                      () {
                                        imageStateNotifier.pick(
                                          ImageSource.camera,
                                        );
                                      },
                                      "Camera",
                                      " Are youh sure to change \nthe Picked image ",
                                      true,
                                      'Open Camera',
                                      context.red,
                                    );
                            },
                            child: Consumer(
                              builder: (context, ref, child) {
                                return imageState.when(
                                  data: (file) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: file != null
                                              ? FileImage(File(file.path))
                                              : const AssetImage(
                                                      'assets/images/no_imagee.avif',
                                                    )
                                                    as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  loading: () => const Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                  error: (e, st) => Center(
                                    child: Uiutils.getTextWidget(
                                      context,
                                      "Error loading image: $e",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 28.rh(context),
                            right: 20.rw(context),
                            child: Consumer(
                              builder: (context, ref, child) {
                                final imageState = ref.watch(
                                  imagePickerNotifierProvider,
                                );

                                return imageState.value != null
                                    ? GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(
                                                imagePickerNotifierProvider
                                                    .notifier,
                                              )
                                              .clear();
                                        },
                                        child: Icon(
                                          size: 27.rf(context),
                                          CupertinoIcons.xmark_circle,
                                          color: context.primaryColor,
                                        ),
                                      )
                                    : const SizedBox();
                              },
                            ),
                          ),
                          Positioned(
                            top: 28.rh(context),
                            left: 20.rw(context),
                            child: GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: Icon(
                                size: 27.rf(context),
                                CupertinoIcons.chevron_left,
                                fontWeight: FontWeight.bold,
                                color: context.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              /// Remaining scrollable content
              SliverList(
                delegate: SliverChildListDelegate([
                  CustomButtonWIdget(
                    top: 12.rh(context),
                    onTap: () {
                      imageStateNotifier.pick(ImageSource.gallery);
                    },
                    widget: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.rh(context),
                        vertical: 3.rh(context),
                      ),
                      decoration: BoxDecoration(
                        color: context.primaryColor,
                        border: Border.all(
                          width: 1.rf(context),
                          color: context.mainDarkShadeColor.withAlpha(80),
                        ),
                        borderRadius: BorderRadius.circular(10.rf(context)),
                      ),
                      child: Uiutils.getTextWidget(
                        context,
                        'From Gallery 📂',
                        textStyle: TextStyleType.mediumBold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.rh(context)),

                  CustomButtonWIdget(
                    onTap: () {
                      if (imageState.valueOrNull != null) {
                        ref
                            .read(aiMessgeNotifierProvider.notifier)
                            .getAiReply(
                              data: '',
                              imageFile: File(imageState.valueOrNull!.path),
                            );
                      }
                    },
                    height: 40.rh(context),
                    titile: 'Give me the Answers', //give conditions
                    textColor: context.cardColor,
                    textStyle: TextStyleType.mediumBold,
                    color: context.cardColor3,
                  ),
                  SizedBox(height: 25.rh(context)),

                  // for (int i = 0; i < 20; i++) ...[
                  //   Container(
                  //     padding: const EdgeInsets.all(12),
                  //     margin: const EdgeInsets.symmetric(
                  //         vertical: 6, horizontal: 12),
                  //     decoration: BoxDecoration(
                  //       color: CupertinoColors.systemGrey5,
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: Text("Chat message $i"),
                  //   )
                  // ]
                  Consumer(
                    builder: (context, ref, child) {
                      final isloading = ref.watch(loadingmsgProvider);
                      return asyncChats.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(height: 100.rh(context)),
                                Uiutils.getTextWidget(
                                  context,
                                  'Gave the Image and get the answer',
                                ),
                              ],
                            );
                          }
                          final reply = data.last;
                          if (isloading) {
                            return ThinkingWidget();
                          }

                          return GestureDetector(
                            onLongPress: () {
                              // Uiutils.showAlert(context, () {

                              // }, 'titile', 'discription', true, 'conformText',context.textColor);
                            },
                            child: CustomChatBubbleWidget(
                              maxline: 10,
                              chat: Chatbubble(
                                chatSetID: reply.chatSetID,
                                message: reply.message,
                                time: reply.time,
                                msgtype: reply.msgtype,
                              ),
                              // loadingAiMsg: false,
                            ),
                          );
                        },
                        error: (error, stackTrace) => Column(
                          children: [
                            Uiutils.getLottie(LottieConstant.chatScreen),
                            Uiutils.getTextWidget(
                              context,
                              'Something Went Wrong',
                            ),
                          ],
                        ),
                        loading: () =>
                            Center(child: CupertinoActivityIndicator()),
                      );
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Helper delegate for sticky header
class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
