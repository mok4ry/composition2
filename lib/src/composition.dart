import 'codel_grid.dart';
import 'composition_runner.dart';

int DEFAULT_WIDTH = 20;
int DEFAULT_HEIGHT = 20;

class Composition {
  CodelGrid _grid;
  CompositionRunner _runner = null;

  Composition({ int width, int height }) {
    int w = width == null ? DEFAULT_WIDTH : width;
    int h = height == null ? DEFAULT_HEIGHT : height;
    this._grid = CodelGrid(width: w, height: h);
  }
}
