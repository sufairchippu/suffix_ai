import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';

class PureCupertinoDropdown extends StatefulWidget {
  const PureCupertinoDropdown({
    super.key,
    required this.items,
    this.subHeading,
    this.bottomPadding,
    this.topPadding,
  });
  final List<String> items;
  final String? subHeading;
  final double? bottomPadding;
  final double? topPadding;
  @override
  State<PureCupertinoDropdown> createState() => _PureCupertinoDropdownState();
}

class _PureCupertinoDropdownState extends State<PureCupertinoDropdown> {
  // final List<String> items = [
  //   'Apple',
  //   'Banana',
  //   'Mango',
  //   'Orange',
  //   'Grapes',
  //   'Papaya',
  //   'Pineapple',
  //   'Watermelon',
  // ];
  //! change to provider assaign each value specific provider assiagn requird in this widget
  String? selectedValue;

  void _showSearchablePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        TextEditingController searchController = TextEditingController();
        List<String> filteredItems = List.from(widget.items);

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: 500.rh(context),
              color: CupertinoColors.transparent,
              child: Column(
                children: [
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

                  // ✅ Filtered List
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
                            final isSelected = item == selectedValue;
                            return CustomButtonWIdget(
                              onTap: () {
                                //!change set that fucntion through provider
                                setState(() => selectedValue = item);
                                Navigator.pop(context);
                              },
                              widget: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

                  // ✅ Search Bar
                  Container(
                    color: context.scaffoldColor,

                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.rh(context),
                        vertical: 8.rw(context),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CupertinoSearchTextField(
                              controller: searchController,
                              placeholder: 'Search...',
                              onChanged: (value) {
                                //!change to riverpod provider
                                setModalState(() {
                                  filteredItems = widget.items
                                      .where(
                                        (item) => item.toLowerCase().contains(
                                          value.toLowerCase(),
                                        ),
                                      )
                                      .toList();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.rh(context)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // spacing: 7.rh(context),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topPadding ?? 10.rh(context)),

        if (widget.subHeading != null) ...[
          Uiutils.getTextWidget(
            context,
            widget.subHeading!,
            textStyle: TextStyleType.mediumBold,
            color: context.mainLightShadeColor,
          ),
          SizedBox(height: 10.rh(context)),
        ],
        CustomButtonWIdget(
          height: 35.rh(context),
          borderRadius: 10.rh(context),
          boxshadowColor: context.secondaryColor,
          bordercolor: context.subTextColor.withValues(alpha: .3),
          onTap: _showSearchablePicker,
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Uiutils.getTextWidget(
                context,
                selectedValue ?? 'Select a choice',
              ),
              Icon(CupertinoIcons.chevron_down),
            ],
          ),
        ),
        SizedBox(height: widget.bottomPadding ?? 10.rh(context)),
      ],
    );

    // CupertinoPageScaffold(
    //   navigationBar: CupertinoNavigationBar(
    //     middle: Uiutils.getTextWidget(
    //       context,
    //       'Cupertino Dropdown with Search',
    //     ),
    //   ),
    //   child: SafeArea(
    //     child: Center(
    //       child: CupertinoButton.filled(
    //         onPressed: _showSearchablePicker,
    //         child: Text(selectedValue),
    //       ),
    //     ),
    //   ),
    // );
  }
}
