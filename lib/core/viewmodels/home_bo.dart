import 'dart:async';

abstract class HomeBo {
  StreamController<int> totalNewBookCount = StreamController<int>();
  Future<int> getTotalNewBookTest();
}

class HomeBoImpl extends HomeBo {
  Future<int> getTotalNewBookTest() {
    return Future.delayed(Duration(seconds: 3), () => 18);
  }
}
