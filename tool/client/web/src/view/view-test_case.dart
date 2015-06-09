part of tcc.client.view;

class TestCase {
  final HeadingElement _name = new HeadingElement.h1();
  final ParagraphElement _description = new ParagraphElement();
  final PreElement _code = new PreElement();

  DivElement get element => new DivElement()
    ..classes.add('test-case')
    ..children = [
      _name,
      _code
    ];

  /**
   * Default constructor.
   */
  TestCase();

  /**
   * Replace the selected [UseCase] with [uc].
   */
  void set selectedUseCase(libtcc.UseCase uc) {
    _name.text = uc.name;
    _description.text = uc.description;
    _code.text = libtcc.toTestCase(uc);
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
