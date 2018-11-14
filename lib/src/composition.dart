import 'codel_grid.dart';
import 'composition_runner.dart';

int DEFAULT_WIDTH = 20;
int DEFAULT_HEIGHT = 20;

class Composition {
  CodelGrid _grid;
  CompositionRunner _runner = null;
  bool _initialized = false;

  Composition({ int width, int height }) {
    int w = width == null ? DEFAULT_WIDTH : width;
    int h = height == null ? DEFAULT_HEIGHT : height;
    this._grid = CodelGrid(width: w, height: h);
  }

  void init(Function intInput, Function intOutput, Function charInput, Function charOutput) {
    _runner = CompositionRunner(_grid, intInput, charInput, intOutput, charOutput);
    _initialized = true;
  }

  bool initialized() {
    return _initialized;
  }

  CompositionRunner runner() {
    return _runner;
  }
}
