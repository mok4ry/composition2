import 'package:test/test.dart';
import 'package:composition2/src/color_block.dart';
import 'package:composition2/src/codel.dart';
import 'package:composition2/src/colors.dart';
import 'package:composition2/src/point.dart';
import 'package:composition2/src/direction_pointer.dart';
import 'package:composition2/src/codel_chooser.dart';

final ColorBlock block_3x3_white = ColorBlock([
  Codel(Colors.WHITE)..setPosition(Point(0, 0)), Codel(Colors.WHITE)..setPosition(Point(1, 0)), Codel(Colors.WHITE)..setPosition(Point(2, 0)),
  Codel(Colors.WHITE)..setPosition(Point(0, 1)), Codel(Colors.WHITE)..setPosition(Point(1, 1)), Codel(Colors.WHITE)..setPosition(Point(2, 1)),
  Codel(Colors.WHITE)..setPosition(Point(0, 2)), Codel(Colors.WHITE)..setPosition(Point(1, 2)), Codel(Colors.WHITE)..setPosition(Point(2, 2))
]);

final ColorBlock block_3x3_blue = ColorBlock([
  Codel(Colors.BLUE)..setPosition(Point(0, 0)), Codel(Colors.BLUE)..setPosition(Point(1, 0)), Codel(Colors.BLUE)..setPosition(Point(2, 0)),
  Codel(Colors.BLUE)..setPosition(Point(0, 1)), Codel(Colors.BLUE)..setPosition(Point(1, 1)), Codel(Colors.BLUE)..setPosition(Point(2, 1)),
  Codel(Colors.BLUE)..setPosition(Point(0, 2)), Codel(Colors.BLUE)..setPosition(Point(1, 2)), Codel(Colors.BLUE)..setPosition(Point(2, 2))
]);

void size_tests() {
  test('size 1x1', () {
    List<Codel> block = [Codel(Colors.WHITE)];
    ColorBlock colorBlock = ColorBlock(block);

    expect(colorBlock.size(), equals(1));
  });

  test('size 3x3', () {
    expect(block_3x3_white.size(), equals(9));
  });
}

void getExitBlock_tests() {
  test('dp up, cc left', () {
    Codel exitBlock = block_3x3_blue.getExitBlock(DirectionPointer.up, CodelChooser.left);

    expect(exitBlock.getPosition(), equals(Point(0, 0)));
  });

  test('dp up, cc right', () {
    Codel exitBlock = block_3x3_blue.getExitBlock(DirectionPointer.up, CodelChooser.right);

    expect(exitBlock.getPosition(), equals(Point(2, 0)));
  });

  test('dp right, cc left', () {
    Codel exitBlock = block_3x3_blue.getExitBlock(DirectionPointer.right, CodelChooser.left);

    expect(exitBlock.getPosition(), equals(Point(2, 0)));
  });

  test('dp right, cc right', () {
    Codel exitBlock = block_3x3_blue.getExitBlock(DirectionPointer.right, CodelChooser.right);

    expect(exitBlock.getPosition(), equals(Point(2, 2)));
  });

  test('dp down, cc left', () {
    Codel exitBlock = block_3x3_blue.getExitBlock(DirectionPointer.down, CodelChooser.left);

    expect(exitBlock.getPosition(), equals(Point(2, 2)));
  });

  test('dp down, cc right', () {
    Codel exitBlock = block_3x3_blue.getExitBlock(DirectionPointer.down, CodelChooser.right);

    expect(exitBlock.getPosition(), equals(Point(0, 2)));
  });

  test('dp left, cc left', () {
    Codel exitBlock = block_3x3_blue.getExitBlock(DirectionPointer.left, CodelChooser.left);

    expect(exitBlock.getPosition(), equals(Point(0, 2)));
  });

  test('dp left, cc right', () {
    Codel exitBlock = block_3x3_blue.getExitBlock(DirectionPointer.left, CodelChooser.right);

    expect(exitBlock.getPosition(), equals(Point(0, 0)));
  });
}

void color_block_all_tests() {
  size_tests();
  getExitBlock_tests();
}

void main() {
  color_block_all_tests();
}
