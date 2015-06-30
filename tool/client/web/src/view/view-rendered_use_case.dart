part of tcc.client.view;

class RenderedUseCase {
  final Element _root;

  final HeadingElement _name = new HeadingElement.h1();
  final ParagraphElement _description = new ParagraphElement();
  final OListElement _scenario = new OListElement();
  final UListElement _preconditions = new UListElement();
  final UListElement _postconditions = new UListElement();
  final OListElement _extensions = new OListElement();

  final HeadingElement _scenarioLabel = new HeadingElement.h2()
    ..text = 'Scenario';

  final HeadingElement _preconditionLabel = new HeadingElement.h2()
    ..text = 'Preconditions';

  final HeadingElement _postconditionLabel = new HeadingElement.h2()
    ..text = 'Postconditions';

  final HeadingElement _extensionsLabel = new HeadingElement.h2()
    ..text = 'Extensions';

  DivElement get element => new DivElement()
    ..classes.add('use-case')
    ;

  void set activeUseCase (libtcc.UseCase uc) {
    _scenario.children = []..addAll(uc.scenario.map(_useCaseEntryToLi));
    _preconditions.children = []..addAll(uc.preconditions.map(_useCaseEntryToLi));
    _postconditions.children = []..addAll(uc.postconditions.map(_useCaseEntryToLi));
    _extensions.children = []..addAll(uc.extensions.map(_useCaseExtensionToLi));

    _root.children = [
      _name..text = uc.name,
      _description..text = uc.description];

    if(_preconditions.children.isNotEmpty) {
      _root.children.addAll([_preconditionLabel,
        _preconditions]);
    }

    if(_postconditions.children.isNotEmpty) {
      _root.children.addAll([_postconditionLabel,
        _postconditions]);
    }

    if(_extensions.children.isNotEmpty) {
      _root.children.addAll([_extensionsLabel,
        _extensions]);
    }

    _root.children.addAll([
      _scenarioLabel,
      _scenario
    ]);
  }

  LIElement _useCaseEntryToLi (libtcc.UseCaseEntry entry) =>
      new LIElement()..text = entry.text;

  UListElement _useCaseExtensionToLi (libtcc.UseCaseExtension extension) =>
      new UListElement()
      ..children = ([]..addAll(extension.entries.map(_useCaseEntryToLi)));

  libtcc.UseCase  get activeUseCase =>
    new libtcc.UseCase(_name.text);


  /**
   * Default constructor.
   */
  RenderedUseCase(this._root);

  /**
   * Replace the selected [RenderedUseCase] with [uc].
   */
  void set selectedUseCase(libtcc.AnalyzedUseCase uc) {
    _name.text = uc.name;
    _description.text = uc.description;
    _scenario.children =
        uc.statements.map(_statementToLI).toList(growable: false);
    _preconditions.children =
        uc.preconditions.map(_predicateToLI).toList(growable: false);
    _postconditions.children =
        uc.postconditions.map(_predicateToLI).toList(growable: false);
  }

  /**
   * Convert a predicate into a visual LI element.
   */
  LIElement _predicateToLI(libtcc.Predicate pred) {
    SpanElement expectationElement = new SpanElement()
      ..text = '${pred.expectation} '
      ..classes.add('expectation');

    SpanElement exprElement = new SpanElement()
      ..text = '${pred.expr} '
      ..classes.add('expression');

    SpanElement matcherElement = new SpanElement()
      ..text = '${pred.matcher} '
      ..classes.add('matcher');

    return new LIElement()
      ..children = [exprElement, matcherElement, expectationElement];
  }

  /**
   * Convert a statement into a visual LI element.
   */
  LIElement _statementToLI(libtcc.Statement stmt) {
    SpanElement actorElement = new SpanElement()
      ..text = '${stmt.actor.role} '
      ..classes.add('actor');

    SpanElement actionElement = new SpanElement()
      ..text = '${stmt.action.name} '
      ..classes.add('action');

    SpanElement objectElement = new SpanElement()
      ..text = '${stmt.object.type} '
      ..classes.add('object');

    return new LIElement()
      ..children = [actorElement, actionElement, objectElement];
  }
}
