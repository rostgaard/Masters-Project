part of tcc.client.view;

///TODO: implement.
class UseCase {
  final HeadingElement _name = new HeadingElement.h1();
  final ParagraphElement _description = new ParagraphElement();
  final UListElement _scenario = new UListElement();

  DivElement get element => new DivElement()
    ..classes.add('use-case')
    ..children = [_name, _description, _scenario];

  /**
   * Default constructor.
   */
  UseCase();

  /**
   * Replace the selected [UseCase] with [uc].
   */
  void set selectedUseCase(libtcc.UseCase uc) {
    _name.text = uc.name;
    _description.text = uc.description;
    _scenario.children =
        uc.statements.map(_statementToLI).toList(growable: false);
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
