import 'package:composition2/src/codel.dart';
import 'package:composition2/src/color.dart';
import 'package:composition2/src/colors.dart';
import 'package:composition2/src/point.dart';
import 'package:composition2/src/color_block.dart';

Color DEFAULT_COLOR = Colors.WHITE;
const int DEFAULT_WIDTH = 20;
const int DEFAULT_HEIGHT = 20;

class CodelGrid {
  int _width;
  int _height;
  Color _defaultColor;
  List<List<Codel>> _grid;
  List<ColorBlock> _colorBlocks;

  CodelGrid({ Color defaultColor, int width, int height }) {
    _defaultColor = defaultColor == null ? DEFAULT_COLOR : defaultColor;
    _width = width == null ? DEFAULT_WIDTH : width;
    _height = height == null ? DEFAULT_HEIGHT : height;
    _colorBlocks = List<ColorBlock>();

    _grid = List<List<Codel>>.generate(_width, (int i) => List<Codel>.generate(this._height, (int i) => Codel(_defaultColor)));
  }

  void setCodel(Codel c, Point p) {
    c.setPosition(p);
    _grid[p.getX()][p.getY()] = c;
  }

  Codel getCodel(Point p) {
    return _grid[p.getX()][p.getY()];
  }

  bool isInBounds(Point p) {
    int x = p.getX();
    int y = p.getY();

    return x >= 0 && x < _width && y >= 0 && y < _height;
  }

  List<Codel> _getColorBlock(Point position, Set visited, Color color) {
    List<Codel> colorBlock = List<Codel>();
    Codel codel = getCodel(position);

    if (!color.isEqual(codel.getColor())) {
      return colorBlock;
    }

    colorBlock.add(codel);
    visited.add(position);

    Point above = position.getRelative(0, -1);
    if (isInBounds(above) && !visited.contains(above)) {
      colorBlock.addAll(_getColorBlock(above, visited, color));
    }

    Point right = position.getRelative(1, 0);
    if (isInBounds(right) && !visited.contains(right)) {
      colorBlock.addAll(_getColorBlock(right, visited, color));
    }

    Point below = position.getRelative(0, 1);
    if (isInBounds(below) && !visited.contains(below)) {
      colorBlock.addAll(_getColorBlock(below, visited, color));
    }

    Point left = position.getRelative(-1, 0);
    if (isInBounds(left) && !visited.contains(left)) {
      colorBlock.addAll(_getColorBlock(left, visited, color));
    }

    return colorBlock;
  }

  ColorBlock getColorBlock(Point position) {
    Codel codel = getCodel(position);

    if (codel.colorBlockSet()) {
      return codel.getColorBlock();
    }

    List<Codel> block = _getColorBlock(position, Set(), getCodel(position).getColor());

    ColorBlock colorBlock = ColorBlock(block);
    _colorBlocks.add(colorBlock);
    colorBlock.getBlock().forEach((Codel c) => c.setColorBlock(_colorBlocks.last));

    return colorBlock;
  }

  int getColorBlockSize(Point position) {
    return getColorBlock(position).size();
  }

  bool safeWidth(int newWidth) {
    int difference = newWidth - _width;

    if (difference >= 0) {
      return true;
    }

    bool safe = true;
    while (safe && difference < 0) {
      safe = _grid[_grid.length + difference].every((Codel c) => c.getColor().isEqual(_defaultColor));
      difference++;
    }

    return safe;
  }

  void setWidth(int newWidth) {
    int difference = newWidth - _width;

    while (difference < 0) {
      _grid.removeLast();
      difference++;
    }

    while (difference > 0) {
      _grid.add(List<Codel>.generate(_height, (int i) => Codel(_defaultColor)));
      difference--;
    }

    _width = newWidth;
  }

  int getWidth() {
    return _width;
  }

  bool safeHeight(int newHeight) {
    int difference = newHeight - _height;

    if (difference >= 0) {
      return true;
    }

    int diff = difference;
    int column = 0;
    bool safe = true;
    while (safe && column < _grid.length) {
      while (safe && diff < 0) {
        safe = _grid[column][_grid[column].length + diff].getColor().isEqual(_defaultColor);
        diff++;
      }

      diff = difference;
      column++;
    }

    return safe;
  }

  void setHeight(int newHeight) {
    int difference = newHeight - _height;

    _grid.forEach((List<Codel> column) {
      int diff = difference;

      while (diff < 0) {
        column.removeLast();
        diff++;
      }

      while (diff > 0) {
        column.add(Codel(_defaultColor));
        diff--;
      }
    });

    _height = newHeight;
  }

  int getHeight() {
    return _height;
  }
}
