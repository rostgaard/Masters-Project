part of tcc.client.view;

class UI {
  Element get _title => querySelector('#main .header .title');

  final Menu _menu = new Menu(querySelector('nav#menu'));

  Element get _currentPanel =>
      querySelectorAll('section').firstWhere((Element e) => !e.hidden);

  Element get _activitiesPanel => querySelector('section#activities');

  final libtcc.TestCaseService _service = new libtcc.TestCaseService(
      Uri.parse('http://localhost:7777'), new HttpClient());
  final libtcc.Configuration _configModel = new libtcc.Configuration.initial();


  final model.UINotification _uiNotificationModel = new model.UINotification();

  /// Controllers
  controller.Actor _actorController;
  controller.Config _configController;
  controller.Concept _conceptController;
  controller.Template _templateController;
  controller.UseCase _useCaseController;


  /// Panels
  Popup _popup;
  ActorsPanel _actorsPanel;
  ConceptsPanel _conceptsPanel;
  TestsPanel _testsPanel;
  UseCasesPanel _useCasesPanel;
  GoalsPanel _goalsPanel;
  ConfigPanel _configPanel;
  UIExamples _examplesPanel;
  TemplatesPanel _templatesPanel;

  /**
   * Default constructor.
   */
  UI() {

    _actorController = new controller.Actor(_service, _uiNotificationModel);
    _configController = new controller.Config(_service, _configModel, _uiNotificationModel);
    _conceptController = new controller.Concept(_service, _uiNotificationModel);
    _templateController = new controller.Template(_service, _uiNotificationModel);
    _useCaseController = new controller.UseCase(_service, _uiNotificationModel);

    _actorsPanel = new ActorsPanel(querySelector('section#actors'), _actorController);
    _conceptsPanel = new ConceptsPanel(querySelector('section#concepts'), _conceptController);
    _testsPanel = new TestsPanel(querySelector('section#tests'), _useCaseController, _templateController);
    _useCasesPanel = new UseCasesPanel(querySelector('section#use-cases'), _useCaseController, _conceptController, _actorController);
    _goalsPanel = new GoalsPanel(querySelector('section#goals'), _configController, _service);
    _configPanel = new ConfigPanel(querySelector('section#configuration'), _configController,_configModel);
    _templatesPanel = new TemplatesPanel(querySelector('section#templates'), _templateController);

    _examplesPanel = new UIExamples(querySelector('section#ui-examples'), _conceptController);
    _observers();
  }


  void _observers () {

    _popup= new Popup(_uiNotificationModel);

    _menu.selectItem.listen((MenuItem itemSelected) {
      switch (itemSelected) {
        case MenuItem.actors:
          _select(_actorsPanel, 'Actors');
          break;

        case MenuItem.concepts:
          _select(_conceptsPanel, 'Concepts');
          break;

        case MenuItem.tests:
          _select(_testsPanel, 'Tests');
          break;

        case MenuItem.useCases:
          _select(_useCasesPanel, 'Use Cases');
          break;

        case MenuItem.configuration:
          _select(_configPanel, 'Configuration');
          break;
        case MenuItem.goals:
          _select(_goalsPanel, 'Goals');
          break;

        case MenuItem.activities:
          //FIXME: Not implemented.
          //_select(_activitiesPanel, 'Activities');
          break;

        case MenuItem.templates:
          _select(_templatesPanel, 'Templates');
          break;

        case MenuItem.uiExamples:
          _select(_examplesPanel, 'UI Examples (not real data)');
          break;
      }
    });
  }

  _select(Panel panel, title) {
    _currentPanel.hidden = true;
    panel._select();
    _title.text = title;
  }

//  addUseCase(libtcc.UseCase uc) {
//    LIElement actorToLI(libtcc.Actor actor) => new LIElement()..text = actor.type;
//
//    this._useCasesPanel.appendHtml(uc.toMarkdown());
//    this._actorsPanel.querySelector('ul').children = uc.involvedActors.map(actorToLI).toList(growable: false);
//  }
//
//
//  addUseCaseElement(DivElement element) {
//    this._useCasesPanel.children.add(element);
//  }

  void render() {
    _menu._useCases.click();
//    _service.getDummyUseCase().then((libtcc.UseCase uc) {
//      addUseCase(uc);
//    });
  }
}
