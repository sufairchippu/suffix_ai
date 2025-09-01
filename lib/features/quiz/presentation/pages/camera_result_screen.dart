import 'dart:io';

import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
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

// class CameraResultScreen extends ConsumerStatefulWidget {
//   const CameraResultScreen({super.key});

//   @override
//   ConsumerState<CameraResultScreen> createState() => _CameraResultScreenState();
// }

// class _CameraResultScreenState extends ConsumerState<CameraResultScreen> {
//   @override
//   void initState() {
//     requestCameraAndStorage();
//     super.initState();
//   }

//   Future<bool> requestCameraAndStorage() async {
//     final cameraStatus = await Permission.camera.request();
//     final storageStatus = await Permission.photos.request();
//     return cameraStatus.isGranted && storageStatus.isGranted;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       child: CustomScrollView(
//         slivers: [
//           /// Top Camera Preview (like SliverAppBar)
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 29.rw(context),
//                 vertical: 20.rh(context),
//               ),
//               child: Center(
//                 child: Container(
//                   height: 257.rh(context),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16.rf(context)),
//                     boxShadow: [
//                       BoxShadow(
//                         blurStyle: BlurStyle.inner,
//                         color: context.greySecondColor,
//                       ),
//                     ],
//                     image: const DecorationImage(
//                       image: AssetImage('assets/images/no_imagee.avif'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           /// Remaining scrollable content
//           SliverPadding(
//             padding: EdgeInsets.symmetric(horizontal: 29.rw(context)),
//             sliver: SliverList(
//               delegate: SliverChildListDelegate(
//                 [
//                   CustomButtonWIdget(
//                     widget: Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 12.rh(context),
//                         vertical: 3.rh(context),
//                       ),
//                       decoration: BoxDecoration(
//                         color: context.primaryColor,
//                         border: Border.all(
//                           width: 1.rf(context),
//                           color: context.mainDarkShadeColor.withAlpha(80),
//                         ),
//                         borderRadius: BorderRadius.circular(10.rf(context)),
//                       ),
//                       child: Uiutils.getTextWidget(
//                         context,
//                         'From Gallery 📂',
//                         textStyle: TextStyleType.mediumBold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16.rh(context)),

//                   CustomButtonWIdget(
//                     height: 40.rh(context),
//                     titile: 'Give me the Answers',
//                     textColor: context.cardColor,
//                     textStyle: TextStyleType.mediumBold,
//                     color: context.primarySecondColor.withValues(alpha: .5),
//                   ),
//                   SizedBox(height: 25.rh(context)),

//                   /// Chat bubbles (scrollable with list)
//                   CustomChatBubbleWidget(
//                     maxline: 10,
//                     chat: Chatbubble(
//                       message: '''messagekhhj lnlkh
//                       jkhbjkl
//                       ''',
//                       time: DateTime.now().toFormattedString(),
//                       msgtype: MessegeOwner.ai,
//                     ),
//                     loadingAiMsg: false,
//                   ),
//                   SizedBox(height: 100.rh(context)),

