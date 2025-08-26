import 'package:clean_architutre_learn/core/constants/image_constants.dart';
import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_keys.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_storage_service.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/connect_with_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final String? userrr = LocalStorageService.getString(
      LocalServiceKeys.USER_NAME,
    );
    final bool topic = true;
    return CupertinoPageScaffold(
      // navigationBar: const CupertinoNavigationBar(
      //   middle: Text('Home'),
      //   automaticallyImplyLeading: false,
      //   leading: Text('Hi,  \n${'Guest'}'),//    Uiutils.getTextWidget(context, 'Hi,  \n${'Guest'}'),
      // ),
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.rf(context)),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.rf(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Uiutils.getTextWidget(
                        context,
                        'Hi,  \n${'Guest'}',
                        textStyle: TextStyleType.mediumBold,
                      ),

                      // Uiutils.getTextWidg
                      AppLogoWidget(),

                      GestureDetector(
                        onTap: () {
                          context.pushNamed(RouteNames.login);
                        },
                        // onTap: () {
                        //   context.pushNamed(RouteNames.chat);
                        // },
                        child: Icon(
                          CupertinoIcons.camera_viewfinder,
                          color: context.primaryColor,
                          size: 30.rf(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.rh(context)),
                  child: Uiutils.getTextWidget(context, "Daily Tasks "),
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Column(
                      children: [
                        CustomCircleImageWidget(
                          boxColor: context.cardColor2,
                          // height: 35,
                          // width: 60,
                          assetImage: ImageConstants.logo,
                          onTap: () {},
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
                        SizedBox(height: 10),
                      ],
                    );
                  },
                  childCount: 7, // number of items
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.rf(context)),
                  child: Row(
                    children: [
                      Uiutils.getTextWidget(context, 'Complete Todays'),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  spacing: 10.rh(context),
                  children: [
                    HomeScreenSecotionWidget(text: 'test Your Knwoledge'),

                    HomeScreenSecotionWidget(text: 'Generate Question Paper'),
                    SizedBox(height: 12.rh(context)),
                  ],
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Row(
              //     children: [
              //       Expanded(
              //         flex: 1,
              //         child: HomeScreenSecotionWidget(text: 'Topics '),
              //       ),
              //       Expanded(
              //         flex: 1,
              //         child: Row(
              //           children: [
              //             HomeScreenSecotionWidget(text: 'Standerds '),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SliverToBoxAdapter(
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
                        child: Container(
                          height: 49.rh(context),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: topic
                                    ? context.primaryColor.withValues(alpha: .9)
                                    : CupertinoColors.transparent,

                                offset: const Offset(0, 2),
                                // blurRadius: 4,
                                spreadRadius: 0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(24.rf(context)),
                          ),

                          child: Center(
                            child: Uiutils.getTextWidget(
                              context,
                              "Topic",
                              color: context.subTextColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.rw(context)),
                      Expanded(
                        child: Container(
                          height: 49.rh(context),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: topic
                                    ? CupertinoColors.transparent
                                    : context.primaryColor.withValues(
                                        alpha: .9,
                                      ),
                                offset: const Offset(0, 2),
                                // blurRadius: 4,
                                spreadRadius: 0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(24.rf(context)),
                          ),
                          child: Center(
                            child: Uiutils.getTextWidget(
                              context,
                              "Division",
                              color: context.subTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverGrid(
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
                            offset: Offset(2, 4), // soft bottom shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Uiutils.getTextWidget(context, "Topic Name"),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100.rh(context),
                              width: 80.rw(context),
                              child: Uiutils.getassetImage('assetName'),
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
              ),

              // SliverGrid(delegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) ,),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenSecotionWidget extends StatelessWidget {
  const HomeScreenSecotionWidget({
    super.key,
    required this.text,
    this.firstLetter,
    this.pathIcon,
    this.icon,
  });
  final String text;
  final String? firstLetter;
  final String? pathIcon;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.rf(context)),
        boxShadow: [
          BoxShadow(
            color: context.blue.withValues(alpha: 0.14), // Shadow color
            blurRadius: .7, // How soft the shadow is
            // How far it spreads
            offset: Offset(0, 3), // X and Y offset
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.rf(context)),
            child: CustomCircleImageWidget(
              onTap: () {},
              icon: null,
              firstLetter: 'g',
              height: 40,
              boxColor: context.cardColor,
            ),
          ),
          Uiutils.getTextWidget(context, text),
          Spacer(),
          Icon(CupertinoIcons.right_chevron),
          SizedBox(width: 9.rw(context)),
        ],
      ),
    );
  }
}
