import 'package:test/test.dart';
import 'package:composition2/src/operation.dart';
import 'package:composition2/src/codel.dart';
import 'package:composition2/src/colors.dart';

void noop_tests() {
  test('noop does not alter the stack', () {
    List<int> stack = [1, 2, 3, 4];
    Operation noop = Noop(stack, Codel(Colors.WHITE), Codel(Colors.WHITE));

    noop.execute();

    expect(stack, equals([1, 2, 3, 4]));
  });
}

void operation_tests() {
  test('0 hue step, 0 darker results in a noop', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.LIGHT_RED));

    expect(op.operationName(), equals('Noop'));
  });

  test('0 hue step, 1 darker results in a push', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.RED));

    expect(op.operationName(), equals('Push'));
  });

  test('0 hue step, 2 darker results in a pop', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.DARK_RED));

    expect(op.operationName(), equals('Pop'));
  });

  test('1 hue step, 0 darker results in an add', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.LIGHT_YELLOW));

    expect(op.operationName(), equals('Add'));
  });

  test('1 hue step, 1 darker results in a subtract', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.YELLOW));

    expect(op.operationName(), equals('Subtract'));
  });

  test('1 hue step, 2 darker results in a multiply', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.DARK_YELLOW));

    expect(op.operationName(), equals('Multiply'));
  });

  test('2 hue steps, 0 darker results in a divide', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.LIGHT_GREEN));

    expect(op.operationName(), equals('Divide'));
  });

  test('2 hue steps, 1 darker results in a mod', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.GREEN));

    expect(op.operationName(), equals('Mod'));
  });

  test('2 hue steps, 2 darker results in a not', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.DARK_GREEN));

    expect(op.operationName(), equals('Not'));
  });

  test('3 hue steps, 0 darker results in a greater', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.LIGHT_CYAN));

    expect(op.operationName(), equals('Greater'));
  });

  test('3 hue steps, 1 darker results in a pointer', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.CYAN));

    expect(op.operationName(), equals('Pointer'));
  });

  test('3 hue steps, 2 darker results in a switch', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.DARK_CYAN));

    expect(op.operationName(), equals('Switch'));
  });

  test('4 hue steps, 0 darker results in a duplicate', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.LIGHT_BLUE));

    expect(op.operationName(), equals('Duplicate'));
  });

  test('4 hue steps, 1 darker results in a roll', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.BLUE));

    expect(op.operationName(), equals('Roll'));
  });

  test('4 hue steps, 2 darker results in an integer input', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.DARK_BLUE));

    expect(op.operationName(), equals('InputInteger'));
  });

  test('5 hue steps, 0 darker results in a character input', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.LIGHT_MAGENTA));

    expect(op.operationName(), equals('InputChar'));
  });

  test('5 hue steps, 1 darker results in an integer output', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.MAGENTA));

    expect(op.operationName(), equals('OutputInteger'));
  });

  test('5 hue steps, 2 darker results in a character output', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_RED), Codel(Colors.DARK_MAGENTA));

    expect(op.operationName(), equals('OutputChar'));
  });

  // wrap-around tests
  test('4 hue steps, 0 darker results in duplicate (wrap-around)', () {
    Operation op = Operation(List<int>(), Codel(Colors.LIGHT_BLUE), Codel(Colors.LIGHT_GREEN));

    expect(op.operationName(), equals('Duplicate'));
  });

  test('0 hue steps, 1 darker results in push (wrap-around)', () {
    Operation op = Operation(List<int>(), Codel(Colors.DARK_BLUE), Codel(Colors.LIGHT_BLUE));

    expect(op.operationName(), equals('Push'));
  });

  test('1 hue steps, 1 darker results in subtract (wrap-around)', () {
    Operation op = Operation(List<int>(), Codel(Colors.DARK_MAGENTA), Codel(Colors.LIGHT_RED));

    expect(op.operationName(), equals('Subtract'));
  });
}

void operation_all_tests() {
  operation_tests();
  noop_tests();
}

void main() {
  operation_all_tests();
}
