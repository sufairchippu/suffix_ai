import 'package:clean_architutre_learn/core/constants/lottie_constant.dart';
import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/banana/presentation/provider/imag_genratio_provider.dart';
import 'package:clean_architutre_learn/features/chat/presentation/widgets/chat_bakground_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StoredImgeScreen extends ConsumerStatefulWidget {
  const StoredImgeScreen({super.key});

  @override
  ConsumerState<StoredImgeScreen> createState() => _StoredimgeScreenState();
}

class _StoredimgeScreenState extends ConsumerState<StoredImgeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) =>
          ref.read(supabaseImagesNotifierProvider.notifier).fetchImages(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final storedImage = ref.watch(supabaseImagesNotifierProvider);
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Positioned.fill(
            child: GradientMotionBackground(
              colorr1: context.textColor,
              colorr2: context.shimmerHighlightColor,
              colorr3: context.scaffoldColor,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.rw(context),
                vertical: 40.rh(context),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 5.rw(context),
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(
                          CupertinoIcons.back,
                          color: context.mainDarkShadeColor,
                          size: 30.rf(context),
                        ),
                      ),
                      const AppLogoWidget(),
                      const SizedBox(),
                    ],
                  ),
                  Expanded(
                    child: storedImage.when(
                      data: (data) {
                        return data.isEmpty
                            ? Center(
                                child: Uiutils.getTextWidget(
                                  context,
                                  'No Image Stored in Suffix-Ai',
                                  color: context.textColor,
                                  fs: 20.rf(context),
                                ),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) =>
                                    CustomButtonWIdget(
                                      onTap: () => Uiutils.showAlert(
                                        context,
                                        () {},
                                        data[index].name.toString(),
                                        '',
                                        false,
                                        'Back',
                                        context.buttnColor,
                                        somethingTodo: true,
                                        widget: Container(
                                          height: 450.rh(context),
                                          width: 360.rw(context),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16.rf(context),
                                            ),
                                            image: DecorationImage(
                                              image: MemoryImage(
                                                data[index].bytesData,
                                              ),

                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      widget: Row(
                                        children: [
                                          SizedBox(
                                            height: 30.rh(context),
                                            width: 30.rw(context),
                                            child: Image.memory(
                                              data[index].bytesData,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Uiutils.getTextWidget(
                                            context,
                                            data[index].name.toString(),
                                          ),
                                          const Spacer(),
                                          const Icon(CupertinoIcons.dot_square),
                                        ],
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(),
                                itemCount: data.length,
                              );
                      },
                      error: (error, stackTrace) => Center(
                        child: Row(
                          children: [
                            Uiutils.getTextWidget(
                              context,
                              'Something went wrong',
                            ),
                            GestureDetector(
                              onTap: () => ref
                                  .read(supabaseImagesNotifierProvider.notifier)
                                  .fetchImages(),
                              child: Uiutils.getTextWidget(
                                context,
                                'Try Again',
                              ),
                            ),
                          ],
                        ),
                      ),
                      loading: () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Uiutils.getLottie(LottieConstant.chatScreen),
                          const CupertinoActivityIndicator(),
                          GestureDetector(
                            onTap: () => ref
                                .read(supabaseImagesNotifierProvider.notifier)
                                .fetchImages(),
                            child: Uiutils.getTextWidget(context, 'Try Again'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
