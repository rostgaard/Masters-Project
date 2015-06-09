// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import '../lib/router.dart';
import 'package:logging/logging.dart';

main() {

  Logger.root.level= Level.ALL;
  Logger.root.onRecord.listen(print);

  start();
}
