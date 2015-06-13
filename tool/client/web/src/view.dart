library tcc.client.view;

import 'dart:async';
import 'dart:html';

import 'package:libtcc/libtcc.dart' as libtcc;
import 'controller.dart' as controller;
import 'model.dart' as model;
import 'httpclient.dart';

part 'view/view-actors_panel.dart';
part 'view/view-concepts_panel.dart';
part 'view/view-config_panel.dart';
part 'view/view-goals_panel.dart';
part 'view/view-menu.dart';
part 'view/view-popup.dart';
part 'view/view-tests_panel.dart';
part 'view/view-test_case.dart';
part 'view/view-ui.dart';
part 'view/view-ui_examples.dart';
part 'view/view-use_case.dart';
part 'view/view-use_cases_panel.dart';
part 'view/view-use_case_entry.dart';
part 'view/view-use_case_block.dart';
part 'view/view-use_case_selector.dart';

/**
 * Panel interface. [_select] method is needed by a [UI] parent to mark it as
 * selected.
 */
abstract class Panel {
  void _select();
}
