import 'package:composition2/src/codel.dart';
import 'package:composition2/src/color.dart';
import 'package:composition2/src/colors.dart';

String getCoordId(int x, int y) => '${x},${y}';

Color DEFAULT_COLOR = Colors.WHITE;
const int DEFAULT_WIDTH = 20;
const int DEFAULT_HEIGHT = 20;

class CodelGrid {
  int _width;
  int _height;
  Color _defaultColor;
  List<List<Codel>> _grid;

  CodelGrid({ Color defaultColor, int width, int height }) {
    _defaultColor = defaultColor == null ? DEFAULT_COLOR : defaultColor;
    _width = width == null ? DEFAULT_WIDTH : width;
    _height = height == null ? DEFAULT_HEIGHT : height;

    _grid = List<List<Codel>>.generate(_width, (int i) => List<Codel>.generate(this._height, (int i) => Codel(_defaultColor)));
  }

  void setCodel(Codel c, int x, int y) {
    _grid[x][y] = c;
  }

  Codel getCodel(int x, int y) {
    return _grid[x][y];
  }

  bool isInBounds(int x, int y) {
    return x >= 0 && x < _width && y >= 0 && y < _height;
  }

  List<Codel> _getColorBlock(int x, int y, Map visited, Color color) {
    List<Codel> colorBlock = List<Codel>();
    Codel codel = getCodel(x, y);

    if (!color.isEqual(codel.getColor())) {
      return colorBlock;
    }

    colorBlock.add(codel);
    visited[getCoordId(x, y)] = true;

    if (isInBounds(x, y - 1) && !visited.containsKey(getCoordId(x, y - 1))) {
      colorBlock.addAll(_getColorBlock(x, y - 1, visited, color));
    }

    if (isInBounds(x + 1, y) && !visited.containsKey(getCoordId(x + 1, y))) {
      colorBlock.addAll(_getColorBlock(x + 1, y, visited, color));
    }

    if (isInBounds(x, y + 1) && !visited.containsKey(getCoordId(x, y + 1))) {
      colorBlock.addAll(_getColorBlock(x, y + 1, visited, color));
    }

    if (isInBounds(x - 1, y) && !visited.containsKey(getCoordId(x - 1, y))) {
      colorBlock.addAll(_getColorBlock(x - 1, y, visited, color));
    }

    return colorBlock;
  }

  List<Codel> getColorBlock(int x, int y) {
    return _getColorBlock(x, y, Map(), getCodel(x, y).getColor());
  }

  int getColorBlockSize(int x, int y) {
    Codel codel = getCodel(x, y);
    int cachedSize = codel.getColorBlockSize();

    if (cachedSize > 0) {
      return cachedSize;
    }

    List<Codel> colorBlock = getColorBlock(x, y);
    colorBlock.forEach((Codel c) => c.setColorBlockSize(colorBlock.length));

    return codel.getColorBlockSize();
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
