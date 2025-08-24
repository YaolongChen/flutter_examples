import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomPaint(
            size: constraints.biggest,
            painter: TextLayoutPainter(
              textDirection: Directionality.of(context),
            ),
          );
        },
      ),
    );
  }
}

class TextLayoutPainter extends CustomPainter {
  TextLayoutPainter({super.repaint, required this.textDirection});

  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final textSize = Size(size.width * .75, size.height);
    final textPainter = TextPainter(
      textDirection: textDirection,
      text: TextSpan(
        text: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
        style: TextStyle(fontSize: 70, color: Colors.black, height: 1.2),
      ),
    );
    textPainter.layout(maxWidth: textSize.width);

    final textMetrics = textPainter.computeLineMetrics();
    final textRect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: textPainter.width,
      height: textPainter.height,
    );

    for (var metrics in textMetrics) {
      final baseline = metrics.baseline;
      final ascent = metrics.ascent;
      final descent = metrics.descent;
      final paint = Paint()..color = Colors.yellow;
      final ascentRect = Rect.fromLTWH(
        textRect.left,
        textRect.top + baseline - ascent,
        textRect.width,
        ascent,
      );
      canvas.drawRect(ascentRect, paint);
      final ascentTP = TextPainter(
        text: TextSpan(
          text: 'Ascent: ${metrics.ascent.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        textDirection: textDirection,
      )..layout();
      ascentTP.paint(
        canvas,
        Offset(
          textRect.left - ascentTP.width,
          ascentRect.center.dy - ascentTP.height / 2,
        ),
      );

      final descentRect = Rect.fromLTWH(
        textRect.left,
        textRect.top + baseline,
        textRect.width,
        descent,
      );
      paint.color = Colors.green;
      canvas.drawRect(descentRect, paint);
      final descentTP = TextPainter(
        text: TextSpan(
          text: 'Descent: ${metrics.descent.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        textDirection: textDirection,
      )..layout();
      descentTP.paint(
        canvas,
        Offset(
          textRect.left - descentTP.width,
          descentRect.center.dy - descentTP.height / 2,
        ),
      );
    }

    textPainter.paint(
      canvas,
      size.center(Offset(-textPainter.width / 2, -textPainter.height / 2)),
    );

    final baselinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 2;
    for (var metrics in textMetrics) {
      final baseline = metrics.baseline;

      canvas.drawLine(
        Offset(textRect.left, textRect.top + baseline),
        Offset(textRect.right, textRect.top + baseline),
        baselinePaint,
      );
      final baselineTP = TextPainter(
        text: TextSpan(
          text: 'Baseline${metrics.lineNumber}',
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        textDirection: textDirection,
      )..layout();
      baselineTP.paint(
        canvas,
        Offset(textRect.right, textRect.top + baseline - baselineTP.height / 2),
      );

      final heightTP = TextPainter(
        text: TextSpan(
          text: 'Height: ${metrics.height.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        textDirection: textDirection,
      )..layout();
      heightTP.paint(
        canvas,
        Offset(
          textRect.right,
          textRect.top +
              baseline -
              metrics.ascent / 2 +
              metrics.descent / 2 -
              heightTP.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
