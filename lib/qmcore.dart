library qmcore;

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 12;
  
  static Future<void> qmVersion(var msg) async =>{
    print('current version is:0.0.1'+msg)
  };
  
}
