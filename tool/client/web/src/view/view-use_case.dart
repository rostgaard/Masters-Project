part of tcc.client.view;

class UseCase {
  final HeadingElement _name = new HeadingElement.h1();
  final ParagraphElement _description = new ParagraphElement();
  final UListElement _scenario = new UListElement();
  final UListElement _preconditions = new UListElement();
  final UListElement _postconditions = new UListElement();

  final HeadingElement scenarioLabel = new HeadingElement.h2()
    ..text = 'Scenario';

  final HeadingElement preconditionLabel = new HeadingElement.h2()
    ..text = 'Preconditions';

  final HeadingElement postconditionLabel = new HeadingElement.h2()
    ..text = 'Postconditions';

  DivElement get element => new DivElement()
    ..classes.add('use-case')
    ..children = [
      _name,
      _description,
      scenarioLabel,
      _scenario,
      preconditionLabel,
      _preconditions,
      postconditionLabel,
      _postconditions
    ];

  /**
   * Default constructor.
   */
  UseCase();

  /**
   * Replace the selected [UseCase] with [uc].
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
