import 'codel.dart';
import 'color.dart';
import 'colors.dart';

enum OP_OUTPUT_TYPE { NONE, CHAR, INT }
enum OP_INPUT_TYPE { NONE, CHAR, INT }

// TODO each operation in its own file?

class Noop extends Operation {
  Noop(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return true;
  }

  String errorMessage() {
    return '';
  }

  String operationName() {
    return 'Noop';
  }

  String toString() {
    return 'No operation was performed';
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {}
}

Operation _noop(List<int> stack, Codel source, Codel destination) {
  return Noop(stack, source, destination);
}

class Block extends Operation {
  int _codelChooserIncrement = 0;
  int _directionPointerIncrement = 0;

  Block(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return true;
  }

  String errorMessage() {
    return '';
  }

  String operationName() {
    return 'Block';
  }

  String toString() {
    return 'Execution reached a blocking codel';
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    if (_source.getColor().isEqual(Colors.WHITE)) {
      _directionPointerIncrement = 1;
      _codelChooserIncrement = 1;
    } else if (ccToggled) {
      _directionPointerIncrement = 1;
    } else /* if (dpToggled) or neither toggled */ {
      _codelChooserIncrement = 1;
    }
  }

  int codelChooserIncrement() {
    return _codelChooserIncrement;
  }

  int directionPointerIncrement() {
    return _directionPointerIncrement;
  }
}

class Push extends Operation {
  int _value;

  Push(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return true;
  }

  String errorMessage() {
    return '';
  }

  String operationName() {
    return 'Push';
  }

  String toString() {
    return 'Pushed value onto the stack: $_value';
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _value = _source.getColorBlockSize();
    _stack.add(_value);
  }
}

Operation _push(List<int> stack, Codel source, Codel destination) {
  return Push(stack, source, destination);
}

class Pop extends Operation {
  int _removed;

  Pop(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 0;
  }

  String errorMessage() {
    return 'Attempted to pop from an empty stack';
  }

  String operationName() {
    return 'Pop';
  }

  String toString() {
    return 'Popped and discarded value: $_removed';
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _removed = _stack.removeLast();
  }
}

Operation _pop(List<int> stack, Codel source, Codel destination) {
  return Pop(stack, source, destination);
}

class Add extends Operation {
  int _top;
  int _secondFromTop;
  int _result;

  Add(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 2;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _top = _stack.removeLast();
    _secondFromTop = _stack.removeLast();
    _result = _secondFromTop + _top;

    _stack.add(_result);
  }

  String errorMessage() {
    return 'Attempted to add from stack with less than two values';
  }

  String operationName() {
    return 'Add';
  }

  String toString() {
    return 'Popped values: [$_top, $_secondFromTop] and pushed result: $_result';
  }
}

Operation _add(List<int> stack, Codel source, Codel destination) {
  return Add(stack, source, destination);
}

class Subtract extends Operation {
  int _top;
  int _secondFromTop;
  int _result;

  Subtract(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 2;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _top = _stack.removeLast();
    _secondFromTop = _stack.removeLast();
    _result = _secondFromTop - _top;

    _stack.add(_result);
  }

  String errorMessage() {
    return 'Attempted to subtract from stack with less than two values';
  }

  String operationName() {
    return 'Subtract';
  }

  String toString() {
    return 'Popped values: [$_top, $_secondFromTop] and pushed result: $_result';
  }
}

Operation _subtract(List<int> stack, Codel source, Codel destination) {
  return Subtract(stack, source, destination);
}

class Multiply extends Operation {
  int _top;
  int _secondFromTop;
  int _result;

  Multiply(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 2;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _top = _stack.removeLast();
    _secondFromTop = _stack.removeLast();
    _result = _secondFromTop * _top;

    _stack.add(_result);
  }

  String errorMessage() {
    return 'Attempted to multiply from stack with less than two values';
  }

  String operationName() {
    return 'Multiply';
  }

  String toString() {
    return 'Popped values: [$_top, $_secondFromTop] and pushed result: $_result';
  }
}

Operation _multiply(List<int> stack, Codel source, Codel destination) {
  return Multiply(stack, source, destination);
}

class Divide extends Operation {
  int _top;
  int _secondFromTop;
  int _result;

  Divide(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 2;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _top = _stack.removeLast();
    _secondFromTop = _stack.removeLast();
    _result = (_secondFromTop / _top).floor();

    _stack.add(_result);
  }

  String errorMessage() {
    return 'Attempted to divide from stack with less than two values';
  }

  String operationName() {
    return 'Divide';
  }

  String toString() {
    return 'Popped values: [$_top, $_secondFromTop] and pushed result: $_result';
  }
}

Operation _divide(List<int> stack, Codel source, Codel destination) {
  return Divide(stack, source, destination);
}

class Mod extends Operation {
  int _top;
  int _secondFromTop;
  int _result;

