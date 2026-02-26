// // import 'package:clean_architutre_learn/core/theme/app_color/app_color.dart';
// // import 'package:flutter/cupertino.dart';

// // class TopBackgroundPainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint()
// //       ..color =
// //           const Color(0xFFFF6F61) // coral background
// //       ..style = PaintingStyle.fill;

// //     Path path = Path();
// //     path.lineTo(0, size.height * 0.75);
// //     path.quadraticBezierTo(
// //       size.width * 0.25,
// //       size.height * 0.65,
// //       size.width * 0.5,
// //       size.height * 0.75,
// //     );
// //     path.quadraticBezierTo(
// //       size.width * 0.75,
// //       size.height * 0.85,
// //       size.width,
// //       size.height * 0.75,
// //     );
// //     path.lineTo(size.width, 0);
// //     path.close();

// //     canvas.drawPath(path, paint);

// //     // Optional: overlay subtle contour strokes
// //     final strokePaint = Paint()
// //       ..color = AppColors.greyFirst.withOpacity(0.15)
// //       ..style = PaintingStyle.stroke
// //       ..strokeWidth = 1.2;

// //     for (double i = 0; i < size.height; i += 40) {
// //       Path contour = Path();
// //       contour.moveTo(0, size.height * 0.75 - i);
// //       contour.quadraticBezierTo(
// //         size.width * 0.25,
// //         size.height * 0.65 - i,
// //         size.width * 0.5,
// //         size.height * 0.75 - i,
// //       );
// //       contour.quadraticBezierTo(
// //         size.width * 0.75,
// //         size.height * 0.85 - i,
// //         size.width,
// //         size.height * 0.75 - i,
// //       );
// //       canvas.drawPath(contour, strokePaint);
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(CustomPainter oldDelegate) => false;
// // }
// import 'dart:math';

// import 'package:clean_architutre_learn/core/theme/app_color/app_color.dart';
// import 'package:flutter/cupertino.dart';

// class TopBackgroundPainter extends CustomPainter {
//   final double animationValue;

//   TopBackgroundPainter({this.animationValue = 0.0});

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Coral gradient background
//     final gradient = LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [
//         const Color(0xFFFF6F61), // coral
//         const Color(0xFFFF8A75), // lighter coral
//         const Color(0xFFFFB199), // peachy coral
//         const Color(0xFFFFC3A0), // soft peach
//       ],
//     );

//     final backgroundPaint = Paint()
//       ..shader = gradient.createShader(
//         Rect.fromLTWH(0, 0, size.width, size.height),
//       );

//     canvas.drawRect(
//       Rect.fromLTWH(0, 0, size.width, size.height),
//       backgroundPaint,
//     );

//     // Animated wave shape
//     Path wavePath = Path();
//     wavePath.moveTo(0, size.height * 0.65);
//     for (double x = 0; x <= size.width; x += size.width / 20) {
//       final y =
//           size.height * 0.65 +
//           20 * sin((x / size.width * 2 * pi) + animationValue);
//       wavePath.lineTo(x, y);
//     }
//     wavePath.lineTo(size.width, size.height);
//     wavePath.lineTo(0, size.height);
//     wavePath.close();

//     final wavePaint = Paint()..color = AppColors.card.withOpacity(0.3);
//     canvas.drawPath(wavePath, wavePaint);

//     // Floating particles
//     final particlePaint = Paint()..color = AppColors.card.withOpacity(0.7);
//     for (int i = 0; i < 10; i++) {
//       final x = (size.width / 10) * i + 10;
//       final y =
//           size.height * 0.3 + 30 * sin(animationValue * 1.5 + i.toDouble());
//       canvas.drawCircle(Offset(x, y), 3, particlePaint);
//     }
//   }

//   @override
//   bool shouldRepaint(TopBackgroundPainter oldDelegate) =>
//       animationValue != oldDelegate.animationValue;
// }

