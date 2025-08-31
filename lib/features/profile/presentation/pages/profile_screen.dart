import 'package:clean_architutre_learn/core/constants/image_constants.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/custom_textform_field.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  // final TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,

      child: CupertinoPageScaffold(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 140.rh(context),
                      width: 140.rh(context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(ImageConstants.logo),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 27.rw(context),
                      bottom: 7.rh(context),
                      child: GestureDetector(
                        onTap: () {
                          
                        },
                        child: Icon(
                          CupertinoIcons.camera_fill,
                          color: context.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomButtonWIdget(
                  widget: Row(
                    children: [
                      Uiutils.getTextWidget(context, 'UserName'),
                      Spacer(),
                    ],
                  ),
                ),
                CustomButtonWIdget(
                  widget: Row(
                    children: [Uiutils.getTextWidget(context, 'E-mail')],
                  ),
                ),
                CustomButtonWIdget(
                  widget: Row(
                    children: [Uiutils.getTextWidget(context, 'Phone Number')],
                  ),
                ),
                // CupertinoListSection(
                //   children: [
                //     CupertinoListTile(
                //       title: Uiutils.getTextWidget(context, 'Phone number'),
                //       subtitle: CustomTextFormField(
                //         obscure: false,
                //         prefixNeeded: false,
                //       ), //Uiutils.getTextWidget(context, 'title'),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
