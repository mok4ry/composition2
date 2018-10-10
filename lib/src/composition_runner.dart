import 'point.dart';
import 'color.dart';
import 'codel_grid.dart';
import 'codel_chooser.dart';
import 'direction_pointer.dart';
import 'operation.dart';

class CompositionRunner {
  CodelChooser _codelChooser = CodelChooser.left;
  DirectionPointer _directionPointer = DirectionPointer.right;
  Point position = Point(0, 0);
  List<int> _stack = List<int>();
  CodelGrid _grid;

  Function _intInput;
  Function _charInput;
  Function _intOutput;
  Function _charOutput;

  CompositionRunner(
    CodelGrid this._grid,
    Function this._intInput,
    Function this._charInput,
    Function this._intOutput,
    Function this._charOutput
  );

  bool step() {

  }

  void run({ int delay, Function stepCallback }) {

  }
}
