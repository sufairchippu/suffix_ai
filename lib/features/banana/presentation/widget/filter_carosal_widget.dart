import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/core/service/network/dio/image_genrate_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomFilterSelectorWidget extends ConsumerStatefulWidget {
  final List<String> items;
  final Widget? firstItem;
  final Function(int index)? onChanged;

  const CustomFilterSelectorWidget({
    super.key,
    required this.items,
    this.firstItem,
    this.onChanged,
  });

  @override
  ConsumerState<CustomFilterSelectorWidget> createState() =>
      _CustomFilterSelectorWidgetState();
}

class _CustomFilterSelectorWidgetState
    extends ConsumerState<CustomFilterSelectorWidget> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 0.25);
  }

  @override
  Widget build(BuildContext context) {
    int selected = ref.watch(filterNumberNano);

    return PageView.builder(
      controller: controller,
      scrollDirection: Axis.horizontal,
      itemCount: widget.items.length + 1,
      onPageChanged: (i) {
        ref.read(filterNumberNano.notifier).state = i; //=selected ;
        widget.onChanged?.call(i);
      },
      itemBuilder: (context, index) {
        final isSelected = selected == index;
        final scale = isSelected ? .95 : 0.85;

        // FIRST item (custom widget)
        if (index == 0) {
          return Center(
            child: GestureDetector(
              onTap: () => controller.animateToPage(
                0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
              ),
              child: Transform.scale(
                scale: scale,
                child:
                    widget.firstItem ??
                    Container(
                      height: 60.rh(context),
                      width: 60.rw(context),
                      decoration: BoxDecoration(
                        color: context.borderColor,
                        shape: BoxShape.circle,
                      ),
                    ),
              ),
            ),
          );
        }

        // NORMAL ITEMS
        final itemText = widget.items[index - 1];

        return GestureDetector(
          onTap: () => controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          ),
          child: Transform.scale(
            scale: scale,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: isSelected ? 75.rh(context) : 65.rw(context),
                  width: isSelected ? 70.rw(context) : 60.rw(context),
                  decoration: BoxDecoration(
                    color: context.greySecondColor,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(
                            color: context.mainLightShadeColor,
                            width: 3.rf(context),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 90.rh(context),
                  // height: 0,
                  child: Uiutils.getTextWidget(
                    context,
                    itemText,
                    textAlign: TextAlign.center,
                    textStyle: TextStyleType.smallRegular,
                    maxline:isSelected ? 2:1,
                    fw: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
