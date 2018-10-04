import 'package:composition2/src/color.dart';

class Codel {
  final Color color;
  int colorBlockSize = 0;

  Codel(Color this.color);

  void setColorBlockSize(int size) {
    this.colorBlockSize = size;
  }

  int getColorBlockSize() {
    return this.colorBlockSize;
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