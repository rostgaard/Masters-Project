part of libtcc.base;

abstract class Key {
  static const String identity = 'identity';
  static const String name = 'name';
  static const String description = 'description';
  static const String preconditions = 'preconditions';
  static const String statements = 'statements';
  static const String postconditions = 'postconditions';
  static const String stakeholders = 'stakeholders';
  static const String expression = 'expression';
  static const String matcher = 'matcher';
  static const String expectation = 'expectation';
  static const String type = 'type';
  static const String value = 'value';
  static const String role = 'role';
  static const String anonymous = 'anonymous';
  static const String actor = 'actor';
  static const String action = 'action';
  static const String target = 'target';
}

abstract class Label {
  static const String Stakeholders = 'Stakeholders';
}

class UseCase {
  String        name;
  String        description = 'No description provided';
  String    get identity  => normalize(this.name);

  List<Predicate> preconditions = [];
  StatementList   statements;
  List<Predicate> postconditions = [];
  List<Actor>     stakeholders = [];

  UseCase (this.name);

  UseCase.fromJson (Map map) {

  }

  Map toJson() => {
    Key.identity : identity,
    Key.name : name,
    Key.description : description,
    Key.preconditions : preconditions,
    Key.statements : statements,
    Key.postconditions : postconditions,
    Key.stakeholders : stakeholders
  };

  @override
  String toString () {
    StringBuffer sb = new StringBuffer();
    sb.writeln('# Use Case: ${this.name}');
    sb.writeln('${this.description}');
    sb.writeln('\n## Stakeholders');
    sb.writeln(this.stakeholders.map((Actor stakeholder) =>
        ' * ${stakeholder.type}').join('\n'));

    if (preconditions.isNotEmpty) {
      sb.writeln('\n## Preconditions');
      sb.writeln(this.preconditions.map((Predicate predicate) =>
          ' * ${predicate}').join('\n'));
    }

    if (postconditions.isNotEmpty) {
      sb.writeln('\n## Postconditions');
      sb.writeln(this.postconditions.map((Predicate predicate) =>
          ' * ${predicate}').join('\n'));
    }

    sb.writeln('\n## Scenario');
    sb.writeln(this.statements.map((Statement stmt) => ' * ${stmt}').join('\n'));

    sb.writeln('\n## Analysis');
    sb.writeln('\n### Involved actors');
    sb.writeln(this.involvedActors.map((Actor actor) => ' * ${actor}').join('\n'));

    sb.writeln('\n### Required objects');
    sb.writeln(this.involvedObjects.map((Target actor) => ' * ${actor}').join('\n'));

    sb.writeln('\n### Required matchers');
    sb.writeln(this.involvedMatchers.map((Matcher matcher) => ' * ${matcher} (${matcher.identity}) mapping: ${matcherMappings[matcher.identity]}').join('\n'));

    sb.writeln('\n### Required expressions');
    sb.writeln(this.involvedExpressions.map((Expression expr) => ' * ${expr} (${expr.identity}) mapping: ${expressionMappings[expr.identity]}').join('\n'));

    sb.writeln('\n### Required expectations');
    sb.writeln(this.involvedExpectations.map((Expectation expt) => ' * ${expt} (${expt.identity}) mapping: ${expectationMappings[expt.identity]}').join('\n'));

    return sb.toString();
  }

  String toMarkdown () =>markdownToHtml(this.toString());

  Set<Declaration> get declarations =>
    this.statements.map((Statement stmt) => new Declaration.fromStatement(stmt)).toSet();

  Set<Actor> get involvedActors => (this.statements.map((Statement stmt) => stmt.actor)).toSet();
  Set<Target> get involvedObjects => (this.statements.map((Statement stmt) => stmt.object)).toSet();
  Set<Matcher> get involvedMatchers =>
      (this.postconditions.map((Predicate pred) => pred.matcher)).toSet();

  Set<Expression> get involvedExpressions =>
      (this.postconditions.map((Predicate pred) => pred.expr)).toSet();

  Set<Expectation> get involvedExpectations =>
      (this.postconditions.map((Predicate pred) => pred.expectation)).toSet();
}
