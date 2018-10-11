import 'codel.dart';
import 'codel_chooser.dart';
import 'direction_pointer.dart';

class ColorBlock {
  final List<Codel> _block;
  List<List<CodelChooser>> _cache;

  ColorBlock(List<Codel> this._block);

  int size() {
    return _block.length;
  }

  List<Codel> getBlock() {
    return _block;
  }
}
