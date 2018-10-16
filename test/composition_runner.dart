import 'package:test/test.dart';
import 'package:composition2/src/composition_runner.dart';
import 'package:composition2/src/codel_grid.dart';
import 'package:composition2/src/colors.dart';

NOOP() {}

void run_tests() {
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
}

void composition_runner_all_tests() {
  run_tests();
}

void main() {
  composition_runner_all_tests();
}