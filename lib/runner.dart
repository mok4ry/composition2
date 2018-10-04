import 'package:composition2/src/codel_grid.dart';
import 'package:composition2/src/codel.dart';
import 'package:composition2/src/colors.dart';
import 'package:composition2/src/operation.dart';

void main() {
  List<int> stack = [7, 8, 9, 10, 0, 5];

  Codel source = Codel(Colors.WHITE);
  Codel destination = Codel(Colors.BLACK);

  source.setColorBlockSize(1);
  destination.setColorBlockSize(1);

  Operation op1 = Roll(stack, source, destination);

  op1.execute();

  print(op1);

  print(stack);
}
