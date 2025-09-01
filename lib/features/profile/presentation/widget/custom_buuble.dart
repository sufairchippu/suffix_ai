import 'package:flutter/cupertino.dart';

class BubblePainter extends CustomPainter {
  final Color lightColor;
  final Color darkColor;

  BubblePainter({
    required this.lightColor,
    required this.darkColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Radial gradient: light in the middle → dark edges
    final gradient = RadialGradient(
      colors: [lightColor, darkColor],
      stops: const [0.2, 1.0],
      center: Alignment.topLeft, // Light source direction
      radius: 0.9,
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    // Draw the sphere
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomBubble extends StatelessWidget {
  final double size;
  final Color lightColor;
  final Color darkColor;

  const CustomBubble({
    super.key,
    required this.size,
    this.lightColor = CupertinoColors.white,
    this.darkColor = CupertinoColors.systemBlue,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: BubblePainter(lightColor: lightColor, darkColor: darkColor),
    );
  }
}