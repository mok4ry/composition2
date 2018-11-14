import 'package:test/test.dart';
import 'package:composition2/src/composition_runner.dart';
import 'package:composition2/src/codel_grid.dart';
import 'package:composition2/src/codel.dart';
import 'package:composition2/src/point.dart';
import 'package:composition2/src/colors.dart';

NOOP() {}

class IOWrapper {
  List<String> _input = List<String>();
  List<String> _charOut = List<String>();
  List<int> _intOut = List<int>();

  IOWrapper({ String input }) {
    if (input != null) {
      _input = input.split('').reversed.toList();
    }
  }

  String getCharOutput() {
    return _charOut.join('');
  }

  List<int> getIntOutput() {
    return _intOut;
  }

  void charOutput(String c) {
    _charOut.add(c);
  }

  void intOutput(int i) {
    _intOut.add(i);
  }

  String charInput() {
    return _input.removeLast();
  }

  int intInput() {
    return int.parse(_input.removeLast());
  }
}

void step_tests() {
  test('solid block, terminates in 8 operations', () {
    CodelGrid grid = CodelGrid(defaultColor: Colors.BLUE, width: 3, height: 3);
    CompositionRunner runner = CompositionRunner(grid, NOOP, NOOP, NOOP, NOOP);

    expect(runner.step(), equals(true));
    expect(runner.step(), equals(true));
    expect(runner.step(), equals(true));
    expect(runner.step(), equals(true));
    expect(runner.step(), equals(true));
    expect(runner.step(), equals(true));
    expect(runner.step(), equals(true));
    expect(runner.step(), equals(false));
  });

  test('all white, terminates in 4 operations', () {
    CodelGrid grid = CodelGrid(defaultColor: Colors.WHITE, width: 3, height: 3);
    CompositionRunner runner = CompositionRunner(grid, NOOP, NOOP, NOOP, NOOP);

    expect(runner.step(), equals(true));
    expect(runner.step(), equals(true));
    expect(runner.step(), equals(true));
    expect(runner.step(), equals(false));
  });

  test('push int value and output', () {
    CodelGrid grid = CodelGrid(width: 3, height: 1);
    IOWrapper io = IOWrapper();
    CompositionRunner runner = CompositionRunner(grid, io.intInput, io.charInput, io.intOutput, io.charOutput);

    grid.setCodel(Codel(Colors.BLUE), Point(0, 0));
    grid.setCodel(Codel(Colors.DARK_BLUE), Point(1, 0));
    grid.setCodel(Codel(Colors.LIGHT_CYAN), Point(2, 0));

    expect(runner.step(), equals(true));
    expect(runner.step(), equals(true));
    expect(io.getIntOutput().first, equals(1));
  });
}

void composition_runner_all_tests() {
  step_tests();
}

void main() {
  composition_runner_all_tests();
}