//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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

    final imageStateNotifier = ref.read(imagePickerNotifierProvider.notifier);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {},
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
                      final imageState = ref.watch(imagePickerNotifierProvider);
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
                  GestureDetector(
                    onLongPress: () {
                      // Uiutils.showAlert(context, () {

                      // }, 'titile', 'discription', true, 'conformText',context.textColor);
                    },
                    child: CustomChatBubbleWidget(
                      maxline: 10,
                      chat: Chatbubble(
                        message: '''messagekhhj lnlkh
                      jkhbjkl
                      38,546 views  10 Aug 2021  #Flutter #Tutorial #JohannesMilke
                 Create an image picker from camera and gallery in Flutter. Pick Images, Mutiple Images and Videos from the device camera and image gallery in Flutter.
                Click here to Subscribe to Johannes Milke: https://www.youtube.com/JohannesMilke...
                
                Need an App or Website?
                👉Book a call now:  https://bit.ly/42OGCga
                
                Source Code | https://github.com/JohannesMilke/imag...
                My Courses | https://heyflutter.com
                Follow Newsletter | https://johannesmilke.com/#/newsletter  
                
                SUBSCRIBE HERE
                http://bit.ly/JohannesMilke
                
                SUPPORT & SPONSOR ME
                https://github.com/sponsors/JohannesM...
                
                RESOURCES
                User Profile Page Tutorial: (Image Widget)    • Flutter Tutorial - User Profile Page UI [2...  
                Crop & Save Image Tutorial:    • Flutter Tutorial - ImageCropper - Pick & C...  
                Upload File To Firebase Storage Tutorial:    • Flutter Tutorial - Upload Files To Firebas...  
                Share Texts, Images, Files Tutorial:    • Flutter Tutorial - Share Texts, Images & F...  
                Image Slider Tutorial:    • Flutter Tutorial - Build A Simple Image Sl...  
                Take Screenshots Of Screen Tutorial:    • Flutter Tutorial - Take Screenshot Of Scre...  
                Download File From Firebase Storage Tutorial:    • Flutter Tutorial - Download Files From Fir...  
                Settings Page UI Tutorial:    • Flutter Tutorial - App Settings Page UI | ...  
                SVG Images Tutorial:    • Flutter Tutorial - How To Add SVG Image Fi...  
                Set Screen Background Image Tutorial:    • Flutter Tutorial - Set Screen Background I...  
                Cached Network Image Tutorial:    • Flutter Tutorial - Cached Network Image: D...  
                Compress Video Tutorial:    • Flutter Tutorial - Compress Video & Reduce...  
                Video Player Tutorial:    • Flutter Tutorial - Video Player - Asset, F...  
                Drop Files Into Dropzone Tutorial:    • Flutter Tutorial - Drag And Drop File Uplo...  
                      
                TIMELINE
                0:00 Introduction Image Picker From Camera & Gallery
                0:31 Pick Image From Camera And Gallery
                2:34 Preview & Set User Profile Image Avatar
                3:20 Improve Image Picker Camera And Gallery
                3:54 Setup Image Picker For Android & iOS
                5:06 Add Picker Buttons To Modal Bottom Sheet Popup
                6:15 Pick Images, Videos, Multi Images
                6:36 Pick And Safe Image Permanently In Local Storage
                
                
                SHARE | SUBSCRIBE | LIKE FOR MORE VIDEOS LIKE THIS
                
                *********
                
                SOCIAL MEDIA: Follow Us  :-)
                Twitter |   / heyflutter_  
                Linkedin |   / heyflutter  
                
                LEARN MORE
                SOURCE CODE | https://github.com/JohannesMilke
                ARTICLES |   / johannesmilke  
                
                PLAYLISTS 
                All Flutter Videos |    • Flutter Tutorial - Flutter Story App (Stor...  
                Widgets - Flutter |    • Flutter Tutorial - Flutter Wrap  
                Plugins - Flutter |    • Flutter Tutorial - Flutter Story App (Stor...  
                Animations - Flutter |    • Flutter Tutorial - Transition Animation - ...  
                Designs - Flutter |    • Flutter Tutorial - FlutterUI - Minimal Des...  
                Firebase - Flutter |    • Flutter Tutorial - Pagination & Infinite S...  
                State Management - Flutter |    • Flutter Tutorial - Riverpod - 1/3 The Comp...  
                
                CREDITS
                Copyright song "Corporate Technology" by scottholmesmusic.com
                
                #Flutter #Tutorial #JohannesMilke
                
                LIKE & SHARE & ACTIVATE THE BELL
                Thanks For Watching :-)
                http://bit.ly/JohannesMilke
                Chapters
                
                View all
                
                      ''',
                        time: DateTime.now().toFormattedString(),
                        msgtype: MessegeOwner.ai,
                      ),
                      loadingAiMsg: false,
                    ),
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
