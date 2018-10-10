import 'package:composition2/src/color.dart';

class Codel {
  final Color color;
  List<Codel> _colorBlock = List<Codel>();
  int _x = 0;
  int _y = 0;

  Codel(Color this.color);

  void setCoords(int x, int y) {
    setX(x);
    setY(y);
  }

  void setX(int x) {
    _x = x;
  }

  int getX() {
    return _x;
  }

  void setY(int y) {
    _y = y;
  }

  int getY() {
    return _y;
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