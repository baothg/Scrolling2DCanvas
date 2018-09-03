import 'package:flutter/material.dart';
import 'package:flutter_scroll_2_axis/color_board.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    Map<String, List<Color>> _colors = createColorsMap();

    return Scaffold(
        appBar: AppBar(title: Text('Scroller 2 Axis')),
        body: ColorBoard(colors: _colors));
  }

  Map<String, List<Color>> createColorsMap() {
    Map<String, List<Color>> _colors = Map();
    _colors['Red'] = createListColor(Colors.red);
    _colors['Orange'] = createListColor(Colors.orange);
    _colors['Yellow'] = createListColor(Colors.yellow);
    _colors['Green'] = createListColor(Colors.green);
    _colors['Blue'] = createListColor(Colors.blue);
    _colors['Amber'] = createListColor(Colors.amber);
    _colors['Brown'] = createListColor(Colors.brown);
    _colors['Cyan'] = createListColor(Colors.cyan);
    _colors['Grey'] = createListColor(Colors.grey);
    _colors['Indigo'] = createListColor(Colors.indigo);
    _colors['Lime'] = createListColor(Colors.lime);
    _colors['Pink'] = createListColor(Colors.pink);
    _colors['Purple'] = createListColor(Colors.purple);
    _colors['Teal'] = createListColor(Colors.teal);
    return _colors;
  }

  List<Color> createListColor(MaterialColor color) {
    return [
      color.withOpacity(0.9),
      color.withOpacity(0.8),
      color.withOpacity(0.7),
      color.withOpacity(0.6),
      color.withOpacity(0.5),
      color.withOpacity(0.4),
      color.withOpacity(0.3),
      color.withOpacity(0.2),
      color.withOpacity(0.1),
    ];
  }
}
