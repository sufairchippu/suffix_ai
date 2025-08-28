
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/ui_utils.dart';
import '../../../authentication/presentation/widget/connect_with_widget.dart';

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
            offset: const Offset(0, 3), // X and Y offset
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
          const Spacer(),
          const Icon(CupertinoIcons.right_chevron),
          SizedBox(width: 9.rw(context)),
        ],
      ),
    );
  }
}
