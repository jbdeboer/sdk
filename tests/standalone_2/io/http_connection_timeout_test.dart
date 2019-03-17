// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:async";
import "dart:io";
import "package:expect/expect.dart";

void test() {
  // Bind to a port with a small backlog, so that connections are forced to
  // wait for a bit.
  ServerSocket.bind("127.0.0.1", 0, backlog: 1).then((server) {
    HttpClient client = new HttpClient();
    // Any connection that doesn't connect immediately will fail.
    client.connectionTimeout = Duration(seconds: 0);

    final futures = <Future>[];
    final exceptions = [];

    // Create more than one connection. In most cases, the second connection
    // will fail, but create 10 to ensure at least some will always fail.
    for (int i = 0; i < 10; i++) {
      futures.add(client
          .get("127.0.0.1", server.port, "/")
          .catchError((e) => exceptions.add(e)));
    }

    Future.wait(futures).then((_) {
      print(exceptions);
      Expect.isTrue(
          exceptions.length > 0, "At least one connection should timeout");
      exceptions.forEach((e) =>
          Expect.isTrue(e is SocketException, "should be SocketException"));
    });
  });
}

void main() {
  test();
}
