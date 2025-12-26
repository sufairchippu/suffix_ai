import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/constants/image_constants.dart';
import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/connect_with_widget.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/provider/quiz_sccren_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/widgets/custom_button_widget.dart';
import '../widget/floating_action_item.dart';
import '../widget/home_screen_section_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final String? userrr = LocalStorageService.getString(
    //   LocalServiceKeys.USER_NAME,
    // );

    bool topic = true;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: CupertinoPageScaffold(
        child: Stack(
          children: [
            CustomScrollView(
              scrollBehavior: const ScrollBehavior(),
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 120.rh(context))),
                SliverToBoxAdapter(
                  child: Center(
                    child: Uiutils.getTextWidget(
                      context,
                      "Daily Tasks ,Complete Todays",
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15.rh(context),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 8.rw(context)),
                    // child: Divider(
                    //   thickness: 2.rf(context),
                    //   color: context.blue,
                    // ),
                  ),
                ),
                _buildDailyGrid(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.rh(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // spacing: 10.rh(context),
                      children: [
                        SizedBox(height: 5.rh(context)),

                        Uiutils.getTextWidget(
                          context,
                          'use thes to help youhh',
                        ),
                        SizedBox(height: 5.rh(context)),
                        HomeScreenSecotionWidget(
                          generateType: false,
                          ontap: () {
                            ref.read(paperTypeOptionProvider.notifier).state =
                                CoreConstants.qustionText[1];
                            ref.read(testYourKnwoldgeoption.notifier).state =
                                true;
                            context.pushNamed(
                              RouteNames.generate,
                              // extra: {'generateType': generateType},
                            );
                          },
                          text: 'test Your Knwoledge',
                        ),
                        SizedBox(height: 15.rh(context)),

                        HomeScreenSecotionWidget(
                          generateType: true,
                          ontap: () {
                            context.pushNamed(
                              RouteNames.generate,
                              // extra: {'generateType': generateType},
                            );
                          },
                          text: 'Generate Question Paper',
                        ),
                        SizedBox(height: 20.rh(context)),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.rh(context)),

                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.rf(context)),
                        boxShadow: [
                          BoxShadow(
                            color: context.greyFirstColor.withValues(alpha: .1),
                            offset: const Offset(0, 2),
                            // blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButtonWIdget(
                              onTap: () {
                                topic = true;
                              },

                              boxshadowColor: topic
                                  ? context.primaryColor.withValues(alpha: .9)
                                  : CupertinoColors.transparent,
                              titile: 'Topic',
                            ),
                          ),
                          SizedBox(width: 10.rw(context)),
                          Expanded(
                            child: CustomButtonWIdget(
                              onTap: () {
                                topic = false;
                              },

                              boxshadowColor: topic
                                  ? CupertinoColors.transparent
                                  : context.primaryColor.withValues(alpha: .9),
                              titile: 'Topic',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildLearnigSectionGrid(context),
              ],
            ),
            _buildAppBar(context),

            _buildFloatingbutton(context),
          ],
        ),
      ),
    );
  }

  Positioned _buildAppBar(BuildContext context) {
    return Positioned(
      // Add spacing from bottom
      left: 0,
      right: 0,
      child: ClipPath(
        clipper: CurvedBottomClipper(),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.rw(context),
            horizontal: 10.rh(context),
          ),
          color: context.primaryColor,

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 35.rf(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Uiutils.getTextWidget(
                  context,
                  'Hi,  \n${'Guest'}',
                  textStyle: TextStyleType.mediumBold,
                ),
                const AppLogoWidget(),

                GestureDetector(
                  onTap: () {
                    // context.pushNamed(RouteNames.login);
                    // imagePicker.pickImage(source: ImageSource.gallery);
                    context.pushNamed(RouteNames.camera);

                    ///change as camera setup
                  },

                  child: Icon(
                    CupertinoIcons.camera_viewfinder,
                    color: context.subTextColor,
                    size: 30.rf(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverGrid _buildDailyGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              CustomCircleImageWidget(
                boxColor: context.cardColor2,
                // height: 35,
                // width: 60,
                assetImage: ImageConstants.logo,
                onTap: () {
                  context.pushNamed(RouteNames.quiz);
                },
                icon: null,
              ),
              Uiutils.getTextWidget(context, 'Day ${index + 1}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Icon(
                    CupertinoIcons.star_lefthalf_fill,
                    size: 10.rf(context),
                    color: context.yellow.withValues(alpha: .9),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        childCount: 7, // number of items
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
    );
  }

  SliverPadding _buildLearnigSectionGrid(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(
        12.rw(context),
        20.rh(context),
        12.rw(context),
        60.rh(context),
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10.rh(context)),
            child: Container(
              margin: EdgeInsets.only(right: 10.rw(context)),
              padding: EdgeInsets.only(top: 12.rh(context)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.rf(context)),
                boxShadow: [
                  BoxShadow(
                    color: context.dynamicColor3,
                    blurRadius: 2.rf(context),
                    spreadRadius: 1.rf(context),
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Uiutils.getTextWidget(context, "Topic Name"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100.rh(context),
                      width: 80.rw(context),
                      child: Uiutils.getassetImage(ImageConstants.logo),
                    ),
                  ),
                  Uiutils.getTextWidget(context, '* hbdkjbhk'),
                  Uiutils.getTextWidget(context, '* hbdkjbhk'),
                  Uiutils.getTextWidget(context, '* hbdkjbhk'),
                ],
              ),
            ),
          );
        }, childCount: 5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .7,
          crossAxisSpacing: 10.rf(context),
          mainAxisSpacing: 20.rf(context), // vertical spacing between rows
          crossAxisCount: 2,
        ),
      ),
    );
  }

  Positioned _buildFloatingbutton(BuildContext context) {
    return Positioned(
      bottom: 26.rh(context), // Add spacing from bottom
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.rw(context)),
        child: Container(
          padding: EdgeInsets.only(
            left: 30.rw(context),
            right: 30.rw(context),
            top: 10.rh(context), // vertical: 12.rh(context),
          ),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(30.rf(context)),
            boxShadow: [
              BoxShadow(
                color: context.greyFirstColor.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionItem(
                icon: CupertinoIcons.chart_bar_circle,
                label: 'AI',
                onTap: () {
                  context.pushNamed(RouteNames.chat);
                },
              ),
              SizedBox(width: 40.rw(context)),
              // GestureDetector(
              //   onTap: () {
              //     // Main Center Button Action
              //   },
              //   child: Column(
              //     children: [
              //       Container(
              //         height: 40.rh(context),
              //         width: 40.rf(context),
              //         decoration: BoxDecoration(
              //           color: context.primaryColor,
              //           shape: BoxShape.circle,
              //           boxShadow: [
              //             BoxShadow(
              //               color: context.primaryColor.withValues(alpha: 0.3),
              //               blurRadius: 8,
              //               offset: const Offset(2, 4),
              //             ),
              //           ],
              //         ),
              //         child: const Icon(
              //           CupertinoIcons.smallcircle_circle_fill,
              //           color: CupertinoColors.white,
              //           size: 30,
              //         ),
              //       ),
              //       Uiutils.getTextWidget(context, ''),
              //     ],
              //   ),
              // ),
              FloatingActionItem(
                selected: true,
                icon: CupertinoIcons.home,
                label: "Home",
                onTap: () {
                  context.pushReplacementNamed(RouteNames.home);
                },
              ),
              SizedBox(width: 40.rw(context)),

              FloatingActionItem(
                icon: CupertinoIcons.wand_stars_inverse,
                label: "ImaGenrator",
                onTap: () {
                  context.pushNamed(RouteNames.nanoBanana);
                },
              ),
              SizedBox(width: 40.rw(context)),
              FloatingActionItem(
                icon: CupertinoIcons.settings_solid,
                label: 'Settings',
                onTap: () {
                  context.pushNamed(RouteNames.settings);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom clipper for curved bottom
class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
