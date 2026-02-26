import 'dart:async';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CustomCarousalWidget extends ConsumerStatefulWidget {
  final List<Widget> widgets;
  final StateProvider<int> provider;
  final bool autoPlay;
  final bool loopFlow;
  const CustomCarousalWidget({
    super.key,
    required this.widgets,
    required this.provider,
    this.autoPlay = false,
    this.loopFlow = true,
  });

  @override
  ConsumerState<CustomCarousalWidget> createState() =>
      _CustomCarousalWidgetState();
}

class _CustomCarousalWidgetState extends ConsumerState<CustomCarousalWidget> {
  final PageController _controller = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Auto-slide every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (widget.autoPlay && mounted) {
        final currentPage = ref.read(widget.provider);
        final nextPage = currentPage < widget.widgets.length - 1
            ? currentPage + 1
            : 0;

        ref.read(widget.provider.notifier).state = nextPage;

        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentPage = ref.watch(widget.provider);

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              final thisCurrentPage = index % widget.widgets.length;
              ref.read(widget.provider.notifier).state = widget.loopFlow
                  ? thisCurrentPage
                  : currentPage;
            },
            itemBuilder: (context, index) {
              // loop items infinitely using modulo
              final loopedIndex = index % widget.widgets.length;
              return widget.widgets[loopedIndex];
            },
          ),
        ),
        SizedBox(height: 12.rh(context)),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.widgets.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.rh(context)),
              width: currentPage == index ? 15.rw(context) : 6.rw(context),
              height: 6.rh(context),
              decoration: BoxDecoration(
                color: currentPage == index
                    ? context.greyFirstColor
                    : context.greySecondColor,
                borderRadius: BorderRadius.circular(3.rf(context)),
              ),
            );
          }),
        ),
        SizedBox(height: 12.rh(context)),
      ],
    );
  }
}
