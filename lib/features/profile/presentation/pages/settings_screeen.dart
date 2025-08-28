import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/theme/theme_notifier.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/connect_with_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreeen extends ConsumerStatefulWidget {
  const SettingsScreeen({super.key});

  @override
  ConsumerState<SettingsScreeen> createState() => _SettingsScreeenState();
}

class _SettingsScreeenState extends ConsumerState<SettingsScreeen> {
  @override
  Widget build(BuildContext context) {
    final thememode = ref.watch(themeProvider);
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.rw(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(
                  CupertinoIcons.xmark_circle,
                  size: 26.rf(context),
                  color: context.mainDarkShadeColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  AppLogoWidget(logoheit: 150.rf(context)),
                  const SizedBox(),
                ],
              ),
              SizedBox(height: 20.rh(context)),

              CustomButtonWIdget(
                onTap: () {
                  context.pushNamed(RouteNames.profile);
                },
                height: 79.rh(context),
                color: context.blue.withAlpha(220),
                widget: Row(
                  children: [
                    SizedBox(width: 10.rw(context)),
                    CustomCircleImageWidget(
                      onTap: () {},
                      icon: null,
                      height: 120,
                      boxColor: context.shimmerHighlightColor,
                    ),
                    SizedBox(width: 10.rw(context)),
                    Uiutils.getTextWidget(
                      context,
                      'Username ', //not login plz login condition
                      textStyle: TextStyleType.mediumBold,
                      color: context.dynamicColor4,
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.chevron_right,
                      color: context.cardColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.rh(context)),
              SettingsSectionWidget(
                thememode: thememode,
                text: 'Theme',
                icon: thememode.brightness == Brightness.light
                    ? CupertinoIcons.sun_max
                    : CupertinoIcons.moon,
                iconcolor: context.primaryColor,
                onTap: () {},
              ),
              SizedBox(height: 20.rh(context)),
              SettingsSectionWidget(
                thememode: thememode,
                text: 'Terms & Conditions',
                icon: CupertinoIcons.info_circle_fill,
                iconcolor: context.primaryColor,
                onTap: () {},
              ),

              SizedBox(height: 20.rh(context)),
              SettingsSectionWidget(
                thememode: thememode,
                text: 'Logout',
                icon: CupertinoIcons.square_arrow_right,
                iconcolor: context.red,
                onTap: () {
                  Uiutils.showAlert(
                    context,
                    () {},
                    'Logout',
                    'Are You Sure to Logout',
                    true,
                    'Logout',
                    context.red,
                  );
                },
              ),

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLogoWidget(logoNeeded: false, textSize: 14.rf(context)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({
    super.key,
    required this.thememode,
    required this.text,
    required this.onTap,
    required this.icon,
    this.iconcolor,
  });

  final CupertinoThemeData thememode;
  final String text;
  final void Function()? onTap;
  final IconData icon;
  final Color? iconcolor;

  @override
  Widget build(BuildContext context) {
    return CustomButtonWIdget(
      borderRadius: 10,
      onTap: onTap,
      padding: 20,
      height: 59.rh(context),
      color: context.dynamicColor2.withValues(alpha: .1),
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Uiutils.getTextWidget(context, text),
          Icon(icon, color: iconcolor),
        ],
      ),
    );
  }
}