  Mod(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 2 && _stack.last != 0;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _top = _stack.removeLast();
    _secondFromTop = _stack.removeLast();
    _result = _secondFromTop % _top;

    _stack.add(_result);
  }

  String errorMessage() {
    if (_stack.last == 0) {
      return 'Attempted to perform modulus operation with 0 divisor';
    }

    return 'Attempted to perform modulus from stack with less than two values';
  }

  String operationName() {
    return 'Mod';
  }

  String toString() {
    return 'Popped values: [$_top, $_secondFromTop] and pushed result: $_result';
  }
}

Operation _mod(List<int> stack, Codel source, Codel destination) {
  return Mod(stack, source, destination);
}

class Not extends Operation {
  int _top;
  int _result;

  Not(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 1;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _top = _stack.removeLast();
    _result = _top == 0 ? 1 : 0;

    _stack.add(_result);
  }

  String errorMessage() {
    return 'Attempted to invert from stack with no values';
  }

  String operationName() {
    return 'Not';
  }

  String toString() {
    return 'Popped value: $_top and pushed result: $_result';
  }
}

Operation _not(List<int> stack, Codel source, Codel destination) {
  return Not(stack, source, destination);
}

class Greater extends Operation {
  int _top;
  int _secondFromTop;
  int _result;

  Greater(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 2;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _top = _stack.removeLast();
    _secondFromTop = _stack.removeLast();
    _result = _secondFromTop > _top ? 1 : 0;

    _stack.add(_result);
  }

  String errorMessage() {
    return 'Attempted to compare from stack with less than two values';
  }

  String operationName() {
    return 'Greater';
  }

  String toString() {
    return 'Popped values: [$_top, $_secondFromTop] and pushed result: $_result';
  }
}

Operation _greater(List<int> stack, Codel source, Codel destination) {
  return Greater(stack, source, destination);
}

class Pointer extends Operation {
  int _directionPointerIncrement = 0;

  Pointer(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 1;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _directionPointerIncrement = _stack.removeLast();
  }

  int directionPointerIncrement() {
    return _directionPointerIncrement;
  }

  String errorMessage() {
    return 'Attempted to rotate direction pointer from stack with no values';
  }

  String operationName() {
    return 'Pointer';
  }

  String toString() {
    return 'Popped value $_directionPointerIncrement and rotated direction pointer by that amount';
  }
}

Operation _pointer(List<int> stack, Codel source, Codel destination) {
  return Pointer(stack, source, destination);
}

class Switch extends Operation {
  int _codelChooserIncrement = 0;

  Switch(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 1;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _codelChooserIncrement = _stack.removeLast();
  }

  int codelChooserIncrement() {
    return _codelChooserIncrement;
  }

  String errorMessage() {
    return 'Attempted to flip codel chooser from stack with no values';
  }

  String operationName() {
    return 'Switch';
  }

  String toString() {
    return 'Popped value $_codelChooserIncrement and flipped codel chooser that many times';
  }
}

Operation _switch(List<int> stack, Codel source, Codel destination) {
  return Switch(stack, source, destination);
}

class Duplicate extends Operation {
  int _result;

  Duplicate(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 1;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _result = _stack.last;
    _stack.add(_result);
  }

  String errorMessage() {
    return 'Attempted to duplicate value from stack with no values';
  }

  String operationName() {
    return 'Duplicate';
  }

  String toString() {
    return 'Pushed value $_result onto stack';
  }
}

Operation _duplicate(List<int> stack, Codel source, Codel destination) {
  return Duplicate(stack, source, destination);
}

class Roll extends Operation {
  int _rolls;
  int _depth;

  Roll(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    int depth = _stack.elementAt(_stack.length - 2);
    return _stack.length > 2 && depth >= 0 && depth.abs() < _stack.length - 2;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _rolls = _stack.removeLast();
    _depth = _stack.removeLast();

    int depth;
    int rolls = _rolls.abs();

    if (_rolls < 0) {
      depth = _depth;
    } else {
      depth = _stack.length - _depth - 1;
    }

    for (int i = 0; i < rolls; i++) {
      _stack.insert(depth, _stack.removeLast());
    }
  }

  String errorMessage() {
    if (_depth < 0) {
      return 'Roll called with negative depth';
    } else if (_depth.abs() >= _stack.length - 2) {
      return 'Roll called with depth of greater magnitude than remaining stack size';
    }

    return 'Roll called on stack with less than three elements';
  }

  String operationName() {
    return 'Roll';
  }

  String toString() {
    return 'Rolled $_rolls times to depth $_depth';
  }
}

Operation _roll(List<int> stack, Codel source, Codel destination) {
  return Roll(stack, source, destination);
}

class InputInteger extends Operation {
  int _input = null;
  String _error = '';

