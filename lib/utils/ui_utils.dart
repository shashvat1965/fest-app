class UIUtills {
  factory UIUtills() {
    return _singleton;
  }

  static final UIUtills _singleton = UIUtills._internal();

  UIUtills._internal() {
    print("Instance created UIUtills");
  }

//region Screen Size and Proportional according to device
  double? _screenHeight;
  double? _screenWidth;

  final double _refrenceScreenHeight = 926;
  final double _refrenceScreenWidth = 428;

  void updateScreenDimesion({required double width, required double height}) {
    _screenWidth = (width != null) ? width : _screenWidth;
    _screenHeight = (height != null) ? height : _screenHeight;
  }

  double getProportionalHeight({required double height}) {
    if (_screenHeight == null) return height;
    return _screenHeight! * height / _refrenceScreenHeight;
  }

  double getProportionalWidth({required double width}) {
    if (_screenWidth == null) return width;
    var w = _screenWidth! * width / _refrenceScreenWidth;
    return w.ceilToDouble();
  }
}