// class SimpleAnimatedBackground extends StatefulWidget {
//   const SimpleAnimatedBackground({super.key});

//   @override
//   State<SimpleAnimatedBackground> createState() =>
//       _SimpleAnimatedBackgroundState();
// }

// class _SimpleAnimatedBackgroundState extends State<SimpleAnimatedBackground>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (_, __) => CustomPaint(
//         painter: TopBackgroundPainter(
//           animationValue: _controller.value * 2 * pi,
//         ),
//         size: Size.infinite,
//       ),
//     );
//   }
// }
import 'dart:math';
import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_color/app_color.dart';

class TopBackgroundPainter extends CustomPainter {
  final double animationValue;
  final Color waveColor;
  final Color particleColor;

  TopBackgroundPainter({
    this.animationValue = 0.0,
    this.waveColor = const Color(0xFFFFFFFF),
    this.particleColor = const Color(0xFFFFFFFF),
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Animated wave shape
    Path wavePath = Path();
    wavePath.moveTo(0, size.height * 0.9);

    for (double x = 0; x <= size.width; x += size.width / 20) {
      final y =
          size.height * 0.9 +
          20 * sin((x / size.width * 2 * pi) + animationValue);
      // final y =
      //     size.height * 0.65 +
      //     20 * sin((x / size.width * 2 * pi) + animationValue);
      wavePath.lineTo(x, y);
    }

    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    // final wavePaint = Paint()..color = waveColor.withValues(alpha: .3);
    final wavePaint = Paint()
      ..color = waveColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawPath(wavePath, wavePaint);

    // Floating particles
    final particlePaint = Paint()..color = particleColor.withValues(alpha: .3);

    for (int i = 0; i < 10; i++) {
      final x = (size.width / 10) * i + 10;
      final y =
          size.height * 0.3 + 30 * sin(animationValue * 1.5 + i.toDouble());
      canvas.drawCircle(Offset(x, y), 3, particlePaint);
    }
  }

  @override
  bool shouldRepaint(TopBackgroundPainter oldDelegate) =>
      animationValue != oldDelegate.animationValue ||
      waveColor != oldDelegate.waveColor ||
      particleColor != oldDelegate.particleColor;
}

class AuthBackgroundAnimation extends StatefulWidget {
  final Color? waveColor;
  final Color? particleColor;
  final Duration? animationDuration;

  const AuthBackgroundAnimation({
    super.key,
    this.waveColor,
    this.particleColor,
    this.animationDuration,
  });

  @override
  State<AuthBackgroundAnimation> createState() =>
      _AuthBackgroundAnimationState();
}

class _AuthBackgroundAnimationState extends State<AuthBackgroundAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration ?? const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //   '${_controller.value}>>>>>>>>>>>>>>>animation controller valueeeee       in. build',
    // );
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        return RepaintBoundary(
          child: CustomPaint(
            painter: TopBackgroundPainter(
              animationValue: _controller.value * 2 * pi,
              waveColor: widget.waveColor ?? AppColors.card,
              particleColor: widget.particleColor ?? AppColors.card,
            ),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}
// )

// 3. Sunset theme
// SimpleAnimatedBackground(
//   gradientColors: [
//     Color(0xFF7C2D92), // purple
//     Color(0xFFE11D48), // rose
//     Color(0xFFF97316), // orange
//     Color(0xFFFBBF24), // yellow
//   ],
//   waveColor: AppColors.card,
//   particleColor: Colors.amber,
//   animationDuration: Duration(seconds: 6),
// )

// 4. Forest theme
// SimpleAnimatedBackground(
//   gradientColors: [
//     Color(0xFF064E3B), // dark green
//     Color(0xFF047857), // green
//     Color(0xFF10B981), // emerald
//     Color(0xFF6EE7B7), // light green
//   ],
//   waveColor: Colors.lightGreen,
//   particleColor: Colors.yellow,
// )
