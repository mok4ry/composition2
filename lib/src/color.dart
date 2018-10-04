class Color {
  final String _displayColor;
  final int _hue;
  final int _lightness;

  Color(String this._displayColor, int this._hue, int this._lightness);

  String getDisplayColor() {
    return this._displayColor;
  }

  int getHue() {
    return this._hue;
  }

  int getLightness() {
    return this._lightness;
  }

  bool isEqual(Color c) {
    return this._hue == c.getHue() && this._lightness == c.getLightness();
  }

  String toString() {
    return this._displayColor;
  }
}
