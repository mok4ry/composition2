import 'package:composition2/src/color.dart';
import 'package:composition2/src/point.dart';

class Codel {
  final Color color;
  List<Codel> _colorBlock = List<Codel>();
  Point _position = Point(0, 0);

  Codel(Color this.color);

  void setPosition(Point p) {
    _position = p;
  }

  Point getPosition() {
    return _position;
  }

  void setColorBlock(List<Codel> colorBlock) {
    this._colorBlock = colorBlock;
  }

  List<Codel> getColorBlock() {
    return _colorBlock;
  }

  int getColorBlockSize() {
    return this._colorBlock.length;
  }

  bool colorBlockSet() {
    return getColorBlockSize() > 0;
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