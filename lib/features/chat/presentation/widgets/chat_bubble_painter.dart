
import 'package:flutter/cupertino.dart';

class BubbleClipper extends CustomClipper<Path> {
  final bool isSender;
  BubbleClipper({required this.isSender});

  @override
  Path getClip(Size size) {
    return ChatBubblePainter.getBubblePath(size, isSender);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ChatBubblePainter extends CustomPainter {
  final Color color;
  final bool isSender;

  ChatBubblePainter({required this.color, required this.isSender});

  static Path getBubblePath(Size size, bool isSender) {
    final radius = 18.0;
    final tailRadius = 6.0;
    final path = Path();

    if (isSender) {
      path.moveTo(radius, 0);
      path.lineTo(size.width - radius, 0);
      path.quadraticBezierTo(size.width, 0, size.width, radius);
      path.lineTo(size.width, size.height - radius);
      path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);

      // Tail
      path.lineTo(size.width - tailRadius, size.height);
      path.quadraticBezierTo(size.width, size.height + 2, size.width, size.height - tailRadius);
      path.quadraticBezierTo(size.width - 2, size.height, size.width - tailRadius * 2, size.height);

      path.lineTo(radius, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - radius);
      path.lineTo(0, radius);
      path.quadraticBezierTo(0, 0, radius, 0);
    } else {
      path.moveTo(radius, 0);
      path.lineTo(size.width - radius, 0);
      path.quadraticBezierTo(size.width, 0, size.width, radius);
      path.lineTo(size.width, size.height - radius);
      path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);

      // Tail
      path.lineTo(tailRadius * 2, size.height);
      path.quadraticBezierTo(0, size.height + 2, 0, size.height - tailRadius);
      path.quadraticBezierTo(2, size.height, tailRadius, size.height);

      path.lineTo(radius, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - radius);
      path.lineTo(0, radius);
      path.quadraticBezierTo(0, 0, radius, 0);
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawPath(getBubblePath(size, isSender), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}