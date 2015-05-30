// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

void main() {
  var output = querySelector('#output')
    ..text = 'Your Dart app is running.';

  querySelector('nav a.actors').onClick.listen((_) => output.text = 'actors');
  querySelector('nav a.concepts').onClick.listen((_) => output.text = 'concepts');
}
