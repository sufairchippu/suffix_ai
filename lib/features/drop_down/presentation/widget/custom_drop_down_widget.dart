import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/provider/quiz_sccren_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// 🔹 Local search query provider

class PureCupertinoDropdown extends ConsumerWidget {
  const PureCupertinoDropdown({
    super.key,
    required this.items,
    this.subHeading,
    this.bottomPadding,
    this.validator,
    this.topPadding,
    required this.selectedValueProvider,
  });
  final String? Function(String?)? validator;
  final List<String> items;
  final String? subHeading;
  final double? bottomPadding;
  final double? topPadding;
  final StateProvider<String?> selectedValueProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedValueProvider);

    return FormField<String>(
      validator: validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: topPadding ?? 10.rh(context)),

            if (subHeading != null) ...[
              Uiutils.getTextWidget(
                context,
                subHeading!,
                textStyle: TextStyleType.mediumBold,
                color: context.mainLightShadeColor,
              ),
              SizedBox(height: 10.rh(context)),
            ],

            CustomButtonWIdget(
              height: 35.rh(context),
              borderRadius: 10.rh(context),
              boxshadowColor: context.secondaryColor,
              bordercolor: field.hasError
                  ? context.red
                  : context.subTextColor.withValues(alpha: .3),
              onTap: () => _showSearchablePicker(context, ref, field),
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Uiutils.getTextWidget(context, selected ?? 'Select a choice'),
                  const Icon(CupertinoIcons.chevron_down),
                ],
              ),
            ),
            if (field.hasError)
              Padding(
                padding: EdgeInsetsGeometry.only(
                  left: 4.rw(context),
                  top: 4.rh(context),
                ),
                child: Uiutils.getTextWidget(context, field.errorText!),
              ),
            SizedBox(height: bottomPadding ?? 10.rh(context)),
          ],
        );
      },
    );
  }

  void _showSearchablePicker(
    BuildContext context,
    WidgetRef ref,
    FormFieldState<String> fieldState,
  ) {
    ref.read(searchQueryProvider.notifier).state = '';

    showCupertinoModalPopup(
      context: context,
      builder: (_) => _DropdownPopup(
        items: items,
        selectedValue: selectedValueProvider,

        onSelect: (item) {
          ref.read(selectedValueProvider.notifier).state = item;
          fieldState.didChange(item);
        },
      ),
    );
  }
}

// 🔹 Separate widget for popup content
class _DropdownPopup extends ConsumerWidget {
  const _DropdownPopup({
    required this.items,
    required this.selectedValue,

    required this.onSelect,
  });
  final void Function(String) onSelect;
  final List<String> items;
  final StateProvider<String?> selectedValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final selected = ref.watch(selectedValue);

    final filteredItems = items
        .where((item) => item.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Container(
      height: 500.rh(context),
      color: CupertinoColors.transparent,
      child: Column(
        children: [
          // Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(8.rh(context)),
                child: CustomButtonWIdget(
                  padding: 0,
                  borderRadius: 6.rf(context),
                  width: 60.rw(context),
                  height: 30.rh(context),
                  onTap: () => Navigator.pop(context),
                  widget: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: context.secondaryColor,
                  ),
                ),
              ),
            ],
          ),

          // List Section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: context.scaffoldColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.rf(context)),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 12.rh(context),
                vertical: 8.rw(context),
              ),
              child: CupertinoScrollbar(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    final isSelected = item == selected;
                    return CustomButtonWIdget(
                      onTap: () {
                        ref.read(selectedValue.notifier).state = item;
                        onSelect(item);
                        Navigator.pop(context);
                      },
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Uiutils.getTextWidget(context, item),
                          if (isSelected)
                            const Icon(
                              CupertinoIcons.check_mark,
                              size: 20,
                              color: CupertinoColors.activeBlue,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Search Bar
          Container(
            color: context.scaffoldColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.rh(context),
                vertical: 8.rw(context),
              ),
              child: CupertinoSearchTextField(
                placeholder: 'Search...',
                onChanged: (value) =>
                    ref.read(searchQueryProvider.notifier).state = value,
              ),
            ),
          ),
          SizedBox(height: 12.rh(context)),
        ],
      ),
    );
  }
}
