import 'package:flutter/material.dart';

class ColorPainter extends CustomPainter {
  final Map<String, List<Color>> colors;
  final List<Offset> offsets;

  final DataDecoratePainter dataDecoratePainter;

  ColorPainter(
      {@required this.colors,
      @required this.offsets,
      this.dataDecoratePainter});

  @override
  void paint(Canvas canvas, Size size) {
    final double _widthSquare = dataDecoratePainter.widthSquare;
    final double _heightSquare = dataDecoratePainter.heightSquare;
    final double _heightName = dataDecoratePainter.heightName;
    final double _marginTop = dataDecoratePainter.marginTop;
    final double _marginLeft = dataDecoratePainter.marginLeft;
    final double _marginRight = dataDecoratePainter.marginRight;

    colors.keys.forEach((_key) {
      int _index = colors.keys.toList().indexOf(_key);

      Offset _offset = Offset(0.0, _marginTop - _heightName) + offsets[_index];
      String _name = _key;
      List<Color> _colors = colors[_key];

      Offset _offsetName = _offset + Offset(_marginLeft - offsets[_index].dx, (_heightSquare + _marginTop) * _index);
      double _widthName = _marginLeft + _colors.length * _widthSquare + _marginRight;
      paintNameColor(canvas, _name, _offsetName, _widthName);

      Offset _offsetColor = _offset + Offset(_marginLeft, (_heightSquare + _marginTop) * _index + _heightName);
      paintListColor(canvas, _colors, _offsetColor, _widthSquare, _heightSquare);
    });
  }

  @override
  bool shouldRepaint(ColorPainter oldDelegate) {
    return colors != oldDelegate.colors || offsets != oldDelegate.offsets;
  }

  void paintNameColor(Canvas _canvas, String _name, Offset _offsetName, double _widthName) {
    TextStyle _nameStyle = TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.bold);

    TextSpan _nameSpan = TextSpan(style: _nameStyle, text: _name);

    TextPainter _namePainter = TextPainter(
        text: _nameSpan,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        maxLines: 1);
    _namePainter.layout(minWidth: _widthName, maxWidth: _widthName);
    _namePainter.paint(_canvas, _offsetName);
  }

  void paintListColor(Canvas _canvas, List<Color> _colors, Offset _offsetColors,
      double _widthSquare, double _heightSquare) {
    _colors.forEach((_color) {
      int _index = _colors.indexOf(_color);
      Offset _offset = _offsetColors + Offset(_widthSquare * _index, 0.0);

      Paint _paint = Paint()
        ..color = _color
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round;

      Rect _rect = Rect.fromLTWH(_offset.dx, _offset.dy, _widthSquare, _heightSquare);

      _canvas.drawRect(_rect, _paint);
    });
  }
}

class DataDecoratePainter {
  final double widthSquare;
  final double heightSquare;

  final double heightName;
  final double marginTop;
  final double marginLeft;
  final double marginRight;
  final double marginBottom;

  DataDecoratePainter(
      {this.widthSquare,
      this.heightSquare,
      this.heightName,
      this.marginTop,
      this.marginLeft,
      this.marginRight,
      this.marginBottom});
}
