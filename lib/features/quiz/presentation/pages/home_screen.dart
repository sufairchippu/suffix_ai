import 'package:clean_architutre_learn/core/constants/image_constants.dart';
import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/connect_with_widget.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/pages/camera_result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/widgets/custom_button_widget.dart';
import '../provider/home_screen_provider.dart';
import '../widget/floating_action_item.dart';
import '../widget/home_screen_section_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final imagePicker = ImagePicker();
  late XFile _file;

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
        child: SafeArea(
          maintainBottomViewPadding: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.rf(context)),
                child: CustomScrollView(
                  slivers: [
                    _buildAppBar(context),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.rh(context)),
                        child: Center(
                          child: Uiutils.getTextWidget(
                            context,
                            "Daily Tasks ,Complete Todays",
                          ),
                        ),
                      ),
                    ),
                    _buildDailyGrid(),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.rh(context),
                        children: [
                          Uiutils.getTextWidget(
                            context,
                            'use thes to help youhh',
                          ),
                          const HomeScreenSecotionWidget(
                            text: 'test Your Knwoledge',
                          ),

                          const HomeScreenSecotionWidget(
                            text: 'Generate Question Paper',
                          ),
                          SizedBox(height: 12.rh(context)),
                        ],
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.rf(context)),
                          boxShadow: [
                            BoxShadow(
                              color: context.greyFirstColor.withValues(
                                alpha: .1,
                              ),
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
                                    : context.primaryColor.withValues(
                                        alpha: .9,
                                      ),
                                titile: 'Topic',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildLearnigSectionGrid(context),
                  ],
                ),
              ),
              _buildFloatingbutton(context),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAppBar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.rf(context)),
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
                color: context.primaryColor,
                size: 30.rf(context),
              ),
            ),
          ],
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

  SliverGrid _buildLearnigSectionGrid(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 22.rh(context)),
          child: Container(
            margin: EdgeInsetsGeometry.only(right: 10.rw(context)),
            padding: EdgeInsets.only(top: 12.rh(context)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.rf(context)),
              boxShadow: [
                BoxShadow(
                  color: context.dynamicColor3,
                  blurRadius: 2.rf(context),
                  spreadRadius: 1.rf(context),
                  offset: const Offset(2, 4), // soft bottom shadow
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
        mainAxisSpacing: 20.rf(context),
        crossAxisCount: 2,
      ),
    );
  }

  Positioned _buildFloatingbutton(BuildContext context) {
    return Positioned(
      bottom: 0, // Add spacing from bottom
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
              GestureDetector(
                onTap: () {
                  // Main Center Button Action
                },
                child: Column(
                  children: [
                    Container(
                      height: 40.rh(context),
                      width: 40.rf(context),
                      decoration: BoxDecoration(
                        color: context.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: context.primaryColor.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        CupertinoIcons.smallcircle_circle_fill,
                        color: CupertinoColors.white,
                        size: 30,
                      ),
                    ),
                    Uiutils.getTextWidget(context, ''),
                  ],
                ),
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