  InputInteger(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return true;
  }

  OP_INPUT_TYPE inputType() {
    return OP_INPUT_TYPE.INT;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    if (intInput == null) {
      _error = 'No input received to integer input operation';
      return;
    }

    _input = intInput;
    _stack.add(_input);
  }

  String errorMessage() {
    return _error;
  }

  String operationName() {
    return 'InputInteger';
  }

  String toString() {
    return 'Accepted integer input $_input and pushed to stack';
  }
}

Operation _inputInteger(List<int> stack, Codel source, Codel destination) {
  return InputInteger(stack, source, destination);
}

class InputChar extends Operation {
  String _input = null;
  int _intValue = null;
  String _error = '';

  InputChar(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return true;
  }

  OP_INPUT_TYPE inputType() {
    return OP_INPUT_TYPE.CHAR;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    if (charInput == null) {
      _error = 'No input received to character input operation';
      return;
    }

    _input = charInput;
    _intValue = _input.codeUnitAt(0);
    _stack.add(_intValue);
  }

  String errorMessage() {
    return _error;
  }

  String operationName() {
    return 'InputChar';
  }

  String toString() {
    return 'Accepted character input $_input and pushed to stack as integer $_intValue';
  }
}

Operation _inputChar(List<int> stack, Codel source, Codel destination) {
  return InputChar(stack, source, destination);
}

class OutputInteger extends Operation {
  int _output = null;

  OutputInteger(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 0;
  }

  OP_OUTPUT_TYPE outputType() {
    return OP_OUTPUT_TYPE.INT;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _output = _stack.removeLast();
  }

  int intOutput() {
    return _output;
  }

  String errorMessage() {
    return 'Attempted to output integer from empty stack';
  }

  String operationName() {
    return 'OutputInteger';
  }

  String toString() {
    return 'Popped value $_output from stack and made available for output';
  }
}

Operation _outputInteger(List<int> stack, Codel source, Codel destination) {
  return OutputInteger(stack, source, destination);
}

class OutputChar extends Operation {
  int _outputInt = null;
  String _outputChar = '';

  OutputChar(List<int> stack, Codel source, Codel destination) : super._internal(stack, source, destination);

  bool isValid() {
    return _stack.length > 0;
  }

  OP_OUTPUT_TYPE outputType() {
    return OP_OUTPUT_TYPE.CHAR;
  }

  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled }) {
    _outputInt = _stack.removeLast();
    _outputChar = String.fromCharCode(_outputInt);
  }

  String charOutput() {
    return _outputChar;
  }

  String errorMessage() {
    return 'Attempted to output character from empty stack';
  }

  String operationName() {
    return 'OutputChar';
  }

  String toString() {
    return 'Popped value $_outputInt from stack and made available for output as character "$_outputChar"';
  }
}

Operation _outputChar(List<int> stack, Codel source, Codel destination) {
  return OutputChar(stack, source, destination);
}

// TODO better way to do this? List<List<Operation constructor>>?
List<List<Function>> OPERATIONS = [
  [ _noop, _push, _pop ],
  [ _add, _subtract, _multiply ],
  [ _divide, _mod, _not ],
  [ _greater, _pointer, _switch ],
  [ _duplicate, _roll, _inputInteger ],
  [ _inputChar, _outputInteger, _outputChar],
];

abstract class Operation {
  final List<int> _stack;
  final Codel _source;
  final Codel _destination;

  Operation._internal(this._stack, this._source, this._destination);

  factory Operation(List<int> stack, Codel source, Codel destination) {
    Color sourceColor = source.getColor();
    Color destinationColor = destination.getColor();

    if (destinationColor.isEqual(Colors.BLACK)) {
      return Block(stack, source, destination);
    }

    if (sourceColor.isEqual(Colors.WHITE)) {
      return Noop(stack, source, destination);
    }

    int hue = destinationColor.getHue() - sourceColor.getHue();
    int lightness = destinationColor.getLightness() - sourceColor.getLightness();

    return OPERATIONS[hue % 6][lightness % 3](stack, source, destination);
  }

  // abstract - must override
  bool isValid();
  String errorMessage();
  String operationName();
  String toString();
  void execute({ int intInput, String charInput, bool ccToggled, bool dpToggled });

  // concrete - override as needed
  OP_INPUT_TYPE inputType() {
    return OP_INPUT_TYPE.NONE;
  }

  OP_OUTPUT_TYPE outputType() {
    return OP_OUTPUT_TYPE.NONE;
  }

  String charOutput() {
    return '';
  }

  int intOutput() {
    return 0;
  }

  int codelChooserIncrement() {
    return 0;
  }

  int directionPointerIncrement() {
    return 0;
  }

  List<int> stack() {
    return _stack;
  }

  Codel source() {
    return _source;
  }

  Codel destination() {
    return _destination;
  }
}
