import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_scroll_2_axis/color_painter.dart';

double APP_BAR_HEIGHT = 80.0;

class ColorBoard extends StatefulWidget {
  final Map<String, List<Color>> colors;

  const ColorBoard({Key key, @required this.colors}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ColorBoardState();
  }
}

enum AxisEnable { Horizontal, Vertical }

class ColorBoardState extends State<ColorBoard> {
  List<double> _dxs = [];
  double _dy = 0.0;
  double _maxDistance = 0.0;
  double _dyPosition;

  AxisEnable _axisEnable;
  Size _deviceSize;

  DataDecoratePainter _decorate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.widget.colors.forEach((k, v) => this._dxs.add(0.0));
    this._decorate = DataDecoratePainter(
      widthSquare: 80.0,
      heightSquare: 80.0,
      heightName: 22.0,
      marginTop: 36.0,
      marginLeft: 5.0,
      marginRight: 5.0,
      marginBottom: 5.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return buildColorPainter(_deviceSize);
  }

  Widget buildColorPainter(Size _deviceSize) {
    return Listener(
      child: CustomPaint(
        size: Size(_deviceSize.width, _deviceSize.height - APP_BAR_HEIGHT),
        painter: ColorPainter(
            dataDecoratePainter: _decorate,
            colors: widget.colors,
            offsets: _dxs.map((_dx) => Offset(_dx, _dy)).toList()),
      ),
      onPointerUp: handlePointerUp,
      onPointerMove: handlePointerMove,
    );
  }

  void handlePointerMove(PointerMoveEvent event) {
    double _dyDistance = event.delta.dy;
    double _dxDistance = event.delta.dx;
    if (_axisEnable == AxisEnable.Vertical ||
        (_axisEnable == null && _dyDistance.abs() > 4.0))
      onScrollVertical(_dyDistance);
    if (_axisEnable == AxisEnable.Horizontal ||
        (_axisEnable == null && _dxDistance.abs() > 4.0)) {
      _dyPosition = event.position.dy - _dy - 80;
      onScrollHorizontal(_dxDistance);
    }
  }

  void handlePointerUp(PointerUpEvent event) {
    bool isApplyVelocity = _maxDistance.abs() > 8;
    setState(() {
      if (isApplyVelocity) {
        int _length = 10;
        for (int i = 0; i < _length; i++) {
          double _distance = _maxDistance  / (_length / 2 - (i + 1)).abs();
          Timer(
              Duration(milliseconds: 50 * i),
              () => _axisEnable == AxisEnable.Vertical
                  ? onScrollVertical(_distance, isScrolling: false)
                  : onScrollHorizontal(_distance, isScrolling: false));
        }
        Timer(Duration(milliseconds: _length * 50), resetScrollState);
      } else
        resetScrollState();
    });
  }

  void resetScrollState() {
    _axisEnable = null;
    _dyPosition = null;
    _maxDistance = 0.0;
  }

  void onScrollVertical(double dyDistance, {bool isScrolling = true}) {
    double _heightRow = _decorate.marginTop + _decorate.heightSquare;
    setState(() {
      double _newDy = this._dy + dyDistance;
      double _bounceLeft = 0.0;
      double _bounceRight = _deviceSize.height -
          APP_BAR_HEIGHT -
          _decorate.marginBottom -
          widget.colors.length * _heightRow;
      if (_newDy <= _bounceLeft && _newDy >= _bounceRight)
        this._dy += dyDistance;

      this._axisEnable = AxisEnable.Vertical;
      if (dyDistance.abs() > this._maxDistance && isScrolling)
        this._maxDistance = dyDistance;
    });
  }

  void onScrollHorizontal(double dxDistance, {bool isScrolling = true}) {
    double _heightRow = _decorate.marginTop + _decorate.heightSquare;
    int _index = (_dyPosition / _heightRow).floor();
    bool _isAccept = _dyPosition - _index * _heightRow > _decorate.marginTop;
    if (_isAccept) {
      setState(() {
        double _newDx = this._dxs[_index] + dxDistance;
        double _bounceLeft = 0.0;
        double _bounceRight = _deviceSize.width -
            widget.colors[widget.colors.keys.toList()[_index]].length *
                _decorate.widthSquare -
            _decorate.marginRight -
            _decorate.marginLeft;
        if (_newDx <= _bounceLeft && _newDx >= _bounceRight)
          this._dxs[_index] = _newDx;

        this._axisEnable = AxisEnable.Horizontal;
        if (dxDistance.abs() > this._maxDistance && isScrolling)
          this._maxDistance = dxDistance;
      });
    }
  }
}
