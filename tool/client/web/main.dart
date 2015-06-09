// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library tcc.client;

import 'dart:html';
import 'src/view.dart' as View;
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(print);

  /// Verify that we support HTMl5 notifications
  if(Notification.supported) {
    Notification.requestPermission().then((String perm) =>
        Logger.root.info('HTML5 permission ${perm}'));
  } else {
    Logger.root.shout('HTML5 notifications not supported.');
  }

  View.UI ui = new View.UI();
  ui.render();
}