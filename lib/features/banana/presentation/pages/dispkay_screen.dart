import 'package:clean_architutre_learn/core/constants/svg_constants.dart';
import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NanoDisplayScreen extends ConsumerStatefulWidget {
  const NanoDisplayScreen({super.key, required this.specificationsIndex});
  final int specificationsIndex;
  @override
  ConsumerState<NanoDisplayScreen> createState() => _NanoDisplayScreenState();
}

class _NanoDisplayScreenState extends ConsumerState<NanoDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    // late List<String> promtTitles = CoreConstants
    //     .listofnanBananaSelction[widget.specificationsIndex]
    //     .specifications;
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(CupertinoIcons.back),
                ),

                // Spacer(),
                AppLogoWidget(logoNeeded: false),
                // Spacer(),
                Column(
                  children: [
                    Uiutils.getSvg(
                      SvgConstants.save,
                      color: ColorFilter.mode(
                        context.buttnColor,
                        BlendMode.modulate,
                      ),
                    ),
                    Uiutils.getTextWidget(context, 'Store in'),
                  ],
                ),
              ],
            ),
            Container(
              height: 600.rh(context),
              width: double.infinity,
              child: Stack(children: [
            
              
            ],),
            ),
          ],
        ),
      ),
    );
  }
}
