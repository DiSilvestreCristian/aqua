import 'package:aqua/value/colors.dart';
import 'package:flutter/material.dart';

class ChartPainter extends CustomPainter{

  final List<String> x;
  final List<double> y;
  final double min, max;
  final Color colorPollutant;
  ChartPainter(this.x, this.y, this.min, this.max, this.colorPollutant);

  static double border = 20.0;
  static double radius = 6.0;

  @override
  void paint(Canvas canvas, Size size) {

    final linePaint = Paint()
      ..color = colorPollutant
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final labelStyle = TextStyle(
      color: colorPollutant,
      fontSize: 16,
    );

    final clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(clipRect);
    canvas.drawPaint(Paint()..color = colorItemBackgroundTertiary);

    final drawableHeight = size.height - 2.0 * border;
    final drawableWidth = size.width - 2.0 * border;
    final hd = drawableHeight / 5.0;
    final wd = drawableWidth / this.x.length.toDouble();

    final height = hd * 3.0;
    final width = drawableWidth;

    if (height <= 0.0 || width <= 0.0)return;
    if (max - min < 1.0e-6)return;

    final hr = height / (max - min); //unità di altezza
    
    final left = border;
    final top = border;
    var c = Offset(left + wd /2.0, top + height/2.0);
    //_drawOutline(canvas, c, wd, height);

    final points = _computePoints(c, wd, height, hr);
    final path = _computePath(points);
    final labels = _computeLabel();

    canvas.drawPath(path, linePaint);
    _drawdDataPoints(points, labels, canvas, c, wd);

    var c1 = Offset(c.dx, top + 4 * hd);
    _drawXLabels(canvas, c1, wd);
  }

  void _drawdDataPoints(List<Offset> points, List<String> labels, Canvas canvas, Offset c, double wd) {

    final dotPaintfill = Paint()
      ..color = colorItemBackgroundSecondary
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    final dotLinePaint = Paint()
      ..color = colorPollutant
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for(var i = 0; i<points.length; i++){
      final dp = points[i];
      canvas.drawCircle(dp, radius, dotPaintfill);
      canvas.drawCircle(dp, radius, dotLinePaint);
    }
  }

  void _drawXLabels(Canvas canvas, Offset c, double wd){
    final xLabelStyle = TextStyle(
      color: colorPollutant,
      fontSize: 14,
      fontWeight: FontWeight.bold
    );

    x.forEach((xp) {
      drawTextCenter(canvas, c, xp, xLabelStyle, wd);
      c += Offset(wd, 0);
    });
  }

  Path _computePath(List<Offset> points){
    final path = Path();
    for(var i=0; i<points.length; i++){
      final p = points[i];
      if(i == 0){
        path.moveTo(p.dx, p.dy);
      }else{
        path.lineTo(p.dx, p.dy);
      }
    }
    return path;
  }

  List<Offset> _computePoints(Offset c, double width, double height, double hr) {
    List<Offset> points = [];
    y.forEach((yp) {
      final yy = height - (yp - min) *hr;
      final dp = Offset(c.dx, c.dy - height/2.0 + yy);
      points.add(dp);
      c += Offset(width, 0);
    });
    return points;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _drawOutline(Canvas canvas, Offset c, double width, double height) {
    final Paint  outlinePaint = Paint()
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..color = colorPollutant;
    y.forEach((p) {
      final rect = Rect.fromCenter(center: c, width: width, height: height);
      canvas.drawRect(rect, outlinePaint);
      c += Offset(width, 0);
    });
  }

  List<String> _computeLabel() {
    return y.map((yp) => "${yp.toStringAsFixed(1)}").toList();
  }

  TextPainter measureText(String s, TextStyle style, double maxWidht, TextAlign align) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter (text: span, textAlign: align, textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidht);
    return tp;
  }

  Size drawTextCenter(Canvas canvas, Offset c, String text, TextStyle style, double maxWidht) {
    final tp = measureText(text, style, maxWidht, TextAlign.center);
    final position = c + Offset(-tp.width/2.0, -tp.height/2.0);
    tp.paint(canvas, position);
    return tp.size;
  }

}