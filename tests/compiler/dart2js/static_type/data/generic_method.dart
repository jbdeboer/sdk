// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class Class1 {
  T method<T>(T t) => t;
}

class Class2<T> {
  @pragma('dart2js:noInline')
  S method<S extends T>() => null;
}

main() {
  genericMethod1(null);
  genericMethod2(null);
  genericMethod3();
}

genericMethod1(c) {
  if (/*dynamic*/ c is Class1) {
    /*Class1*/ c. /*invoke: String*/ method('').length;
  }
}

genericMethod2(c) {
  if (/*dynamic*/ c is! Class1) return;
  /*dynamic*/ c. /*invoke: dynamic*/ method('').length;
}

genericMethod3() {
  dynamic c = new Class2<int>();
  /*Class2<int>*/ c. /*invoke: int*/ method();
}
