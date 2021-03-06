// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class A {}

main() {
  conditionNullElse(null);
  conditionNullThen(null);
}

conditionNullElse(dynamic o) {
  /*{}*/ o;
  /*{}*/ o is A ? /*{o:[{true:A}|A]}*/ o : null;
  /*{}*/ o;
}

conditionNullThen(dynamic o) {
  /*{}*/ o;
  /*{}*/ o is! A ? null : /*{o:[{true:A}|A]}*/ o;
  /*{}*/ o;
}
