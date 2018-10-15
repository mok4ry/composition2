import 'dart:async';

import 'point.dart';
import 'color.dart';
import 'codel.dart';
import 'color_block.dart';
import 'codel_grid.dart';
import 'codel_chooser.dart';
import 'direction_pointer.dart';
import 'operation.dart';

// lower bound of delay is 17ms (i.e. ~60hz)
const DELAY_MIN = 17;

int getDeltaX(int x, DirectionPointer dp) {
  if (dp == DirectionPointer.left) {
    return x - 1;
  }

  if (dp == DirectionPointer.right) {
    return x + 1;
  }

  return x;
}

int getDeltaY(int y, DirectionPointer dp) {
  if (dp == DirectionPointer.up) {
    return y - 1;
  }

  if (dp == DirectionPointer.down) {
    return y + 1;
  }

  return y;
}

class CompositionRunner {
  CodelChooser _codelChooser = CodelChooser.left;
  int _ccToggleCount = 0;

  DirectionPointer _directionPointer = DirectionPointer.right;
  int _dpToggleCount = 0;

  Point _position = Point(0, 0);
  List<int> _stack = List<int>();
  CodelGrid _grid;

  Timer _timer = null;
  bool _running = false;

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

  bool running() {
    return _running;
  }

  bool step() {
    Codel exitCodel = _grid.getColorBlock(_position).getExitBlock(
        _directionPointer, _codelChooser);
    Point exitCodelPosition = exitCodel.getPosition();

    Point nextCodelPosition = exitCodelPosition.getRelative(
        getDeltaX(exitCodelPosition.getX(), _directionPointer),
        getDeltaY(exitCodelPosition.getY(), _directionPointer)
    );
    Codel nextCodel = _grid.getCodel(nextCodelPosition);

    Operation operation = Operation(_stack, exitCodel, nextCodel);

    if (!operation.isValid()) {
      print('Error when executing operation: ${operation.operationName()}');
      print('with message: ${operation.errorMessage()}');

      // ignore errors
      return true;
    }

    int intInput = 0;
    String charInput = '';

    if (operation.inputType() == OP_INPUT_TYPE.INT) {
      intInput = _intInput();
    } else if (operation.inputType() == OP_INPUT_TYPE.CHAR) {
      charInput = _charInput();
    }

    operation.execute(intInput: intInput, charInput: charInput, ccToggled: _ccToggleCount > 0, dpToggled: _dpToggleCount > 0);

    if (operation.outputType() == OP_OUTPUT_TYPE.INT) {
      _intOutput(operation.intOutput());
    } else if (operation.outputType() == OP_OUTPUT_TYPE.CHAR) {
      _charOutput(operation.charOutput());
    }

    if (operation.codelChooserIncrement() > 0) {
      _codelChooser = CodelChooser.values[(_codelChooser.index + operation.codelChooserIncrement()) % CodelChooser.values.length];
      if (operation is Switch) {
        _ccToggleCount = 0;
      } else {
        _ccToggleCount++;
      }
    } else {
      _ccToggleCount = 0;
    }

    if (operation.directionPointerIncrement() > 0) {
      _directionPointer = DirectionPointer.values[(_directionPointer.index + operation.directionPointerIncrement()) % DirectionPointer.values.length];
      if (operation is Pointer) {
        _dpToggleCount = 0;
      } else {
        _dpToggleCount++;
      }
    } else {
      _dpToggleCount = 0;
    }

    if ((_ccToggleCount + _dpToggleCount) == 8) {
      print('Program terminates');
      return false;
    }

    print('${operation.operationName()}: ${operation.toString()}');
    return true;
  }

  void run({ int delay, Function stepCallback }) {
    if (running()) {
      return;
    }

    Function stepCb = stepCallback == null ? () => {} : stepCallback;

    if (delay == null || delay == 0) {
      _running = true;
      while(step());
      _running = false;
      return;
    }

    _running = true;

    _timer = Timer.periodic(Duration(milliseconds: (delay < DELAY_MIN ? DELAY_MIN : delay)), (Timer t) {
      if (!running()) {
        t.cancel();
        return;
      }

      if (!step()) {
        t.cancel();
        _running = false;
      }

      stepCb();
    });
  }

  void pause() {
    _running = false;
  }
}
