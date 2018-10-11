import 'package:test/test.dart';
import 'package:composition2/src/color_block.dart';
import 'package:composition2/src/codel.dart';
import 'package:composition2/src/colors.dart';
import 'package:composition2/src/point.dart';
import 'package:composition2/src/direction_pointer.dart';
import 'package:composition2/src/codel_chooser.dart';

final ColorBlock block_3x3 = ColorBlock([
  Codel(Colors.WHITE)..setPosition(Point(0, 0)), Codel(Colors.WHITE)..setPosition(Point(1, 0)), Codel(Colors.WHITE)..setPosition(Point(2, 0)),
  Codel(Colors.WHITE)..setPosition(Point(0, 1)), Codel(Colors.WHITE)..setPosition(Point(1, 1)), Codel(Colors.WHITE)..setPosition(Point(2, 1)),
  Codel(Colors.WHITE)..setPosition(Point(0, 2)), Codel(Colors.WHITE)..setPosition(Point(1, 2)), Codel(Colors.WHITE)..setPosition(Point(2, 2))
]);

void size_tests() {
  test('size', () {
    List<Codel> block = [Codel(Colors.WHITE)];
    ColorBlock colorBlock = ColorBlock(block);

    expect(colorBlock.size(), equals(1));
  });
}

void getExistBlock_tests() {
  test('dp up, cc left', () {
    Codel exitBlock = block_3x3.getExitBlock(DirectionPointer.up, CodelChooser.left);

    expect(exitBlock.getPosition(), equals(Point(0, 0)));
  });

  test('dp up, cc right', () {
    Codel exitBlock = block_3x3.getExitBlock(DirectionPointer.up, CodelChooser.right);

    expect(exitBlock.getPosition(), equals(Point(2, 0)));
  });

  test('dp right, cc left', () {
    Codel exitBlock = block_3x3.getExitBlock(DirectionPointer.right, CodelChooser.left);

    expect(exitBlock.getPosition(), equals(Point(2, 0)));
  });

  test('dp right, cc right', () {
    Codel exitBlock = block_3x3.getExitBlock(DirectionPointer.right, CodelChooser.right);

    expect(exitBlock.getPosition(), equals(Point(2, 2)));
  });

  test('dp down, cc left', () {
    Codel exitBlock = block_3x3.getExitBlock(DirectionPointer.down, CodelChooser.left);

    expect(exitBlock.getPosition(), equals(Point(2, 2)));
  });

  test('dp down, cc right', () {
    Codel exitBlock = block_3x3.getExitBlock(DirectionPointer.down, CodelChooser.right);

    expect(exitBlock.getPosition(), equals(Point(0, 2)));
  });

  test('dp left, cc left', () {
    Codel exitBlock = block_3x3.getExitBlock(DirectionPointer.left, CodelChooser.left);

    expect(exitBlock.getPosition(), equals(Point(0, 2)));
  });

  test('dp left, cc right', () {
    Codel exitBlock = block_3x3.getExitBlock(DirectionPointer.left, CodelChooser.right);

    expect(exitBlock.getPosition(), equals(Point(0, 0)));
  });
}

void color_block_all_tests() {
  size_tests();
  getExistBlock_tests();
}

void main() {
  color_block_all_tests();
}
