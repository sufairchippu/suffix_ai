import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_color.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CustomSegemtWidget extends ConsumerWidget {
  const CustomSegemtWidget({
    this.height,
    this.width,
    super.key,
    required this.segmentProvider,
    required this.listOfData,
    this.titile,
    this.proportionalWidth = true,
  });
  // int? selectedValue;
  final String? titile;
  final List<dynamic> listOfData;
  final StateProvider<int> segmentProvider;
  final bool proportionalWidth;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedValue = ref.watch(segmentProvider);
    return Column(
      spacing: 6.rh(context),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Uiutils.getTextWidget(
          context,
          titile ?? '',
          textStyle: TextStyleType.mediumBold,
          color: context.mainLightShadeColor,
        ),
        CupertinoSlidingSegmentedControl<int>(
          proportionalWidth: proportionalWidth,
          groupValue: selectedValue,
          thumbColor: AppColors.dynamicColor3,
          onValueChanged: (value) {
            // setState(() {
            // print('>>>>>>>>>>>>>>>>>>>>>>>> $provideValueNotifer');
            if (value != null) {
              ref.read(segmentProvider.notifier).state = value;
            }
            // });
          },
          children: {
            for (int i = 0; i < listOfData.length; i++)
              i: CustomButtonWIdget(
                padding: 0.rh(context),
                titile: listOfData[i],
                textStyle: selectedValue == i
                    ? TextStyleType.smallBold
                    : TextStyleType.smallRegular,
                height: height ?? 15.rh(context),
                width: width ?? 110.rw(context),
              ),
          },
        ),
        SizedBox(height: 10.rh(context),)
      ],
    );
  }
}
