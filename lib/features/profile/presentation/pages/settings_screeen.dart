import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/connect_with_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreeen extends ConsumerStatefulWidget {
  const SettingsScreeen({super.key});

  @override
  ConsumerState<SettingsScreeen> createState() => _SettingsScreeenState();
}

class _SettingsScreeenState extends ConsumerState<SettingsScreeen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.rw(context)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [AppLogoWidget(logoheit: 90.rf(context))],
              ),
              SizedBox(height: 20.rh(context)),

              Row(
                children: [
                  CustomCircleImageWidget(onTap: () {}, icon: null,),
                  SizedBox(width: 10.rw(context)),
                  Uiutils.getTextWidget(
                    context,
                    'Username', //not login plz login condition
                    textStyle: TextStyleType.mediumRegular,
                  ),
                  Spacer(),
                  Icon(CupertinoIcons.chevron_right),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
