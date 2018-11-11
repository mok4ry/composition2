import 'dart:async';

import 'point.dart';
import 'colors.dart';
import 'codel.dart';
import 'codel_grid.dart';
import 'codel_chooser.dart';
import 'direction_pointer.dart';
import 'operation.dart';

// lower bound of delay is 17ms (i.e. ~60hz)
const DELAY_MIN = 17;

int getDeltaX(DirectionPointer dp) {
  if (dp == DirectionPointer.left) {
    return -1;
  }

  if (dp == DirectionPointer.right) {
    return 1;
  }

  return 0;
}

int getDeltaY(DirectionPointer dp) {
  if (dp == DirectionPointer.up) {
    return -1;
  }

  if (dp == DirectionPointer.down) {
    return 1;
  }

  return 0;
}

class CompositionRunner {
  CodelChooser _codelChooser = CodelChooser.left;
  int _ccToggleCount = 0;
  bool _ccToggled = false;

  DirectionPointer _directionPointer = DirectionPointer.right;
  int _dpToggleCount = 0;
  bool _dpToggled = false;

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

  void ccToggle(bool directlyToggled, bool toggled) {
    _ccToggled = toggled && !directlyToggled;

    if (directlyToggled) {
      _ccToggleCount = 0;
    } else if (toggled) {
      _ccToggleCount++;
    }
  }

  void dpToggle(bool directlyToggled, bool toggled) {
    _dpToggled = toggled && !directlyToggled;

    if (directlyToggled) {
      _dpToggleCount = 0;
    } else if (toggled) {
      _dpToggleCount++;
    }
  }

  bool step() {
    Codel exitCodel = _grid.getColorBlock(_position).getExitCodel(_position, _directionPointer, _codelChooser);
    Point exitCodelPosition = exitCodel.getPosition();

    Point nextCodelPosition = exitCodelPosition.getRelative(
        getDeltaX(_directionPointer),
        getDeltaY(_directionPointer)
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

    operation.execute(intInput: intInput, charInput: charInput, ccToggled: _ccToggled, dpToggled: _dpToggled);

    if (operation.outputType() == OP_OUTPUT_TYPE.INT) {
      _intOutput(operation.intOutput());
    } else if (operation.outputType() == OP_OUTPUT_TYPE.CHAR) {
      _charOutput(operation.charOutput());
    }

    bool ccToggled = operation.codelChooserIncrement() > 0;
    bool dpToggled = operation.directionPointerIncrement() > 0;
    if (ccToggled || dpToggled) {
      _codelChooser = CodelChooser.values[(_codelChooser.index + operation.codelChooserIncrement()) % CodelChooser.values.length];
      _directionPointer = DirectionPointer.values[(_directionPointer.index + operation.directionPointerIncrement()) % DirectionPointer.values.length];

      ccToggle(operation is Switch, ccToggled);
      dpToggle(operation is Pointer, dpToggled);
    } else {
      ccToggle(false, false);
      dpToggle(false, false);
    }

    if ((_ccToggleCount + _dpToggleCount) == 8) {
      print('Program terminates in trapped execution');
      return false;
    }

    if (operation is Block) {
      _position = exitCodelPosition;
    } else {
      _position = nextCodelPosition;
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

  String toString() {
    return """
      Position: $_position (${_grid.getCodel(_position)})
      CC: $_codelChooser ($_ccToggleCount $_ccToggled)
      DP: $_directionPointer ($_dpToggleCount $_dpToggled)
      Stack: $_stack
    """;
  }
}
