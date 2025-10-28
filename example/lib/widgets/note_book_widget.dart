import 'package:flutter/material.dart';

class NotebookWidget extends StatelessWidget {
  final List<TextSpan> textSpans;
  final double fontSize;
  final double textLineHeight;

  const NotebookWidget({
    super.key,
    required this.textSpans,
    this.fontSize = 18.0,
    this.textLineHeight = 1.6,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: NotebookPainter(
        lineHeight: fontSize * textLineHeight,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 20, 20),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: fontSize,
                color: const Color(0xFF333333),
                height: textLineHeight,
              ),
              children: textSpans,
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter for drawing the notebook lines.
class NotebookPainter extends CustomPainter {
  final double lineHeight;

  NotebookPainter({required this.lineHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final blueLinePaint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.3)
      ..strokeWidth = 1.0;

    final redLinePaint = Paint()
      ..color = Colors.red.withValues(alpha: 0.5)
      ..strokeWidth = 1.5;

    for (double y = lineHeight; y < size.height; y += lineHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), blueLinePaint);
    }

    const double marginLineX = 30.0;
    canvas.drawLine(const Offset(marginLineX, 0),
        Offset(marginLineX, size.height), redLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is NotebookPainter) {
      return oldDelegate.lineHeight != lineHeight;
    }
    return true;
  }
}
