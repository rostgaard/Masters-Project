library tcc.client.view;

import 'dart:async';
import 'dart:html';

import 'package:libtcc/libtcc.dart' as libtcc;
import 'controller.dart' as controller;
import 'model.dart' as model;
import 'httpclient.dart';

part 'view/panels/view-actors_panel.dart';
part 'view/panels/view-concepts_panel.dart';
part 'view/panels/view-config_panel.dart';
part 'view/panels/view-goals_panel.dart';
part 'view/panels/view-templates_panel.dart';
part 'view/panels/view-tests_panel.dart';
part 'view/panels/view-use_cases_panel.dart';

part 'view/view-actors.dart';
part 'view/view-definitions.dart';
part 'view/view-menu.dart';
part 'view/view-popup.dart';
part 'view/view-test_case.dart';
part 'view/view-ui.dart';
part 'view/view-ui_examples.dart';

part 'view/view-rendered_use_case.dart';
part 'view/view-use_case_entry.dart';
part 'view/view-use_case_block.dart';

/**
 * Panel interface. [_select] method is needed by a [UI] parent to mark it as
 * selected.
 */
abstract class Panel {
  void _select();
}
