import 'package:composition2/src/color_block.dart';
import 'package:composition2/src/codel.dart';
import 'package:composition2/src/colors.dart';
import 'package:composition2/src/operation.dart';

void main() {
  List<int> stack = [7, 8, 9, 10, 0, 5];

  Codel source = Codel(Colors.WHITE);
  Codel destination = Codel(Colors.BLACK);

  source.setColorBlock(ColorBlock([source]));
  destination.setColorBlock(ColorBlock([destination]));

  Operation op1 = Roll(stack, source, destination);

  op1.execute();

  print(op1);

  print(stack);
}
