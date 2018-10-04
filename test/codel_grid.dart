import 'package:test/test.dart';
import 'package:composition2/src/codel_grid.dart';
import 'package:composition2/src/codel.dart';
import 'package:composition2/src/colors.dart';

void set_get_codel_tests() {
  test('set/get codel at same position', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);
    grid.setCodel(Codel(Colors.BLUE), 0, 0);

    expect(grid.getCodel(0, 0).isEqual(Codel(Colors.BLUE)), equals(true));
  });
}

void inBounds_tests() {
  test('in bounds', () {
    CodelGrid grid = CodelGrid(width: 1, height: 1);

    expect(grid.isInBounds(0, 0), equals(true));
  });

  test('out of bounds', () {
    CodelGrid grid = CodelGrid(width: 1, height: 1);

    expect(grid.isInBounds(1, 1), equals(false));
  });
}

void getColorBlock_tests() {
  test('single codel grid', () {
    CodelGrid grid = CodelGrid(width: 1, height: 1);
    grid.setCodel(Codel(Colors.BLUE), 0, 0);
    List<Codel> colorBlock = grid.getColorBlock(0, 0);

    expect(colorBlock.length, equals(1));
    expect(colorBlock.every((c) => c.isEqual(Codel(Colors.BLUE))), equals(true));
  });

  test('block in a row', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);
    grid.setCodel(Codel(Colors.BLUE), 0, 0);
    grid.setCodel(Codel(Colors.BLUE), 0, 1);
    grid.setCodel(Codel(Colors.BLUE), 0, 2);
    List<Codel> colorBlock = grid.getColorBlock(0, 0);

    expect(colorBlock.length, equals(3));
    expect(colorBlock.every((c) => c.isEqual(Codel(Colors.BLUE))), equals(true));
  });

  test('block surrounding white codel', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);
    for (int x = 0; x < 3; x++) {
      for (int y = 0; y < 3; y++) {
        if (y == 1 && x == 1) {
          grid.setCodel(Codel(Colors.WHITE), x, y);
        } else {
          grid.setCodel(Codel(Colors.BLUE), x, y);
        }
      }
    }
    List<Codel> colorBlock = grid.getColorBlock(0, 0);

    expect(colorBlock.length, equals(8));
    expect(colorBlock.every((c) => c.isEqual(Codel(Colors.BLUE))), equals(true));
  });
}

void setWidth_tests() {
  test('same width does not change grid size', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    grid.setWidth(3);
    expect(grid.getColorBlock(0, 0).length, equals(9));
  });

  test('larger width increases grid size', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    grid.setWidth(4);
    expect(grid.getColorBlock(0, 0).length, equals(12));
  });

  test('smaller width decreases grid size', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    grid.setWidth(2);
    expect(grid.getColorBlock(0, 0).length, equals(6));
  });
}

void safeWidth_tests() {
  test('same width, safe', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    expect(grid.safeWidth(3), equals(true));
  });

  test('smaller width, all default color, safe', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    expect(grid.safeWidth(2), equals(true));
  });

  test('smaller width, non-default block, not safe', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    grid.setCodel(Codel(Colors.BLUE), 2, 0);

    expect(grid.safeWidth(2), equals(false));
  });

  test('larger width, all default color, safe', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    expect(grid.safeWidth(4), equals(true));
  });

  test('larger width, non-default block, safe', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    grid.setCodel(Codel(Colors.BLUE), 2, 0);

    expect(grid.safeWidth(4), equals(true));
  });
}

void setHeight_tests() {
  test('same height does not change grid size', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    grid.setHeight(3);
    expect(grid.getColorBlock(0, 0).length, equals(9));
  });

  test('larger height increases grid size', () {
    CodelGrid grid = CodelGrid(width: 3, height: 4);

    grid.setHeight(4);
    expect(grid.getColorBlock(0, 0).length, equals(12));
  });

  test('smaller height decreases grid size', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    grid.setHeight(2);
    expect(grid.getColorBlock(0, 0).length, equals(6));
  });
}

void safeHeight_tests() {
  test('same height, safe', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    expect(grid.safeHeight(3), equals(true));
  });

  test('smaller height, all default color, safe', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    expect(grid.safeHeight(2), equals(true));
  });

  test('smaller height, non-default block, not safe', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    grid.setCodel(Codel(Colors.BLUE), 0, 2);

    expect(grid.safeHeight(2), equals(false));
  });

  test('larger height, all default color, safe', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    expect(grid.safeHeight(4), equals(true));
  });

  test('larger height, non-default block, safe', () {
    CodelGrid grid = CodelGrid(width: 3, height: 3);

    grid.setCodel(Codel(Colors.BLUE), 0, 2);

    expect(grid.safeHeight(4), equals(true));
  });
}

void codel_grid_all_tests() {
  set_get_codel_tests();
  inBounds_tests();
  getColorBlock_tests();
  setWidth_tests();
  safeWidth_tests();
  setHeight_tests();
  safeHeight_tests();
}

void main() {
  codel_grid_all_tests();
}
