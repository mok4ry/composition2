import 'package:composition2/src/color.dart';
import 'package:composition2/src/point.dart';
import 'package:composition2/src/color_block.dart';

class Codel {
  final Color color;
  ColorBlock _colorBlock = null;
  Point _position = Point(0, 0);

  Codel(Color this.color);

  void setPosition(Point p) {
    _position = p;
  }

  Point getPosition() {
    return _position;
  }

  void setColorBlock(ColorBlock colorBlock) {
    this._colorBlock = colorBlock;
  }

  ColorBlock getColorBlock() {
    return _colorBlock;
  }

  int getColorBlockSize() {
    return this._colorBlock.size();
  }

  bool colorBlockSet() {
    return _colorBlock != null;
  }

  Color getColor() {
    return this.color;
  }

  bool isEqual(Codel c) {
    return this.color.isEqual(c.getColor());
  }

  String toString() {
    return this.color.getDisplayColor();
  }
}