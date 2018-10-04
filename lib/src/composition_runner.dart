import 'color.dart';
import 'codel_grid.dart';
import 'codel_chooser.dart';
import 'direction_pointer.dart';
import 'operation.dart';

class CompositionRunner {
  CodelChooser _codelChooser = CodelChooser.left;
  DirectionPointer _directionPointer = DirectionPointer.right;
  List<int> _stack = List<int>();
  CodelGrid _grid;

  CompositionRunner(CodelGrid this._grid);
}
