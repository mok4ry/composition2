import 'codel_grid.dart';
import 'composition_runner.dart';

class Composition {
  CodelGrid _grid;
  CompositionRunner _runner = null;
  bool _initialized = false;

  Composition({ int width, int height }) {
    int w = width;
    int h = height;
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
