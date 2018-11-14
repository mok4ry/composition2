class Point {
  final int _x;
  final int _y;

  Point(int this._x, int this._y);

  int getX() {
    return _x;
  }

  int getY() {
    return _y;
  }

  Point getRelative(int deltaX, int deltaY) {
    return Point(_x + deltaX, _y + deltaY);
  }

  int get hashCode {
    // ensuring position (non-zero)
    int x = _x + 1;
    int y = _y + 1;

    // Matthew Szudzik's Elegant Pairing, see: http://szudzik.com/ElegantPairing.pdf
    return (x > y) ? (x * x + x + y) : (y * y + x);
  }

  bool operator == (dynamic other) {
    return other is Point && other.getX() == _x && other.getY() == _y;
  }

  String toString() {
    return '(${_x}, ${_y})';
  }
}
