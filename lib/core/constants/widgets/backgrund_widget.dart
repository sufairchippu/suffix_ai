// Simple opacity blob class
import 'dart:math';

import 'package:flutter/cupertino.dart';

class OpacityBlob {
  late Offset position;
  late Offset velocity;
  late double size;
  late double baseOpacity;
  late double pulseSpeed;
  late double pulseOffset;

  OpacityBlob(Size screenSize) {
    _randomize(screenSize);
  }

  void _randomize(Size screenSize) {
    final random = Random();
    position = Offset(
      random.nextDouble() * screenSize.width,
      random.nextDouble() * screenSize.height,
    );
    velocity = Offset(
      (random.nextDouble() - 0.5) * 1.5, // Slower movement
      (random.nextDouble() - 0.5) * 1.5,
    );
    size = 80 + random.nextDouble() * 120; // 80-200
    baseOpacity = 0.1 + random.nextDouble() * 0.4; // 0.1-0.5
    pulseSpeed = 0.5 + random.nextDouble() * 2; // 0.5-2.5
    pulseOffset = random.nextDouble() * 2 * pi;
  }

  void update(double deltaTime, Size screenSize) {
    // Update position
    position += velocity * deltaTime * 30;

    // Wrap around edges smoothly
    if (position.dx < -size) {
      position = Offset(screenSize.width + size, position.dy);
    } else if (position.dx > screenSize.width + size) {
      position = Offset(-size, position.dy);
    }

    if (position.dy < -size) {
      position = Offset(position.dx, screenSize.height + size);
    } else if (position.dy > screenSize.height + size) {
      position = Offset(position.dx, -size);
    }

    // Occasionally change direction slightly
    final random = Random();
    if (random.nextDouble() < 0.01) {
      // 1% chance per frame
      velocity = Offset(
        velocity.dx + (random.nextDouble() - 0.5) * 0.3,
        velocity.dy + (random.nextDouble() - 0.5) * 0.3,
      );
      // Clamp velocity
      velocity = Offset(
        velocity.dx.clamp(-2.0, 2.0),
        velocity.dy.clamp(-2.0, 2.0),
      );
    }
  }

  double getCurrentOpacity(double animationValue) {
    // Calculate pulsing opacity
    final pulse = sin(animationValue * pulseSpeed + pulseOffset);
    return baseOpacity + (baseOpacity * 0.8 * pulse);
  }
}

// Main background painter
class SimpleOpacityMotionPainter extends CustomPainter {
  final double animationValue;
  final List<OpacityBlob> blobs;
  final Color primaryColor;
  final SimpleOpacityMotionBackground widget;

  SimpleOpacityMotionPainter({
    required this.animationValue,
    required this.blobs,
    required this.primaryColor,
    required this.widget,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Simple dark background (customizable)
    final backgroundColor = widget.backgroundColor ?? const Color(0xFF1A1A2E);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    // Draw opacity blobs
    for (final blob in blobs) {
      _drawOpacityBlob(canvas, size, blob);
    }
  }

  void _drawOpacityBlob(Canvas canvas, Size size, OpacityBlob blob) {
    final currentOpacity = blob.getCurrentOpacity(animationValue);

    // Create radial gradient with animated opacity
    final blobGradient = RadialGradient(
      center: Alignment.center,
      radius: 1.0,
      colors: [
        primaryColor.withValues(alpha: currentOpacity),
        primaryColor.withValues(alpha: currentOpacity * 0.7),
        primaryColor.withValues(alpha: currentOpacity * 0.3),
        primaryColor.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.4, 0.7, 1.0],
    );

    final blobPaint = Paint()
      ..shader = blobGradient.createShader(
        Rect.fromCenter(
          center: blob.position,
          width: blob.size * 2,
          height: blob.size * 2,
        ),
      );

    // Draw the blob
    canvas.drawCircle(blob.position, blob.size, blobPaint);
  }

  @override
  bool shouldRepaint(SimpleOpacityMotionPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}

// Main animated background widget
class SimpleOpacityMotionBackground extends StatefulWidget {
  final Color color;
  final int blobCount;
  final Color? backgroundColor;

  const SimpleOpacityMotionBackground({
    super.key,
    this.color = const Color(0xFF4ECDC4), // Default teal
    this.blobCount = 6,
    this.backgroundColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SimpleOpacityMotionBackgroundState createState() =>
      _SimpleOpacityMotionBackgroundState();
}

class _SimpleOpacityMotionBackgroundState
    extends State<SimpleOpacityMotionBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<OpacityBlob> _blobs;
  late Color _primaryColor;
  DateTime _lastFrameTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    _primaryColor = widget.color; // Use the passed color directly

    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // Initialize blobs
    _blobs = List.generate(
      widget.blobCount,
      (index) => OpacityBlob(const Size(400, 800)),
    );

    _controller.addListener(() {
      final now = DateTime.now();
      final deltaTime = now.difference(_lastFrameTime).inMilliseconds / 1000.0;
      _lastFrameTime = now;

      // Update blobs
      if (mounted) {
        final screenSize = MediaQuery.of(context).size;
        for (final blob in _blobs) {
          blob.update(deltaTime, screenSize);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: SimpleOpacityMotionPainter(
            animationValue: _controller.value * 2 * pi,
            blobs: _blobs,
            primaryColor: _primaryColor,
            widget: widget,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}
