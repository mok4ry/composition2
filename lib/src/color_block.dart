import 'point.dart';
import 'codel.dart';
import 'codel_chooser.dart';
import 'direction_pointer.dart';

int _getY(Point p) {
  return p.getY();
}

int _getX(Point p) {
  return p.getX();
}

bool _greater(int a, int b) {
  return a > b;
}

bool _less(int a, int b) {
  return a < b;
}

List<Codel> _getEdge(List<Codel> block, Function getValue, Function compareValues) {
  List<Codel> edge = [block.first];
  int best = getValue(block.first.getPosition());

  if (block.length == 1) {
    return edge;
  }

  int i, value;
  for (i = 0; i < block.length; i++) {
    value = getValue(block[i].getPosition());

    if (compareValues(value, best)) {
      best = value;
      edge = [block[i]];
    } else if (value == best) {
      edge.add(block[i]);
    }
  }

  return edge;
}

List<Codel> _topEdge(List<Codel> block) {
  return _getEdge(block, _getY, _less);
}

List<Codel> _bottomEdge(List<Codel> block) {
  return _getEdge(block, _getY, _greater);
}

List<Codel> _rightEdge(List<Codel> block) {
  return _getEdge(block, _getX, _greater);
}

List<Codel> _leftEdge(List<Codel> block) {
  return _getEdge(block, _getX, _less);
}

Map<DirectionPointer, Function> dpFns = {
  DirectionPointer.up: _topEdge,
  DirectionPointer.right: _rightEdge,
  DirectionPointer.down: _bottomEdge,
  DirectionPointer.left: _leftEdge
};

Map<DirectionPointer, Map<CodelChooser, Function>> ccFns = {
  DirectionPointer.up: {
    CodelChooser.left: _leftEdge,
    CodelChooser.right: _rightEdge
  },
  DirectionPointer.right: {
    CodelChooser.left: _topEdge,
    CodelChooser.right: _bottomEdge
  },
  DirectionPointer.down: {
    CodelChooser.left: _rightEdge,
    CodelChooser.right: _leftEdge
  },
  DirectionPointer.left: {
    CodelChooser.left: _bottomEdge,
    CodelChooser.right: _topEdge
  },
};

class ColorBlock {
  final List<Codel> _block;
  Map<DirectionPointer, Map<CodelChooser, Codel>> _cache = {
    DirectionPointer.up: {
      CodelChooser.left: null,
      CodelChooser.right: null
    },
    DirectionPointer.right: {
      CodelChooser.left: null,
      CodelChooser.right: null
    },
    DirectionPointer.down: {
      CodelChooser.left: null,
      CodelChooser.right: null
    },
    DirectionPointer.left: {
      CodelChooser.left: null,
      CodelChooser.right: null
    },
  };

  ColorBlock(List<Codel> this._block);

  int size() {
    return _block.length;
  }

  List<Codel> getBlock() {
    return _block;
  }

  Codel getExitBlock(DirectionPointer dp, CodelChooser cc) {
    // TODO should slide through white blocks in direction of dp without considering cc
    if (_cache[dp][cc] == null) {
      _cache[dp][cc] = ccFns[dp][cc](dpFns[dp](_block)).first;
    }

    return _cache[dp][cc];
  }

  String toString() {
    return _block.toString();
  }
}
